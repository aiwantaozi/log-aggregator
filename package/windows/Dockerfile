FROM mcr.microsoft.com/powershell:nanoserver-1809

COPY out/configmap-reload-windows-amd64.exe /configmap-reload-windows-amd64.exe
COPY out/configmap-reload-windows-amd64.exe /configmap-reload-windows-amd64.exe


COPY deploy.ps1 C:\log-aggregator\bin\deploy.ps1
COPY log-aggregator.exe C:\log-aggregator\bin\log-aggregator.exe

ENTRYPOINT ["/deploy.ps1"]
