#!/bin/bash

# Verificar si python3-venv está instalado
if ! dpkg -l | grep -q python3-venv; then
    echo "[+] El paquete python3-venv no está instalado. Instalándolo..."
    sudo apt update
    sudo apt install -y python3-venv
    
    # Verificar si la instalación fue exitosa
    if [ $? -ne 0 ]; then
        echo "[!] Error al instalar python3-venv. Asegúrate de tener permisos sudo."
        exit 1
    fi
else
    echo "[+] python3-venv ya está instalado."
fi

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
    
    # Verificar si la creación fue exitosa
    if [ $? -ne 0 ]; then
        echo "[!] Error al crear el entorno virtual."
        exit 1
    fi

    echo "[+] Entorno virtual creado."
fi

# Activar el entorno virtual
if [ -f "$VENV_DIR/bin/activate" ]; then
    source "$VENV_DIR/bin/activate"
else
    echo "[!] No se pudo activar el entorno virtual. Verifica si se creó correctamente."
    exit 1
fi

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

echo "[+] Configuración completada. El entorno virtual sigue activado. Puedes ejecutar el script ahora."
