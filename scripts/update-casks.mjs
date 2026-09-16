import { createHash } from 'node:crypto';
import { mkdir, writeFile } from 'node:fs/promises';
import { fileURLToPath } from 'node:url';

// Only release assets from these two upstream repositories are accepted.
const apps = [
  { token: 'containbar', repo: 'containbar', name: 'Containbar', desc: 'Manage Docker, Colima, and Apple containers from the menu bar',
    pattern: /^(Containbar|Docker[. ]Tray)_([0-9]+\.[0-9]+\.[0-9]+)_aarch64\.dmg$/, bundles: { Containbar: 'Containbar.app', 'Docker.Tray': 'Docker Tray.app', 'Docker Tray': 'Docker Tray.app' }, clearQuarantine: true },
  { token: 'simple-note', repo: 'simple-note', name: 'Simple Note', desc: 'Text and Markdown editor for focused writing',
    pattern: /^(Note)_([0-9]+\.[0-9]+\.[0-9]+)_aarch64\.dmg$/, bundles: { Note: 'Note.app' } },
];
const directory = fileURLToPath(new URL('../Casks/', import.meta.url));
await mkdir(directory, { recursive: true });

for (const app of apps) {
  const headers = { Accept: 'application/vnd.github+json', 'User-Agent': 'yurseria-homebrew-tap' };
  if (process.env.GH_TOKEN) headers.Authorization = `Bearer ${process.env.GH_TOKEN}`;
  const response = await fetch(`https://api.github.com/repos/yurseria/${app.repo}/releases/latest`, { headers, signal: AbortSignal.timeout(30000) });
  if (!response.ok) throw new Error(`${app.repo}: GitHub API ${response.status}`);
  const release = await response.json();
  if (release.draft || release.prerelease || !/^v\d+\.\d+\.\d+$/.test(release.tag_name)) throw new Error('Expected a stable version tag');
  const candidates = release.assets.filter(asset => app.pattern.test(asset.name) && asset.state === 'uploaded');
  // Releases are created before packaging finishes; retry at the next schedule.
  if (candidates.length === 0) {
    console.log(`${app.repo}: no ready Apple Silicon DMG; retaining current cask`);
    continue;
  }
  if (candidates.length !== 1) throw new Error(`${app.repo}: ambiguous DMG assets`);
  const asset = candidates[0];
  const match = asset.name.match(app.pattern);
  const version = release.tag_name.slice(1);
  if (match[2] !== version) throw new Error('Asset version does not match release tag');
  const url = `https://github.com/yurseria/${app.repo}/releases/download/${release.tag_name}/${asset.name}`;
  if (asset.browser_download_url !== url) throw new Error('Unexpected asset URL');
  const download = await fetch(url, { signal: AbortSignal.timeout(180000) });
  if (!download.ok) throw new Error(`Download failed: ${download.status}`);
  const hash = createHash('sha256');
  let size = 0;
  for await (const chunk of download.body) { hash.update(chunk); size += chunk.length; }
  if (size !== asset.size) throw new Error('Download size mismatch');
  const sha = hash.digest('hex');
  if (asset.digest && asset.digest !== `sha256:${sha}`) throw new Error('GitHub asset digest mismatch');
  const bundle = app.bundles[match[1]];
  const legacy = bundle === 'Docker Tray.app';
  const postflight = app.clearQuarantine ? `
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/${bundle}"],
                   sudo: false
  end
` : '';
  const gatekeeperCaveat = app.clearQuarantine
    ? '    This cask removes its quarantine attribute after installation.\n    Install it only if you trust this app and its source.'
    : '    If macOS blocks it, open System Settings > Privacy & Security > Open Anyway\n    only if you trust this app and its source. This cask does not bypass Gatekeeper.';
  const legacyCaveat = legacy ? '\n    This release still installs Docker Tray.app; Containbar is its new name.' : '';
  const cask = `cask "${app.token}" do
  version "${version}"
  sha256 "${sha}"

  url "${url}"
  name "${app.name}"
  desc "${app.desc}"
  homepage "https://github.com/yurseria/${app.repo}"

  depends_on arch: :arm64
  depends_on macos: :ventura

  app "${bundle}"
${postflight}
  caveats <<~EOS
    This app is not Developer ID signed or notarized.
${gatekeeperCaveat}${legacyCaveat}
  EOS
end
`;
  await writeFile(`${directory}${app.token}.rb`, cask);
  console.log(`${app.token}: ${version} (${bundle}), SHA-256 verified`);
}
