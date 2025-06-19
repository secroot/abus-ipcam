# ABUS IP Camera

Verwende in U-Boot `setenv`, um Boot-Parameter zu setzen. Beispiel:

```
setenv bootargs console=ttyS1,57600 root=/dev/mtdblock3 rw
```

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

Dieses Skript mountet `/proc` und `/sys`, legt Gerätedateien an und ändert keine U‑Boot‑Umgebung.
