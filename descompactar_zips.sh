#!/bin/bash

# Função para descompactar um arquivo zip
descompactar_zip() {
  local arquivo="$1"
  local pasta="${arquivo%.zip}"
  mkdir -p "$pasta"
  unzip "$arquivo" -d "$pasta"
  echo "Arquivo $arquivo descompactado na pasta $pasta"
}

# Verifica se o número de argumentos é válido
if [ "$#" -eq 0 ]; then
  echo "Uso: $0 [-r] arquivo1.zip arquivo2.zip ..."
  exit 1
fi

# Verifica se o parâmetro -r (recursivo) foi fornecido
if [ "$1" == "-r" ]; then
  # Caso sim, o script será executado de forma recursiva para procurar arquivos zip
  shift
  # Utiliza o comando find para procurar arquivos zip nos subdiretórios
  while IFS= read -r -d '' arquivo; do
    if [[ "$arquivo" == *.zip ]]; then
      descompactar_zip "$arquivo"
    fi
  done < <(find . -type f -name "*.zip" -print0)
else
  # Caso não, o script será executado normalmente com os arquivos zip fornecidos
  for arquivo in "$@"; do
    if [[ "$arquivo" == *.zip ]]; then
      descompactar_zip "$arquivo"
    fi
  done
fi
