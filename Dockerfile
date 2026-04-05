# 1. Aşama: Derleme
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Tüm dosyaları kopyala
COPY . .

# Projeyi bul ve yayınla (Klasör ismi ne olursa olsun otomatik bulur)
RUN dotnet publish -c Release -o /out

# 2. Aşama: Çalıştırma
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /out .

# DİKKAT: Eğer projenin adı FilmDunyasi değilse burayı değiştir!
ENTRYPOINT ["dotnet", "FilmDunyasi.dll"]
