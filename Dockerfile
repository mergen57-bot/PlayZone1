# 1. Aşama: Derleme (Build)
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# GitHub'daki tüm dosyaları kopyala
COPY . .

# Proje dosyasını OTOMATİK BUL ve derle
RUN dotnet publish $(find . -name "*.csproj") -c Release -o /app/publish

# 2. Aşama: Çalıştırma (Runtime)
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/publish .

# Çalıştırılacak DLL dosyasını OTOMATİK BUL ve başlat
ENTRYPOINT ["sh", "-c", "dotnet $(ls *.dll | head -n 1)"]
