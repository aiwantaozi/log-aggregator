FROM mcr.microsoft.com/powershell:nanoserver-1809

SHELL ["pwsh", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV LOG_AGGREGATOR_PATH C:\\log-aggregator\\bin

RUN New-Item -ItemType Directory -Path $Env:LOG_AGGREGATOR_PATH ;

COPY deploy.ps1 ${LOG_AGGREGATOR_PATH}\\deploy.ps1

COPY log-aggregator.exe ${LOG_AGGREGATOR_PATH}\\log-aggregator.exe

WORKDIR $LOG_AGGREGATOR_PATH

# ENTRYPOINT ["C:\\log-aggregator\\bin\\deploy.ps1"]

CMD ["pwsh", "-f", "deploy.ps1"]
