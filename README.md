This is a script for automatic gentoo installation/setup
It will setup gentoo to use kvm/qemu and lxc containers also supporting backups

**Pre-requirements**
* You must have gentoo/arch liveCD 
* You must have at list 16G of space
* Internet connection also required

**Installation**
    **Arch**
    ```bash
    pacman -Sy wget unzip tar
    wget https://github.com/Gailoks/GLmox/archive/refs/heads/main.zip
    unzip main.zip
    cp GLmox-main/install.sh install.sh
    chmod +x install.sh
    ./install.sh 
    ```
    **Gentoo**
    ```bash
    wget https://github.com/Gailoks/GLmox/archive/refs/heads/main.zip
    unzip main.zip
    cp GLmox-main/install.sh install.sh
    chmod +x install.sh
    ./install.sh 
    ```