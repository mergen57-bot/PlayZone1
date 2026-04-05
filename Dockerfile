# 1. Aşama: Derleme (SDK 8.0 - En sağlam sürüm)
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# GitHub'daki tüm dosyaları kopyala
COPY . .

# Projeyi bul ve bağımlılıkları yükle
RUN dotnet restore $(find . -name "*.csproj")

# Projeyi derle ve /app/out klasörüne çıkar
RUN dotnet publish $(find . -name "*.csproj") -c Release -o /app/out

# 2. Aşama: Çalıştırma (Runtime 8.0)
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

# Derlenen dosyaları kopyala
COPY --from=build /app/out .

# ÖNEMLİ: Projeni çalıştıracak ana dosya
ENTRYPOINT ["dotnet", "FilmDunyasi.dll"]
