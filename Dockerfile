# Build stage - use .NET 8 SDK
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

COPY . .
RUN dotnet restore
RUN dotnet publish -c Release -o /app/publish

# Runtime stage - .NET 8 ASP.NET runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/publish .

# NOTE: use the actual DLL name from your project (likely HelloWorld.dll)
ENTRYPOINT ["dotnet", "HelloWorld.dll"]
