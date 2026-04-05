# 1. Aşama: Derleme
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# GitHub'daki her şeyi kopyala
COPY . .

# Projeyi derle ve paketle
RUN dotnet publish $(find . -name "*.csproj") -c Release -o /app/publish

# 2. Aşama: Çalıştırma (ASP.NET tam paketi)
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

# Derlenen dosyaları kopyala
COPY --from=build /app/publish .

# UYGULAMAYI BAŞLAT (İsim FilmDunyasi olarak ayarlandı)
ENTRYPOINT ["dotnet", "FilmDunyasi.dll"]
