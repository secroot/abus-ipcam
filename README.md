# ABUS IP Camera

This repository collects notes and scripts for running an ABUS IP camera on custom firmware.

## Setting boot arguments

Boot arguments are passed by U-Boot. From the U-Boot prompt you can set them temporarily with `setenv` before booting. A typical command looks like:

```
setenv bootargs console=ttyS1,57600 root=/dev/mtdblock3 rw
```

Adjust the arguments for your environment and then execute `boot` to start the kernel.

## Camera setup script

The `camera_setup.sh` script only prepares the running Linux system by loading modules and starting services. It does **not** change the U-Boot environment or make permanent modifications.
