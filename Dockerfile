# 1. Aşama: Derleme
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Tüm dosyaları kopyala
COPY . .

# Projeyi derle ve doğrudan /app/publish içine at
RUN dotnet publish -c Release -o /app/publish

# 2. Aşama: Çalıştırma
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

# Derlenen her şeyi kopyala
COPY --from=build /app/publish .

# ÖNEMLİ: Uygulamayı çalıştıracak ana dosya (İsim tam tutmalı)
ENTRYPOINT ["dotnet", "FilmDunyasi.dll"]
