#!/bin/sh

CLASHOO_VIEW="/www/luci-static/resources/view/clashoo/configeditor.js"
CLASHOO_MENU="/usr/share/luci/menu.d/luci-app-clashooeditor.json"
BASE="https://raw.githubusercontent.com/Yogxx/OpenWrt-ConfigEditor/main/Clashoo"

refresh_luci() {
    rm -rf /tmp/luci-indexcache* /tmp/luci-modulecache
    /etc/init.d/rpcd restart
    /etc/init.d/uhttpd restart
}

install_clashoo() {
    echo "🚀 Mulai install ..."
    mkdir -p "$(dirname "$CLASHOO_VIEW")" "$(dirname "$CLASHOO_MENU")"

    wget -q -O "$CLASHOO_MENU" "$BASE/luci-app-clashooeditor.json" || { echo "❌ Gagal download menu"; rm -f "$CLASHOO_MENU"; exit 1; }
    wget -q -O "$CLASHOO_VIEW" "$BASE/configeditor.js" || { echo "❌ Gagal download view"; rm -f "$CLASHOO_VIEW"; exit 1; }

    chmod 644 "$CLASHOO_MENU" "$CLASHOO_VIEW"
    refresh_luci
    echo "✅ Install ConfigEditor selesai!"
}

uninstall_clashoo() {
    echo "🗑️  Mulai uninstall ..."
    rm -f "$CLASHOO_MENU" "$CLASHOO_VIEW"
    rmdir "$(dirname "$CLASHOO_VIEW")" 2>/dev/null
    refresh_luci
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
