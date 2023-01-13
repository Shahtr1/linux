Computer has a main board, and that main board we have a cpu or hard disk or some other form, as we dont use disks anymore, and some RAM, and BIOS which is just a EEPROM chip.

When we start computer, Main board is going to run the firmware that is stored in BIOS,

RAM is huge array of bytes.

Firmware is copied to the RAM, then we tell CPU to run it from there, by setting the Instruction Pointer.

The Firmware will then basically will just tell the whole computer to talk to the hardware.

Lets pretend its disk-based.

First sector of disk is MBR, The firmware will tell the CPU to talk to the hard drive and copy the MBR into the RAM also

and then the firmware will tell the CPU to start running the code from MBR, by setting the instruction pointer to there

In MBR we have Bootloader, bootloader has info about partition tables, file systems etc,

The bootloader will be able to look at /boot, the UNIX directory, which is C: in Windows

/boot/...whatever

Lets call it kernel

/boot/kernel (comes from its configuration file) can be called vmlinux, whatever magic...............

Bootloader will then copy that into RAM, and will then tell the CPU by setting the IP to start running the kernel

Stuff doesnt run inside the kernel, its just there for communicating. It will just then start some initializing program, in old days we had init (System V), these days we have Systemd initialization.

So most of what happens in boot process, is actually done by initializing systems, they will look at their configuration, and config will say bring driver, or network driver, or mount some hard driver

Part of initilization would actually be to mount root partition depending upon the file /etc/fstab file, it will have entry to mount /root partition as /

Then for convenience, it will also mount the /boot partion in sib directory /boot.

This need to be done pretty earlier in the process, becaus ewhen the initializtion system wants to start soome programs or daemons or some drivers they are usually loaded form root partition.

BIOS is just there, we wont touch it. too risky

The communication between RAM and CPU is hardwired in the mainboard.

what we need to do is , at the point where the MBR is loaded, right at the beginning we can hook our system into it by providing it with harddrive that has a partition table, a MBR and a partition with kernel(boot), and the root partiion(with all daemons, and programs and other stuff)

We will create this harddrive.

coreutils is very inportant packaging.

It contains basic stuff like

mkdir, mv, cd, rm etc

Lets look at Linux directories

Boot => This is where you are trying the bootloader and configuration of bootloader, and also the kernel possibly initial rd stuff, that is here

Etc => we have a lot of config files for the whole system, config files that would be system wide, not personal, system wide stuff like hardware config. Dont know why called etc,

Home => config files of different users, for example different cookies, or recently used stuff and so on

Bin => This is where you put binaries, binaries are the unix or linux equivalent of .exe files on windows, these are really programs. On windows we would normally put programs with libraries in C . On unix we separate them , programs in binaries and libraries in LIB. amd LIB64 for 64bit libraries.

Here we are trying for all programs to use same libraries, to save space and consistency, not like windows.

Sbin => system programs, bin would contain something like browser, or office, and sbin would have like fdisk, mkfs to manage the hardwares. sbin is for system management. and normal users dont even have access to sbin.

Usr => which contains a lot of interesting things, we have another bin directory, another etc, another lib and also local directory, that has another bin , etc, lib, sbin. so the reason for that is so the usr directory is stuff that is more for the regular usage. The different between bin and /usr/bin is that bin would be stuff thats more necessary so stuff that you need to boot your machine because the directory bin is required too on your root partition and /usr/bin is not required to be there. so the idea is that when you are booting then you might need stuff from bin, and once you are booted, part of boot process would be to mount another harddrive to /usr and then we have these additional programs that dont need to be install on harddrive. so in a big company everybody will mount network drive to a /usr and changes will only be done once.

Root => is the home directory of root user, the administrator user. if the root directory was in home, and we are getting home from the network, then maybe its down, we cant login as a root user. Root directory is required to be on same partition

/usr/share => there would be a lot of stuff, like icons of file manager, desktop images, man pages and so on

Include => contains the header files for c and c++. and can be shared.

Dev => its not an actual directory, it is a virtual directory created by kernel at runtime. it contains files like sda, sdb that represent the harddrives, tty's

Mnt => this is where you would mount whatever, harddrives, anything. if attach the harddrive while system is running, the system should do something, so if you are a logged in as a normal user, you cannot just mount it to systemm location so instead nowadays it would be mounted to media/

Proc => which contains entries for all the running processes, process ids as directories. ps and top is probably reading this directory

Run => for system daemons, like samba, openvpn, sql server, cups(printing system), docker, dhcp, systemd and so on....

Sys => which has all types of stuff to communicate with kernel, which has directories like fs(fiel system), devices, modules(mod prob), bus(ac97 (maybe for audio), and others)

Tmp => for temporary files, anyone can access it.

Opt => chrome folder sits there usually,, dont know why, other distributions can also put dektop manager there. depends on distribution

Var => some stuff that didnt fit in anything else (Various)

Srv => files for different server, if you share something to ftp or http, if you installed a web server like Apache, or ftp server like proftp, you might put files that you share here, but that is also not standardised,

Now, CREATE THIS SHIT...