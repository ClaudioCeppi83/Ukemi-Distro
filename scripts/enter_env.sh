#!/bin/bash
# Script para entrar en el entorno de construcción aislado

set -e

PROJECT_ROOT=$(pwd)
IMAGE_NAME="ukemi-builder"

echo "🔨 Asegurando que la imagen de construcción esté actualizada..."
docker build -t $IMAGE_NAME -f docker/Dockerfile.builder .

echo "🚀 Entrando en el Sandbox de Ukemi..."
# Montamos las carpetas necesarias
docker run -it --rm \
    -v "$PROJECT_ROOT":/mnt/ukemi \
    -w /mnt/ukemi \
    $IMAGE_NAME
