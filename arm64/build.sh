#!/bin/bash
LINGLONG_APPID=io.jgraph.drawio-desktop
APPIMAGE_URL=https://github.com/jgraph/drawio-desktop/releases/download/v28.2.5/drawio-arm64-28.2.5.AppImage
sudo apt install libfuse2t64 wget -y

cd linglong/sources

rm -rf ${LINGLONG_APPID}
wget -O target.AppImage ${APPIMAGE_URL}
chmod +x target.AppImage && ./target.AppImage --appimage-extract

cd squashfs-root && rm -rf .DirIcon AppRun drawio.png drawio.desktop usr

cd .. && mv squashfs-root ${LINGLONG_APPID}

cd ../..

ll-builder build --skip-output-check && ll-builder export --layer -z lzma
