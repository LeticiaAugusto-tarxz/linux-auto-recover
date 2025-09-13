#!/bin/bash
# Script simples para verificar e reiniciar containers Docker parados

# Lista todos os containers que estão parados
containers=$(docker ps -a -f "status=exited" -q)

if [ -n "$containers" ]; then
  echo "Reiniciando containers parados..."
  for c in $containers; do
    docker restart "$c"
  done
else
  echo "Nenhum container precisa ser reiniciado."
fi
