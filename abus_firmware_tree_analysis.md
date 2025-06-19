# Firmware Dump Overview

`abus_dmp_tree.md` lists the contents of an extracted firmware image. Only the most relevant parts are summarized here.

## Top-level layout

- `mtd0_global.bin` — raw flash dump
- `_mtd0_global.bin.extracted/` — unpacked contents
  - Numerous compressed blobs (`*.xz`, `*.zlib`, `*.jffs2`, `*.squashfs`)
  - `squashfs-root/` contains the root filesystem used by the camera

## Notable paths under `squashfs-root`

- **`bin/`** — BusyBox utilities plus additional tools like `hostapd`, `check_cfg`, and Realtek Bluetooth helpers.
- **`etc/`** — configuration files
  - `conf/` holds JSON settings such as `isp.json`, `mtd_mask.json`, LED configurations and keys.
  - `init.d/` and `rcS.d/` contain startup scripts (e.g., `mount_jffs2`, `S99watchdog`).
  - `lighttpd/` with `lighttpd.conf` and other web server snippets.
  - SSL certificates under `ssl/certs/`.
- **`lib/`** — shared libraries and firmware binaries
  - Wi‑Fi firmware files like `rtl8821cu_fw`.
  - Standard libc (`ld-uClibc-0.9.33.so`) and audio libraries.
- **`usr/`** — application binaries and resources
  - Contains directories for languages, scripts, and web interface files under `www/html/`.

The tree enumerates about 160 directories and over 3300 files, indicating a full Linux userland with networking, audio, and camera support components packaged inside the firmware image.
