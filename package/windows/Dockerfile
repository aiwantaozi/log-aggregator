FROM mcr.microsoft.com/powershell:nanoserver-1809

COPY deploy.ps1 C:\log-aggregator\bin\deploy.ps1

COPY log-aggregator.exe C:\log-aggregator\bin\log-aggregator.exe

ENTRYPOINT ["/deploy.ps1"]
