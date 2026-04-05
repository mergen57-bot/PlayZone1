# SDK imajını kullanarak projeyi derleyelim
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Dosyaları kopyala ve geri yükle
COPY . .
RUN dotnet restore "FilmDunyasi.sln"

# Yayınla
RUN dotnet publish "FilmDunyasi/FilmDunyasi.csproj" -c Release -o /app/publish

# Çalışma zamanı imajına geçelim
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/publish .

# Uygulamayı başlat (Dll adın FilmDunyasi değilse burayı düzelt)
ENTRYPOINT ["dotnet", "FilmDunyasi.dll"]
