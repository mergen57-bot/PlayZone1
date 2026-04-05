# 1. Aşama: Derleme (Build)
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Dosyaları kopyala
COPY . .

# Projeyi bul ve yayınla
RUN dotnet restore $(find . -name "*.csproj")
RUN dotnet publish $(find . -name "*.csproj") -c Release -o /app/publish

# 2. Aşama: Çalıştırma (Runtime)
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/publish .

# ÖNEMLİ: Uygulamayı otomatik bulup çalıştıran sihirli komut
ENTRYPOINT ["sh", "-c", "dotnet $(ls *.dll | head -n 1)"]
