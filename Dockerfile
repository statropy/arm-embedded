FROM ubuntu:latest

# Install necessary tools
RUN apt-get update && apt-get install -y \
    wget \
    xz-utils \
    && rm -rf /var/lib/apt/lists/*

# Download and install ARM Embedded Toolchain
RUN wget -q https://developer.arm.com/-/media/Files/downloads/gnu/13.2.rel1/binrel/arm-gnu-toolchain-13.2.rel1-x86_64-arm-none-eabi.tar.xz \
    && tar xf arm-gnu-toolchain-13.2.rel1-x86_64-arm-none-eabi.tar.xz -C /opt \
    && rm arm-gnu-toolchain-13.2.rel1-x86_64-arm-none-eabi.tar.xz

# Add toolchain to PATH
ENV PATH="/opt/arm-gnu-toolchain-13.2.rel1-x86_64-arm-none-eabi/bin:${PATH}"

# Verify installation
RUN arm-none-eabi-gcc --version
