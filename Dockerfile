# Etapa 1: Construcción
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copia los archivos de proyecto (.csproj) y restaura las dependencias
COPY *.csproj .
RUN dotnet restore

# Copia todo el contenido del proyecto y construye la aplicación
COPY . .
RUN dotnet publish -c Release -o /app/publish

# Etapa 2: Imagen final para ejecución
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

# Copia el resultado del build desde la etapa anterior
COPY --from=build /app/publish .

# Expone el puerto 80
EXPOSE 80

# Comando para ejecutar la aplicación
ENTRYPOINT ["dotnet", "ecomarket-servicio-resenias.dll"]
