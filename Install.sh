#!/bin/bash

# Nombre del entorno virtual
VENV_DIR="venv"

# Verificar si requirements.txt existe
if [ ! -f requirements.txt ]; then
    echo "[!] El archivo requirements.txt no se encontró. Creando el archivo..."
    echo "selenium==4.24.0" > requirements.txt
    echo "[+] requirements.txt ha sido creado con el contenido necesario."
fi

# Verificar si el entorno virtual ya existe
if [ ! -d "$VENV_DIR" ]; then
    echo "[+] No se encontró el entorno virtual. Creándolo..."
    python3 -m venv "$VENV_DIR"
    echo "[+] Entorno virtual creado."
fi

# Activar el entorno virtual
source "$VENV_DIR/bin/activate"

# Instalar dependencias de Python dentro del entorno virtual
echo "[+] Instalando dependencias de Python dentro del entorno virtual..."
pip install -r requirements.txt

# Descargar e instalar Geckodriver si no está disponible
if ! command -v geckodriver &> /dev/null
then
    echo "[+] Geckodriver no encontrado, descargando..."
    wget https://github.com/mozilla/geckodriver/releases/download/v0.31.0/geckodriver-v0.31.0-linux64.tar.gz
    tar -xvzf geckodriver-v0.31.0-linux64.tar.gz
    sudo mv geckodriver /usr/local/bin/
    rm geckodriver-v0.31.0-linux64.tar.gz
else
    echo "[+] Geckodriver ya está instalado."
fi

echo "[+] Configuración completada. Ahora puedes ejecutar el script."

# Desactivar el entorno virtual al finalizar
deactivate
