# 1. Aşama: Derleme (SDK 8.0)
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# GitHub'daki tüm dosyaları kopyala
COPY . .

# Projeyi bul, bağımlılıkları çöz ve yayınla
RUN dotnet restore $(find . -name "*.csproj")
RUN dotnet publish $(find . -name "*.csproj") -c Release -o /app/out

# 2. Aşama: Çalıştırma (Runtime 8.0)
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

# Derlenen dosyaları kopyala
COPY --from=build /app/out .

# Uygulamayı otomatik bul ve başlat
ENTRYPOINT ["sh", "-c", "dotnet $(ls *.dll | head -n 1)"]
