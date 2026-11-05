name: Compilar Switch Toolbox

on:
  workflow_dispatch:

jobs:
  build:
    runs-on: windows-2022
    steps:
      - name: Obtener codigo
        uses: actions/checkout@v4

      - name: Preparar MSBuild
        uses: microsoft/setup-msbuild@v2

      - name: Preparar NuGet
        uses: NuGet/setup-nuget@v2

      - name: Restaurar paquetes
        run: nuget restore Toolbox.sln -NonInteractive

      - name: Compilar version Release
        run: msbuild Toolbox.sln /m /p:Configuration=Release /p:Platform="Any CPU" /verbosity:minimal

      - name: Empaquetar compilacion
        if: success()
        uses: actions/upload-artifact@v4
        with:
          name: Switch-Toolbox-Release
          path: Toolbox/bin/Release/**
          if-no-files-found: error
