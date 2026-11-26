#!/bin/sh

NIKKI_VIEW="/www/luci-static/resources/view/nikki/configeditor.js"
NIKKI_MENU="/usr/share/luci/menu.d/luci-app-nikkieditor.json"
BASE_NIKKI="https://raw.githubusercontent.com/Yogxx/OpenWrt-ConfigEditor/main/Nikki"

CLASHOO_VIEW="/www/luci-static/resources/view/clashoo/configeditor.js"
CLASHOO_MENU="/usr/share/luci/menu.d/luci-app-clashooeditor.json"
BASE_CLASHOO="https://raw.githubusercontent.com/Yogxx/OpenWrt-ConfigEditor/main/Clashoo"

MOMO_VIEW="/www/luci-static/resources/view/momo/configeditor.js"
MOMO_MENU="/usr/share/luci/menu.d/luci-app-momoeditor.json"
BASE_MOMO="https://raw.githubusercontent.com/Yogxx/OpenWrt-ConfigEditor/main/Momo"

refresh_luci() {
    rm -rf /tmp/luci-indexcache* /tmp/luci-modulecache
    /etc/init.d/rpcd restart
    /etc/init.d/uhttpd restart
}

#####

install_nikki() {
    echo "🚀 Mulai install Clashoo Editor..."
    mkdir -p "$(dirname "$NIKKI_VIEW")" "$(dirname "$NIKKI_MENU")"

    wget -q -O "$NIKKI_MENU" "$BASE_NIKKI/luci-app-nikkieditor.json" || { echo "❌ Gagal download menu"; rm -f "$NIKKI_MENU"; exit 1; }
    wget -q -O "$NIKKI_VIEW" "$BASE_NIKKI/configeditor.js" || { echo "❌ Gagal download view"; rm -f "$NIKKI_VIEW"; exit 1; }

    chmod 644 "$NIKKI_MENU" "$NIKKI_VIEW"
    refresh_luci
    echo "✅ Install ConfigEditor selesai!"
}

uninstall_nikki() {
    echo "🗑️  Mulai uninstall ..."
    rm -f "$NIKKI_MENU" "$NIKKI_VIEW"
    rmdir "$(dirname "$NIKKI_VIEW")" 2>/dev/null
    refresh_luci
    echo "✅ Uninstall selesai!"
}

#####

install_clashoo() {
    echo "🚀 Mulai install Clashoo Editor..."
    mkdir -p "$(dirname "$CLASHOO_VIEW")" "$(dirname "$CLASHOO_MENU")"

    wget -q -O "$CLASHOO_MENU" "$BASE_CLASHOO/luci-app-clashooeditor.json" || { echo "❌ Gagal download menu"; rm -f "$CLASHOO_MENU"; exit 1; }
    wget -q -O "$CLASHOO_VIEW" "$BASE_CLASHOO/configeditor.js" || { echo "❌ Gagal download view"; rm -f "$CLASHOO_VIEW"; exit 1; }

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

#####

install_momo() {
    echo "🚀 Mulai install Momo Editor..."
    mkdir -p "$(dirname "$MOMO_VIEW")" "$(dirname "$MOMO_MENU")"

    wget -q -O "$MOMO_MENU" "$BASE_MOMO/luci-app-momoeditor.json" || { echo "❌ Gagal download menu"; rm -f "$MOMO_MENU"; exit 1; }
    wget -q -O "$MOMO_VIEW" "$BASE_MOMO/configeditor.js" || { echo "❌ Gagal download view"; rm -f "$MOMO_VIEW"; exit 1; }

    chmod 644 "$MOMO_MENU" "$MOMO_VIEW"
    refresh_luci
    echo "✅ Install ConfigEditor selesai!"
}

uninstall_momo() {
    echo "🗑️  Mulai uninstall ..."
    rm -f "$MOMO_MENU" "$MOMO_VIEW"
    rmdir "$(dirname "$MOMO_VIEW")" 2>/dev/null
    refresh_luci
    echo "✅ Uninstall selesai!"
}

#####

echo "=============================="
echo "   Manage LuCI Scripts"
echo "=============================="
echo "1) Install ConfigEditor Nikki"
echo "2) Uninstall ConfigEditor Nikki"
echo "3) Install ConfigEditor Clashoo"
echo "4) Uninstall ConfigEditor Clashoo"
echo "5) Install ConfigEditor Momo"
echo "6) Uninstall ConfigEditor Momo"
echo "=============================="
printf "Pilih opsi [1-6]: "

read choice < /dev/tty

case "$choice" in
    1) install_nikki ;;
    2) uninstall_nikki ;;
    3) install_clashoo ;;
    4) uninstall_clashoo ;;
    5) install_momo ;;
    6) uninstall_momo ;;
    *) echo "❌ Pilihan tidak valid!"; exit 1 ;;
esac
