#!/bin/bash
echo "Configurando MegaToolkit..."
chmod +x toolkit.sh
echo "alias toolkit='$(pwd)/toolkit.sh'" >> ~/.zshrc
echo "Instalación completada. Reinicia tu terminal y escribe 'toolkit'."
