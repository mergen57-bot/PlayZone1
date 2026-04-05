# 1. Aşama: Derleme
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY . .
RUN dotnet publish $(find . -name "*.csproj") -c Release -o /app/publish

# 2. Aşama: Çalıştırma
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/publish .

# HATAYI EKRANDA GÖRMEK İÇİN BU SATIRI EKLEDİK
ENV ASPNETCORE_ENVIRONMENT=Development

ENTRYPOINT ["dotnet", "FilmDunyasi.dll"]
