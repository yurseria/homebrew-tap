# Yurseria Homebrew Tap

[English](README.md) / 한국어

[Containbar](https://github.com/yurseria/containbar), [Simple Note](https://github.com/yurseria/simple-note), [맥타마톤](https://github.com/yurseria/mactamatone)을 위한 Homebrew Cask 저장소입니다.

## 설치

Homebrew와 Apple Silicon 맥이 필요합니다. Containbar와 Simple Note는 macOS 13 이상, 맥타마톤은 macOS 14 이상을 지원합니다.

```sh
brew install --cask yurseria/tap/containbar
brew install --cask yurseria/tap/simple-note
brew install --cask yurseria/tap/mactamatone
```

Containbar는 현재 `Docker Tray.app`, Simple Note는 `Note.app`, 맥타마톤은 `Mactamatone.app`으로 설치됩니다. 같은 앱을 수동으로 설치했다면 앱을 종료하고 기존 번들을 Applications 밖으로 옮긴 후 Cask를 설치하세요.

## 서명과 최초 실행

이 앱들은 Developer ID 서명 및 Apple 공증이 되어 있지 않습니다. Cask는 다운로드 파일의 SHA-256 체크섬을 검증하고, 설치 후 앱의 격리 속성을 제거합니다. 체크섬은 서명·공증을 대체하지 않습니다. 앱 소스와 이 Tap을 신뢰하는 경우에만 설치하세요.

## 업데이트 및 제거

```sh
brew update
brew upgrade --cask yurseria/tap/containbar yurseria/tap/simple-note yurseria/tap/mactamatone
brew uninstall --cask yurseria/tap/mactamatone
```

Cask 제거 시 앱 번들만 삭제하며 문서와 설정은 유지합니다.

## 관리

GitHub Actions가 6시간마다 각 앱의 최신 정식 릴리스를 확인합니다. Apple Silicon DMG를 다운로드해 크기와 GitHub 다이제스트를 확인하고 SHA-256을 계산한 뒤 Cask를 갱신합니다. 릴리스 파일이 아직 없으면 다음 실행에서 재시도하며, 예상하지 못한 파일명이나 중복 파일은 오류로 처리합니다. 워크플로를 수동으로 실행할 수도 있습니다. 로컬 갱신에는 Node.js 22 이상에서 `node scripts/update-casks.mjs`를 사용합니다.
