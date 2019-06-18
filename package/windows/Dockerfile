FROM mcr.microsoft.com/powershell:nanoserver-1809

SHELL ["pwsh", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN New-Item -ItemType Directory -Path "C:\log-aggregator\bin";

COPY deploy.ps1 C:\log-aggregator\bin\deploy.ps1

COPY log-aggregator.exe C:\log-aggregator\bin\log-aggregator.exe

WORKDIR C:\log-aggregator\bin

ENTRYPOINT ["C:\\log-aggregator\\bin\\deploy.ps1"]
