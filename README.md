## MicroRenovator
Pre-OS microcode updater

# WARNING

This application is designed to modify the EFI partition and bootloader of
your system. Users acknowledge that running this program may result in
destruction of the operating system and/or user data.


## Usage

Boot the target system using a linux LiveCD or USB. Check out this
repository, and run uRenovate.sh to install the microcode updater.
The installer will perform the following actions:
1. find appropriate microcode for the current system
2. attempt to locate an EFI partition
3. find the bootloader on that partition
4. copy the included microcode updater to the EFI partition
5. add a startup script to run the microcode updater prior to the OS bootloader

Tested using Fedora-Workstation-Live-x86_64-27-1.6.iso


## Building

Building the EFI applications requires an EDK2 environment:
https://github.com/tianocore/tianocore.github.io/wiki/Common-instructions

Copy Uload directory into the edk2/ folder, and run the following:
```
build -a X64 -p ShellPkg/ShellPkg.dsc -b RELEASE
build -a X64 -p Uload/Uload.dsc -b RELEASE
```

To use the resulting files, change the "edk2_dir" in uRenovate.sh


## ToDo
- howto verify microcode in /lib/firmware/intel-ucode/ is good?
- add uninstaller
- verify on windows installs (\EFI\Microsoft\Boot\bootmgfw.efi)
- error handling in Uload.c
- handle Uload.efi errors in startup.nsh
- add "--date-after" switch to iucode_tool usage?
- S3 callback?
