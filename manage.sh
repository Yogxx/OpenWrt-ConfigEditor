#!/bin/sh

# OpenWrt ConfigEditor - installer menu LuCI
# Usage: wget -qO - https://raw.githubusercontent.com/Yogxx/OpenWrt-ConfigEditor/main/manage.sh | sh

REPO="https://raw.githubusercontent.com/Yogxx/OpenWrt-ConfigEditor/main"
MENU_DIR="/usr/share/luci/menu.d"
VIEW_DIR="/www/luci-static/resources/view"

# Daftar app. Nambah app baru: tambah 1 case di app_info + naikin APP_COUNT.
# Format: label|folder di repo (view dir = lowercase)|nama file menu json
APP_COUNT=4
app_info() {
    case "$1" in
        1) echo "OpenClash|OpenClash|luci-app-oceditor.json" ;;
        2) echo "Nikki|Nikki|luci-app-nikkieditor.json" ;;
        3) echo "Clashoo|Clashoo|luci-app-clashooeditor.json" ;;
        4) echo "Momo|Momo|luci-app-momoeditor.json" ;;
    esac
}

# Isi LABEL, DIR, MENU, VIEW dari nomor app
load_app() {
    _oldifs=$IFS; IFS='|'
    set -- $(app_info "$1")
    IFS=$_oldifs
    LABEL=$1
    DIR=$2
    MENU="$MENU_DIR/$3"
    MENU_NAME=$3
    VIEW="$VIEW_DIR/$(echo "$DIR" | tr 'A-Z' 'a-z')/configeditor.js"
}

refresh_luci() {
    rm -rf /tmp/luci-indexcache* /tmp/luci-modulecache
    /etc/init.d/rpcd restart
    /etc/init.d/uhttpd restart
}

install_app() {
    load_app "$1"
    echo "🚀 Mulai install $LABEL Editor..."
    mkdir -p "$(dirname "$VIEW")" "$MENU_DIR"

    if ! wget -q -O "$MENU" "$REPO/$DIR/$MENU_NAME" \
       || ! wget -q -O "$VIEW" "$REPO/$DIR/configeditor.js"; then
        echo "❌ Gagal download $LABEL Editor"
        rm -f "$MENU" "$VIEW"
        rmdir "$(dirname "$VIEW")" 2>/dev/null
        return 1
    fi

    chmod 644 "$MENU" "$VIEW"
    refresh_luci
    echo "✅ Install $LABEL Editor selesai!"
}

uninstall_app() {
    load_app "$1"
    echo "🗑️  Mulai uninstall $LABEL Editor..."
    rm -f "$MENU" "$VIEW"
    rmdir "$(dirname "$VIEW")" 2>/dev/null
    refresh_luci
    echo "✅ Uninstall $LABEL Editor selesai!"
}

status() {
    if [ -f "$1" ]; then
        printf "\033[32m[terpasang]\033[0m"
    else
        printf "\033[31m[belum]\033[0m"
    fi
}

show_menu() {
    clear 2>/dev/null
    echo "=============================="
    echo "   Manage LuCI Scripts"
    echo "=============================="
    n=1
    while [ "$n" -le "$APP_COUNT" ]; do
        load_app "$n"
        printf " %-10s %b\n" "$LABEL" "$(status "$MENU")"
        echo "   $((2 * n - 1))) Install    $((2 * n))) Uninstall"
        n=$((n + 1))
    done
    echo "------------------------------"
    echo "   0) Keluar"
    echo "=============================="
    printf "Pilih opsi [0-%d]: " "$((2 * APP_COUNT))"
}

while true; do
    show_menu
    read -r choice < /dev/tty

    case "$choice" in
        0) echo "Bye 👋"; exit 0 ;;
        ''|*[!0-9]*) echo "❌ Pilihan tidak valid!" ;;
        *)
            if [ "$choice" -ge 1 ] && [ "$choice" -le $((2 * APP_COUNT)) ]; then
                app=$(( (choice + 1) / 2 ))
                if [ $((choice % 2)) -eq 1 ]; then
                    install_app "$app"
                else
                    uninstall_app "$app"
                fi
            else
                echo "❌ Pilihan tidak valid!"
            fi
            ;;
    esac

    echo
    printf "Tekan Enter untuk lanjut..."
    read -r _ < /dev/tty
done
