# ===========================
# Build Stage
# ===========================
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /app
# COPY *.sln ./
COPY *.csproj .
RUN dotnet restore
COPY . .
RUN dotnet publish . \
    -c Release \
    -o /app/publish \
    --no-restore
# ===========================
# Runtime Stage
# ===========================
FROM mcr.microsoft.com/dotnet/runtime:7.0
WORKDIR /app
COPY --from=build /app/publish .
RUN groupadd -g 1001 appgroup && \
    useradd -u 1001 -g appgroup -M -s /usr/sbin/nologin appuser && \
    chown -R 1001:1001 /app
USER 1001
ENTRYPOINT ["dotnet", "Worker.dll"]