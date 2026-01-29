# docker-multi-log

Docker 컨테이너 로그를 동시에 팔로우하면서 컨테이너별로 색상을 구분해 보여주는 간단한 CLI입니다.
`install-docker-muitl-log.sh` 스크립트를 실행하면 `/usr/local/bin/docker-multilog` 커맨드가 설치됩니다.

---

## 한국어 (Korean)

### 기능
- 여러 컨테이너의 로그를 동시에 `-f`(follow) 모드로 출력
- 컨테이너 이름(또는 ID)별 색상 프리픽스 표시
- 기본값으로 `service-` 로 시작하는 컨테이너만 자동 수집

### 요구사항
- macOS 또는 Linux
- `bash`
- `docker` CLI
- `/usr/local/bin` 에 쓰기 권한을 위한 `sudo`

### 설치 방법
```bash
chmod +x install-docker-muitl-log.sh
./install-docker-muitl-log.sh
```

설치가 완료되면 다음 명령어가 생성됩니다.
```bash
/usr/local/bin/docker-multilog
```

### 사용법
#### 1) 기본 모드 (자동 대상)
`service-` 로 시작하는 모든 실행 중인 컨테이너의 로그를 동시에 팔로우합니다.
```bash
docker-multilog
```

#### 2) 특정 컨테이너 지정
컨테이너 **이름** 또는 **ID** 를 명시적으로 지정합니다.
```bash
docker-multilog --container service-api service-worker
```

```bash
docker-multilog --container 3f2a1c9b6d8a 9a0b7c2d1e3f
```

### 동작 방식
- 내부적으로 각 컨테이너에 대해 `docker logs -f <컨테이너>` 를 실행합니다.
- 로그 라인 앞에 `[컨테이너명]` 프리픽스를 붙이고 색상을 입힙니다.
- 종료하려면 `Ctrl + C` 를 누르세요.

### 문제 해결
- `docker: command not found` → Docker가 설치되어 있고 `PATH` 에 포함되어 있는지 확인하세요.
- `permission denied` → `install-docker-muitl-log.sh` 실행 시 `sudo` 권한이 필요합니다.
- `container not found` → 컨테이너 이름/ID가 정확한지 확인하세요.

---

## English

### Features
- Follow multiple containers simultaneously (`-f` mode)
- Color-coded prefixes per container
- By default, auto-targets containers whose names start with `service-`

### Requirements
- macOS or Linux
- `bash`
- `docker` CLI
- `sudo` permission to write to `/usr/local/bin`

### Installation
```bash
chmod +x install-docker-muitl-log.sh
./install-docker-muitl-log.sh
```

After installation, this command is created:
```bash
/usr/local/bin/docker-multilog
```

### Usage
#### 1) Default mode (auto targets)
Follows logs of all running containers whose names start with `service-`.
```bash
docker-multilog
```

#### 2) Specify containers explicitly
Provide container **names** or **IDs**.
```bash
docker-multilog --container service-api service-worker
```

```bash
docker-multilog --container 3f2a1c9b6d8a 9a0b7c2d1e3f
```

### How it works
- Internally runs `docker logs -f <container>` for each target.
- Prefixes each log line with `[container-name]` in a unique color.
- Press `Ctrl + C` to stop.

### Troubleshooting
- `docker: command not found` → Ensure Docker is installed and in your `PATH`.
- `permission denied` → You need `sudo` to run `install-docker-muitl-log.sh`.
- `container not found` → Check the container name/ID.
