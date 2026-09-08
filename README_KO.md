# Yurseria Homebrew Tap

[English](README.md) / 한국어

Containbar와 Simple Note를 위한 개인 Homebrew Cask 저장소입니다.

## 설치

Homebrew, macOS 13 이상, Apple Silicon이 필요합니다. 현재 이 Tap은 Intel용 빌드를 제공하지 않습니다.

```sh
brew install --cask yurseria/tap/containbar
brew install --cask yurseria/tap/simple-note
```

`--cask`는 명령줄 도구 대신 GUI 앱 패키지를 설치하는 옵션입니다. 개인 Tap 신뢰 여부를 물으면 내용을 확인하고 승인하세요.

Containbar v0.6.0은 아직 **Docker Tray.app**으로 배포됩니다. 새 이름의 릴리스가 나오면 자동 전환됩니다. Simple Note는 **Note.app**으로 설치됩니다. 수동 설치한 동일 앱이 있다면 앱을 종료하고 기존 앱 번들을 백업하거나 Applications 밖으로 옮겨 충돌을 피하세요. 설정이나 문서는 삭제할 필요가 없습니다.

## 서명 없는 앱의 최초 실행

두 앱은 Developer ID 서명 및 공증이 되어 있지 않습니다. Homebrew 설치가 Apple의 검증을 대신하지 않습니다. 신뢰하는 앱이 macOS에 차단된다면 **시스템 설정 → 개인정보 보호 및 보안 → 확인 없이 열기**로 허용하세요. [Apple 안내](https://support.apple.com/en-us/102445)

이 Tap은 quarantine을 제거하거나 Gatekeeper를 끄지 않습니다. SHA-256은 다운로드 무결성을 확인할 뿐 서명·공증을 대체하지 않습니다. 관리형 Mac에서는 실행 예외가 제한될 수 있습니다.

## 업데이트 및 제거

```sh
brew update
brew upgrade --cask yurseria/tap/containbar yurseria/tap/simple-note
brew uninstall --cask yurseria/tap/containbar
brew uninstall --cask yurseria/tap/simple-note
```

제거 시 앱 번들만 제거하며 문서·설정은 유지합니다.

## 자동 갱신

6시간마다 최신 정식 릴리스의 Apple Silicon DMG를 확인하고, 다운로드한 파일의 SHA-256과 GitHub 체크섬을 대조하여 Cask를 갱신합니다. Actions에서 수동 실행도 가능합니다. 별도 저장소 접근 토큰은 필요하지 않습니다. 빌드 중 파일이 없으면 다음 실행에 재시도하며, 예상하지 못한 파일명은 오류로 처리합니다. 장기간 활동이 없으면 GitHub가 예약 실행을 중지할 수 있으므로 업데이트가 멈추면 워크플로를 다시 활성화하세요.
