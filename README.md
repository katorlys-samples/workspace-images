<a name="readme-top"></a>
<div align="center">

<!-- <a href="#">
  <img src="https://github.com/katorlys/.github/blob/main/assets/mark/mark.png" height="100">
</a><br> -->

<h1>
  Workspace Images
</h1>

<p>
  🐋 Ready-to-use Docker images for development workspaces.
</p>

[![Pull Requests][github-pr-badge]][github-pr-link]
[![Issues][github-issue-badge]][github-issue-link]
[![License][github-license-badge]](LICENSE)

</div>


<!-- Main Body -->

## Introduction
A set of ready-to-use Docker images for development workspaces.

These well-tested images are designed to provide a consistent and isolated environment for developers, making it easier to set up development environments across different projects. 🎁

Pull requests are welcome! If you have any suggestions or improvements, please feel free to contribute.

## Usage
### DevContainer
```json
{
    "name": "<container-name>",
    "image": "katorlys/workspace-<image-name>",
    "postStartCommand": "",
}
```

### Docker
```sh
docker run -it katorlys/workspace-<image-name>
```
or
```sh
docker run -itd --name <container-name> katorlys/workspace-<image-name>
docker exec -it <container-name> /bin/bash
```
### Docker Compose
```yml
services:
  <container-name>:
    image: katorlys/workspace-<image-name>
    container_name: <container-name>
    restart: unless-stopped
    volumes:
      - ./workspace:/workspace
```
and then
```sh
docker compose up -d
docker compose exec <container-name> /bin/bash
```

## Build
```sh
docker build --no-cache -t katorlys/workspace-<image-name>:<current-date> <folder-path>
```

## Publish
```sh
docker tag katorlys/workspace-<image-name>:<current-date> katorlys/workspace-<image-name>:latest
docker push katorlys/workspace-<image-name>:<current-date>
docker push katorlys/workspace-<image-name>:latest
```

<!-- /Main Body -->


<div align="right">
  
[![BACK TO TOP][back-to-top-button]](#readme-top)

</div>

---

<div align="center">

<p>
  Copyright &copy; 2024-present <a target="_blank" href="https://github.com/katorlys">Katorly Lab</a>
</p>

[![License][github-license-badge-bottom]](LICENSE)

</div>

[back-to-top-button]: https://img.shields.io/badge/BACK_TO_TOP-151515?style=flat-square
[github-pr-badge]: https://img.shields.io/github/issues-pr/katorlys-samples/workspace-images?label=pulls&labelColor=151515&color=79E096&style=flat-square
[github-pr-link]: https://github.com/katorlys-samples/workspace-images/pulls
[github-issue-badge]: https://img.shields.io/github/issues/katorlys-samples/workspace-images?labelColor=151515&color=FFC868&style=flat-square
[github-issue-link]: https://github.com/katorlys-samples/workspace-images/issues
[github-license-badge]: https://img.shields.io/github/license/katorlys-samples/workspace-images?labelColor=151515&color=EFEFEF&style=flat-square
<!-- https://img.shields.io/badge/license-CC_BY--NC--SA_4.0-EFEFEF?labelColor=151515&style=flat-square -->
[github-license-badge-bottom]: https://img.shields.io/github/license/katorlys-samples/workspace-images?labelColor=151515&color=EFEFEF&style=for-the-badge
<!-- https://img.shields.io/badge/license-CC_BY--NC--SA_4.0-EFEFEF?labelColor=151515&style=for-the-badge -->
