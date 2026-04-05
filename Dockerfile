# 1. Aşama: Derleme (Build)
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# GitHub'daki tüm dosyaları (klasörler dahil) kopyala
COPY . .

# Hangi klasörde olursan ol, .csproj dosyasını bul ve bağımlılıkları yükle
RUN dotnet restore $(find . -name "*.csproj")

# Projeyi bul ve derleyip /app/publish klasörüne çıkar
RUN dotnet publish $(find . -name "*.csproj") -c Release -o /app/publish

# 2. Aşama: Çalıştırma (Runtime)
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/publish .

# ÇIKTI OLARAK OLUŞAN DLL DOSYASINI BUL VE BAŞLAT
ENTRYPOINT ["sh", "-c", "dotnet $(ls *.dll | head -n 1)"]
