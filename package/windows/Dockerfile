FROM mcr.microsoft.com/powershell:nanoserver-1809

SHELL ["pwsh", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV LOG_AGGREGATOR_PATH C:\\log-aggregator\\bin

RUN New-Item -ItemType Directory -Path $Env:LOG_AGGREGATOR_PATH ;

COPY deploy.ps1 $Env:LOG_AGGREGATOR_PATH\deploy.ps1

COPY log-aggregator.exe $Env:LOG_AGGREGATOR_PATH\deploy.ps1\log-aggregator.exe

WORKDIR $LOG_AGGREGATOR_PATH

ENTRYPOINT ["deploy.ps1"]
