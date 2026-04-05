# 1. Aşama: Derleme (Build)
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# GitHub'daki tüm dosyaları kopyala
COPY . .

# PROJEYİ TÜM KÜTÜPHANELERİYLE TEK BİR PAKET YAP (Self-Contained)
RUN dotnet publish $(find . -name "*.csproj") -c Release -o /app/publish \
    --runtime linux-x64 --self-contained true /p:PublishSingleFile=true

# 2. Aşama: Çalıştırma (Runtime - Bağımsız mod)
FROM mcr.microsoft.com/dotnet/runtime:8.0
WORKDIR /app
COPY --from=build /app/publish .

# ÇALIŞTIRILACAK DOSYAYI OTOMATİK BUL VE BAŞLAT
ENTRYPOINT ["sh", "-c", "./$(ls * | grep -v '\.' | head -n 1)"]
