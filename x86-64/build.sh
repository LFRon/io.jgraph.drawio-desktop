#!/bin/bash
LINGLONG_APPID=io.jgraph.drawio-desktop
# 设置AppImage下载链接
APPIMAGE_URL=https://github.com/jgraph/drawio-desktop/releases/download/v28.2.5/drawio-x86_64-28.2.5.AppImage

sudo apt install wget -y

cd linglong/sources
rm -f libs/*
# 再删除过时的应用程序库
rm -rf ${LINGLONG_APPID}
# 调用wget下载AppImage
wget -O target.AppImage ${APPIMAGE_URL}
# 解压AppImage并进入squashfs-root目录
chmod +x target.AppImage && ./target.AppImage --appimage-extract && cd squashfs-root
cp -a usr/lib/* ../libs
# 删除多余文件
rm -rf .DirIcon AppRun drawio.png drawio.desktop usr
cd .. && mv squashfs-root ${LINGLONG_APPID}

ll-builder build --skip-output-check && ll-builder export --layer -z lzma
