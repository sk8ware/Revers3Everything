
```python
#!/bin/bash

# Verificar si requirements.txt existe
if [ ! -f requirements.txt ]; then
    echo "[!] El archivo requirements.txt no se encontró. Creando el archivo..."
    echo "selenium==4.24.0" > requirements.txt
    echo "[+] requirements.txt ha sido creado con el contenido necesario."
fi

# Instalar dependencias de Python
echo "[+] Instalando dependencias de Python..."
pip3 install -r requirements.txt

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

```