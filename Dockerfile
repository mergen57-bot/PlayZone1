# 1. Aşama: Derleme (Build)
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Sadece proje klasörünü kopyalayalım, o karmaşık .slnx dosyasını boşverelim
COPY FilmDunyasi/ ./FilmDunyasi/

# Projenin içine girelim ve bağımlılıkları çözelim
WORKDIR "/src/FilmDunyasi"
RUN dotnet restore

# Projeyi derleyelim ve yayınlayalım
RUN dotnet publish "FilmDunyasi.csproj" -c Release -o /app/publish

# 2. Aşama: Çalıştırma (Runtime)
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/publish .

# Uygulamanın asıl dosyasını başlat
ENTRYPOINT ["dotnet", "FilmDunyasi.dll"]
