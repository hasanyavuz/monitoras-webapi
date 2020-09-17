FROM mcr.microsoft.com/dotnet/core/aspnet:3.1 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /src
COPY ["Monitoras.WebAPI.csproj", "./"]
RUN dotnet restore "./Monitoras.WebAPI.csproj"
COPY . .
RUN dotnet build "Monitoras.WebAPI.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "Monitoras.WebAPI.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Monitoras.WebAPI.dll"]
