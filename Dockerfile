FROM mcr.microsoft.com/powershell:7.4-ubuntu-22.04

LABEL maintainer="VMware Security Team"
LABEL description="VMware vSphere VM CIS Hardening Tool"

RUN apt-get update && apt-get install -y \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

RUN pwsh -Command "Set-PSRepository -Name PSGallery -InstallationPolicy Trusted; Install-Module VMware.PowerCLI -Force"

WORKDIR /app
COPY . .

ENTRYPOINT ["pwsh", "./apply-cis-vm-hardening.ps1"]