# ABUS IP Camera


Verwende in U-Boot `setenv`, um Boot-Parameter zu setzen. Beispiel:
=======

Verwende in U-Boot `setenv`, um Boot-Parameter zu setzen. Beispiel:
=======
This repository collects notes and scripts for running an ABUS IP camera on custom firmware.

## Setting boot arguments

Boot arguments are passed by U-Boot. From the U-Boot prompt you can set them temporarily with `setenv` before booting. A typical command looks like:



```
setenv bootargs console=ttyS1,57600 root=/dev/mtdblock3 rw
```

=======


### Boot sequence

1) Baue dir erst mal die Partition-Definition in P auf:
```
setenv P m25p80:16384k@0(global),384k@0(boot)
```
2) Häng hconf und kernel an:
```
setenv P ${P},256k@384k(hconf),3072k@640k(kernel)
```
3) Und jetzt das rootfs:
```
setenv P ${P},11264k@3712k(rootfs)
```
4) Nutze P in deinen bootargs:
```
setenv bootargs console=ttyS1,57600 root=/dev/mtdblock4 rw init=/bin/sh rts_hconf.hconf_mtd_idx=2 rts-quadspi.channels=dual mtdparts=${P}
```
5) Flash initialisieren:
```
sf probe 0
```
6) Kernel ins RAM laden:
```
sf read 0x80100000 0xA0000 0x300000
```
7) Booten:
```
bootm 0x80100000
```

## camera_setup.sh


Dieses Skript mountet `/proc` und `/sys`, legt Gerätedateien an und ändert keine U‑Boot‑Umgebung. It only prepares the running Linux system by loading modules and starting services.

## Bootlog

Das Repository enthält eine Beispielausgabe des Startvorgangs in `bootlog.txt`. Dort sind die U-Boot-Kommandos und der Beginn des Kernel-Logs abgelegt.

## Verzeichnisbaum

In `tree.txt` befindet sich der mit `tree -a` erzeugte Verzeichnisbaum des Repositories.
=======
Dieses Skript mountet `/proc` und `/sys`, legt Gerätedateien an und ändert keine U‑Boot‑Umgebung.
=======
Adjust the arguments for your environment and then execute `boot` to start the kernel.

### Full boot sequence example

Below is a complete example of how to prepare the flash layout, set boot arguments and start the kernel from U-Boot.

1. Define the partition layout in the variable `P`:
   ````
   setenv P m25p80:16384k@0(global),384k@0(boot)
   ````
2. Append the `hconf` and `kernel` partitions:
   ````
   setenv P ${P},256k@384k(hconf),3072k@640k(kernel)
   ````
3. Append the `rootfs` partition:
   ````
   setenv P ${P},11264k@3712k(rootfs)
   ````
4. Use `P` when setting `bootargs`:
   ````
   setenv bootargs console=ttyS1,57600 \
       root=/dev/mtdblock4 rw init=/bin/sh \
       rts_hconf.hconf_mtd_idx=2 rts-quadspi.channels=dual \
       mtdparts=${P}
   ````
5. Initialize the flash:
   ````
   sf probe 0
   ````
6. Load the kernel into RAM:
   ````
   sf read 0x80100000 0xA0000 0x300000
   ````
7. Boot the kernel:
   ````
   bootm 0x80100000
   ````

## Camera setup script

The `camera_setup.sh` script only prepares the running Linux system by loading modules and starting services. It does **not** change the U-Boot environment or make permanent modifications.

