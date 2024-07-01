FROM --platform=$BUILDPLATFORM ubuntu:latest

# Install necessary tools
RUN apt-get update && apt-get install -y \
    wget \
    xz-utils \
    cmake \
    && rm -rf /var/lib/apt/lists/*

# Download and install ARM Embedded Toolchain
ARG TARGETPLATFORM
RUN case "${TARGETPLATFORM}" in \
      linux/amd64) TOOLCHAIN_URL="https://developer.arm.com/-/media/Files/downloads/gnu/13.2.Rel1/binrel/arm-gnu-toolchain-13.2.Rel1-x86_64-arm-none-eabi.tar.xz" ;; \
      linux/arm64) TOOLCHAIN_URL="https://developer.arm.com/-/media/Files/downloads/gnu/13.2.Rel1/binrel/arm-gnu-toolchain-13.2.Rel1-aarch64-arm-none-eabi.tar.xz" ;; \
      *) echo "Unsupported platform: ${TARGETPLATFORM}" && exit 1 ;; \
    esac && \
    wget -q ${TOOLCHAIN_URL} && \
    tar xf $(basename ${TOOLCHAIN_URL}) -C /opt && \
    rm $(basename ${TOOLCHAIN_URL})

# Add toolchain to PATH
ENV PATH="/opt/arm-gnu-toolchain-13.2.Rel1-$(uname -m)-arm-none-eabi/bin:${PATH}"

RUN env
# Verify installation
RUN arm-none-eabi-gcc --version