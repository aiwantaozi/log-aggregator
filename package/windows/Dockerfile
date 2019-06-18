FROM mcr.microsoft.com/powershell:nanoserver-1809

SHELL ["pwsh", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV LOG_AGGREGATOR_PATH C:\\log-aggregator\\bin

RUN New-Item -ItemType Directory -Path $Env:LOG_AGGREGATOR_PATH ;

COPY deploy.ps1 ${LOG_AGGREGATOR_PATH}\\deploy.ps1

COPY log-aggregator.cmd ${LOG_AGGREGATOR_PATH}\\log-aggregator.cmd

WORKDIR $LOG_AGGREGATOR_PATH

CMD ["pwsh", "-f", "deploy.ps1"]
