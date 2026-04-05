# 1. Aşama: Derleme (Build)
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Dosyaları kopyala
COPY . .

# Projeyi restore et (Solution üzerinden)
RUN dotnet restore "FilmDunyasi.slnx"

# FilmDunyasi klasörünün içine girip projeyi yayınla
WORKDIR "/src/FilmDunyasi"
RUN dotnet publish "FilmDunyasi.csproj" -c Release -o /app/publish

# 2. Aşama: Çalıştırma (Runtime)
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/publish .

# Uygulamayı başlat
ENTRYPOINT ["dotnet", "FilmDunyasi.dll"]
