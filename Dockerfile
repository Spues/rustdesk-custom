# RustDesk 1.4.1 Windows 编译环境
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# 安装基础依赖
RUN apt-get update && apt-get install -y \
    curl \
    git \
    wget \
    unzip \
    xz-utils \
    zip \
    cmake \
    ninja-build \
    pkg-config \
    clang \
    libgtk-3-dev \
    libblkid-dev \
    liblzma-dev \
    libxcb-shape0-dev \
    libxcb-xfixes0-dev \
    libgstreamer1.0-dev \
    libgstreamer-plugins-base1.0-dev \
    gstreamer1.0-libav \
    gstreamer1.0-plugins-base \
    gstreamer1.0-plugins-good \
    mingw-w64 \
    && rm -rf /var/lib/apt/lists/*

# 安装 Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# 添加 Windows 编译目标
RUN rustup target add x86_64-pc-windows-gnu

# 配置 cargo 使用 mingw
RUN mkdir -p ~/.cargo && \
    echo '[target.x86_64-pc-windows-gnu]\nlinker = "x86_64-w64-mingw32-gcc"\n' > ~/.cargo/config.toml

# 安装 Flutter
RUN git clone --depth 1 --branch 3.19.0 https://github.com/flutter/flutter.git /flutter
ENV PATH="/flutter/bin:${PATH}"
ENV FLUTTER_ROOT="/flutter"

# 启用 Flutter Web/Desktop 支持
RUN flutter config --enable-windows-desktop

# 预下载 Flutter 依赖
RUN flutter doctor

# 设置工作目录
WORKDIR /build

# 编译脚本
COPY build.sh /build.sh
RUN chmod +x /build.sh

CMD ["/build.sh"]
