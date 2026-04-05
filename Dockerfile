# 1. Aşama: Derleme (Build) - En güncel SDK'yı kullanıyoruz
FROM mcr.microsoft.com/dotnet/sdk:10.0-preview AS build
WORKDIR /src

# GitHub'daki tüm dosyaları kopyala
COPY . .

# Projeyi bul ve bağımlılıkları yükle
RUN dotnet restore $(find . -name "*.csproj")

# Projeyi derle ve /app/publish klasörüne çıkar
RUN dotnet publish $(find . -name "*.csproj") -c Release -o /app/publish

# 2. Aşama: Çalıştırma (Runtime) - En güncel AspNet sürümü
FROM mcr.microsoft.com/dotnet/aspnet:10.0-preview
WORKDIR /app
COPY --from=build /app/publish .

# ÇIKTI OLARAK OLUŞAN DLL DOSYASINI BUL VE BAŞLAT
ENTRYPOINT ["sh", "-c", "dotnet $(ls *.dll | head -n 1)"]
