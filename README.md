# OpenWrt Config Editor Menu

Adds a **Config Editor** page to the LuCI menu for:

* Clashoo
* Momo

An interactive script installs or removes the editor menu with a single command.

---

## Features

* Config editor page directly in LuCI
* Interactive install / uninstall menu
* Lightweight, no extra packages besides `wget`
* Clears LuCI cache and restarts `rpcd` / `uhttpd` automatically

---

## Installation

Run this in the OpenWrt terminal:

```sh
wget -O - https://raw.githubusercontent.com/Yogxx/OpenWrt-ConfigEditor/main/manage.sh | sh
```

Then pick an option:

```
1) Install ConfigEditor OpenClash
2) Uninstall ConfigEditor OpenClash
3) Install ConfigEditor Nikki
4) Uninstall ConfigEditor Nikki
```

To uninstall, run the same command and choose the matching uninstall option.

---

## Requirements

* Internet access on the device
* `wget` with HTTPS support (`wget-ssl` or `uclient-fetch`)
* Clashoo and/or Momo already installed

---

## Compatibility

Tested on:

* OpenWrt 23.xx
* OpenWrt 24.xx
* OpenWrt 25.xx
* LuCI Web Interface

---

## Troubleshooting

* **Menu not showing:** hard refresh the browser (Ctrl+F5) or log out and back in to LuCI.
* **Download failed:** check internet/DNS on the router and that `wget` supports HTTPS.

---

## License

MIT License
