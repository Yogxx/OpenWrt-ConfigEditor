#!/bin/sh

# Script interaktif untuk install/uninstall configeditor menu di LuCI
# Bisa dijalankan langsung: wget -O - URL | sh

# Lokasi file Clashoo
CLASHOO_VIEW="/www/luci-static/resources/view/clashoo/configeditor.js"
CLASHOO_MENU="/usr/share/luci/menu.d/luci-app-clashooeditor.json"

install_clashoo() {
    echo "🚀 Mulai install ..."

    # Download menu
    wget -O "$CLASHOO_MENU" https://raw.githubusercontent.com/Yogxx/OpenWrt-ConfigEditor/main/Clashoo/configeditor.js

    # Download view
    wget -O "$CLASHOO_VIEW" https://raw.githubusercontent.com/Yogxx/OpenWrt-ConfigEditor/main/Clashoo/luci-app-clashooeditor.json

    # Set permission
    chmod 644 "$CLASHOO_MENU" "$CLASHOO_VIEW"

    # Restart LuCI webserver
    /etc/init.d/uhttpd restart

    echo "✅ Install ConfigEditor selesai!"
}

uninstall_clashoo() {
    echo "🗑️  Mulai uninstall ..."

    rm -f "$CLASHOO_MENU" "$CLASHOO_VIEW"

    /etc/init.d/uhttpd restart
    echo "✅ Uninstall selesai!"
}

echo "=============================="
echo "   Manage LuCI Scripts"
echo "=============================="
echo "1) Install ConfigEditor Clashoo"
echo "2) Uninstall ConfigEditor Clashoo"
echo "=============================="
printf "Pilih opsi [1-2]: "

read choice < /dev/tty

case "$choice" in
    1) install_clashoo ;;
    2) uninstall_clashoo ;;
    *) echo "❌ Pilihan tidak valid!"; exit 1 ;;
esac
