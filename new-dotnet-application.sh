#!bin/bash

# $1 - project name

echo "Start project: "$1

mkdir $1

cd $1

echo "Creating solution..."
dotnet new sln -n $1

mkdir "test"
mkdir "source"
cd "source"

echo "Creating projects"
dotnet new classlib -n $1.Application -o "Application/"$1".Application" --no-restore
dotnet new classlib -n $1.Domain -o "Domain/"$1".Domain" --no-restore
dotnet new classlib -n $1.Infra.CrossCutting -o "Infra/CrossCutting/"$1".Infra.CrossCutting" --no-restore
dotnet new classlib -n $1.Infra.Data -o "Infra/Data/"$1".Infra.Data" --no-restore
dotnet new webAPI -n $1.Presentation.Api -o "Presentation/"$1".Presentation.Api" --no-restore
echo "Projects created"

cd ..

dotnet sln add "source/Application/"$1".Application/"$1".Application.csproj"
dotnet sln add "source/Domain/"$1".Domain/"$1".Domain.csproj"
dotnet sln add "source/Infra/CrossCutting/"$1".Infra.CrossCutting/"$1".Infra.CrossCutting.csproj"
dotnet sln add "source/Infra/Data/"$1".Infra.Data/"$1".Infra.Data.csproj"
dotnet sln add "source/Presentation/"$1".Presentation.Api/"$1".Presentation.Api.csproj"

dotnet add "source/Application/"$1".Application/"$1".Application.csproj" reference "source/Domain/"$1".Domain/"$1".Domain.csproj"
dotnet add "source/Infra/Data/"$1".Infra.Data/"$1".Infra.Data.csproj" reference "source/Domain/"$1".Domain/"$1".Domain.csproj"
dotnet add "source/Presentation/"$1".Presentation.Api/"$1".Presentation.Api.csproj" reference "source/Domain/"$1".Domain/"$1".Domain.csproj"
dotnet add "source/Infra/CrossCutting/"$1".Infra.CrossCutting/"$1".Infra.CrossCutting.csproj" reference "source/Domain/"$1".Domain/"$1".Domain.csproj"
dotnet add "source/Infra/CrossCutting/"$1".Infra.CrossCutting/"$1".Infra.CrossCutting.csproj" reference "source/Application/"$1".Application/"$1".Application.csproj"
dotnet add "source/Infra/CrossCutting/"$1".Infra.CrossCutting/"$1".Infra.CrossCutting.csproj" reference "source/Infra/Data/"$1".Infra.Data/"$1".Infra.Data.csproj"
dotnet add "source/Presentation/"$1".Presentation.Api/"$1".Presentation.Api.csproj" reference "source/Infra/CrossCutting/"$1".Infra.CrossCutting/"$1".Infra.CrossCutting.csproj"

dotnet restore

curl http://gitignore.io/api/aspnetcore --output .gitignore