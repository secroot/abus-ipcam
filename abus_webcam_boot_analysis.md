# Boot Log Analysis

The file `abus webcam mit sd.txt` records the boot sequence of an ABUS IP camera running U‑Boot 2014.01.

## Key observations

- **Hardware detection**
  - CPU: *RTS3903* @ 500 MHz
  - Flash chip: *W25Q128FV* (16 MiB)
  - DRAM: 64 MiB
  - An SD card (29 GiB) is detected as `mmcblk0p1`.
  - USB devices include a Realtek 8821cu Wi‑Fi adapter and a Kneron KL520 neural processor.

- **Filesystem mounting**
  - `/proc` is mounted during early boot.
  - JFFS2 partitions from `/dev/mtdblock5` are mounted.
  - The root filesystem is mounted read‑only from `/dev/root` and later remounted.
  - The SD card partition `mmcblk0p1` is mounted with flag `4096`; a warning about improper unmount is shown.

- **Configuration files**
  - `/mnt/mtd/config.xml` and `/mnt/mtd/gpio.xml` are saved during boot, indicating persistent configuration stored on flash.

- **Network setup**
  - The device tries DHCP on `wlan0` and `eth0`, eventually reporting `My Lan IP : 0.0.0.0` while Ethernet link comes up.

- **Services started**
  - `cms`, Wi‑Fi watchdog, Bluetooth initialization via `rtk_btusb`.
  - Audio services start (`aac_frame_proc`, `pcm_frame_proc`).

These steps show that the camera boots a Linux 3.10 kernel, mounts its flash partitions, brings up peripherals and services, and finally launches the main application.
