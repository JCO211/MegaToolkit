#!/bin/bash

# --- Configuración de Colores ---
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # Sin color

# --- 1. Efecto de Lluvia Binaria ---
binary_splash() {
    clear
    local lines=15
    local width=$(tput cols)
    for ((i=0; i<lines; i++)); do
        local line=""
        for ((j=0; j<width/2; j++)); do
            line+="$(($RANDOM % 2)) "
        done
        echo -e "${GREEN}${line}${NC}"
        sleep 0.04
    done
    sleep 0.3
    clear
}

# --- 2. Función del Banner con Firma de Autor ---
show_banner() {
    if [ -f ~/MegaToolkit/banner_hacker.txt ]; then
        while IFS= read -r line; do
            if [[ "$line" == *"> Autor: jco11 <"* ]]; then
                echo -e "${CYAN}${line}${NC}" # Firma en Cian
            else
                echo -e "${GREEN}${line}${NC}" # Hacker en Verde
            fi
            sleep 0.01
        done < ~/MegaToolkit/banner_hacker.txt
    else
        echo -e "${RED}[!] Error: banner_hacker.txt no encontrado.${NC}"
    fi
}

# --- 3. Menú Interactivo ---
show_menu() {
    echo -e "${BLUE}======================================================${NC}"
    echo -e "${YELLOW}           MEGA TOOLKIT V1.0 | OPERACIONES            ${NC}"
    echo -e "${BLUE}======================================================${NC}"
    echo -e " 1) ${GREEN}Nmap${NC}          - Escaneo de red y puertos"
    echo -e " 2) ${GREEN}TheHarvester${NC}  - OSINT y recolección de correos"
    echo -e " 3) ${GREEN}Metasploit${NC}    - Framework de explotación"
    echo -e " 4) ${GREEN}Burp Suite${NC}    - Análisis de aplicaciones Web"
    echo -e " 5) ${GREEN}SQLMap${NC}        - Inyección de bases de datos"
    echo -e " 6) ${GREEN}John/Hashcat${NC}  - Cracking de contraseñas"
    echo -e " 7) ${GREEN}Wireshark${NC}     - Sniffing de red"
    echo -e " 8) ${GREEN}Ghidra${NC}        - Ingeniería inversa"
    echo -e " 9) ${GREEN}GVM (OpenVAS)${NC} - Escáner de vulnerabilidades"
    echo -e "10) ${RED}Limpiar Logs${NC}  - Borrar rastro de comandos"
    echo -e "11) ${RED}SALIR${NC}"
    echo -e "${BLUE}======================================================${NC}"
    echo -n -e "${YELLOW}Selecciona una opción: ${NC}"
}

# --- Lógica de Ejecución ---
binary_splash
show_banner
echo ""

while true; do
    show_menu
    read opt
    case $opt in
        1) 
            read -p "Objetivo (IP/Dominio): " target
            nmap -T4 -A -v $target -oN ~/MegaToolkit/Reportes/nmap_$target.txt
            ;;
        2)
            read -p "Dominio: " dom
            theHarvester -d $dom -l 300 -b google
            ;;
        3) msfconsole ;;
        4) burpsuite & ;;
        5)
            read -p "URL objetivo: " url
            sqlmap -u "$url" --batch --banner
            ;;
        6) 
            echo "1) John the Ripper  2) Hashcat"
            read -p "Opción: " copt
            [[ $copt == "1" ]] && john --interactive || hashcat --help
            ;;
        7) sudo wireshark & ;;
        8) ghidra & ;;
        9) sudo gvm-start ;;
        10)
            echo -e "${RED}[!] Limpiando historial de bash y logs...${NC}"
            history -c && sudo rm -rf /var/log/apache2/* /var/log/auth.log
            echo -e "${GREEN}[+] Limpieza completada.${NC}"
            ;;
        11)
            echo -e "${CYAN}Cerrando sesión, jco11...${NC}"
            exit 0
            ;;
        *) echo -e "${RED}Opción no válida.${NC}" ;;
    esac
    echo -e "\n${YELLOW}Presiona Enter para volver al panel...${NC}"
    read
    clear
    show_banner
done
