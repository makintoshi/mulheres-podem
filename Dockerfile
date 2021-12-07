# This is a multi-stage build
# Build and publish
FROM mcr.microsoft.com/dotnet/sdk:3.1 as build-env

WORKDIR /app

COPY . .

RUN dotnet publish -c Release -o output

# Create final image
FROM mcr.microsoft.com/dotnet/aspnet:3.1

WORKDIR /app

COPY --from=build-env /app/output .
COPY ./entrypoint.sh .

RUN chmod +x ./entrypoint.sh

ENTRYPOINT "./entrypoint.sh"
