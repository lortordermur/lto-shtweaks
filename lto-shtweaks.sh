#################################################
### LORTORDERMUR'S SHELL UTILITIES AND TWEAKS ###
#################################################

# This is a selection of shell aliases and shell functions from my private
# collection which have aggregated over the years, and which I thought would
# be general and useful enough to share.

# Get the newest version at <https://github.com/lortordermur/lto-shtweaks>.

# I mainly use Debian derived Linux distributions with the KDE/Plasma desktop
# so there is some emphasis on that.

# For the sake of clarity the file is subdivided into “environment”, “shell
# aliases” and “shell functions” main sections, with subsections for the
# various parts and aspects of a Linux/Unix system. All entries are commented.

# To make all definitions in this file available in your shell, you need to
# copy (or symlink) it to your home directory and then source it in your
# shell’s initialization file, such as .bashrc or .zshrc, using

# if [ -f ~/lto-shtweaks.sh ]; then
#   . ~/lto-shtweaks.sh
# fi


    ###########
### ENVIRONMENT ###
    ###########

# Version and branch of lto-shtweaks

export SHTWEAKS_VERSION="2"
#export SHTWEAKS_BRANCH="release"
export SHTWEAKS_BRANCH="devel"

# For shell programming. Uncomment this to make interactive shells and GNU
# commands try to behave more POSIX conformant. Setting this may break some
# shell scripts.

#export POSIXLY_CORRECT="1"


    #############
### SHELL ALIASES ###
    #############

### Default argument overrides ###

# Enable X tunneling over ssh by default (disabled by default for security
# reasons)

#alias ssh='ssh -X -Y'


### General ###

# List aliases and functions contained in this file. If the file is not found
# in the home directory it is loaded from GitHub

alias listshtweaks='filename="$(realpath ~)/lto-shtweaks.sh"; [ -r "$filename" ] && content=$(cat $filename); [ ! -r "$filename" ] && content=$(curl -s https://raw.githubusercontent.com/lortordermur/lto-shtweaks/main/lto-shtweaks.sh); (echo $content | grep "^alias " | cut -d "=" -f 1 | grep -v "^#alias" && echo $content | grep " () {$" | tr -d "{")'

# Get version info of this file

alias shtweaksver='set | grep SHTWEAKS'

# Show a percental system load derived from the load average

alias sysload='printf "System load (1m/5m/15m): "; for l in 1 2 3 ; do printf "%.1f%s" "$(( $(cat /proc/loadavg | cut -f $l -d " ") * 100 / $(nproc) ))" "% "; done; printf "\n"'

# Suspend the computer

alias standby='systemctl suspend'

# View a manpage in the default web browser (requires groff-base installed)

alias bman='man --html=x-www-browser'

# ASCII weather for your location

alias weather='local info=$(curl -s ipinfo.io) && local city=$(echo $info | grep "\"city\": " | cut -d "\"" -f 4) && local country=$(echo $info | grep "\"country\": " | cut -d "\"" -f 4) && curl "wttr.in/$city,$country"'

# Star Wars Episode IV over telnet

alias starwars='telnet towel.blinkenlights.nl'

# Play NetHack online

alias nethack='telnet nethack.alt.org'

# Count number of characters in stdin

alias charcount='wc -m'

# Count number of words in stdin

alias wordcount='wc -w'

# Count number of lines in stdin

alias linecount='wc -l'

# Shows the current time without the date

alias now='date +%T'

# Shows information about previous shutdowns and reboots

alias shreb='last -x | grep -E "reboot|shutdown"'


### Package management ###

# Shortcut for complete system upgrade on apt based distributions. Can also be
# safely used as the everyday update command.

alias sysupgrade='sudo sh -c "apt update; apt full-upgrade; apt autoclean; exit"'

# Remove old kernels and other cruft

alias autoremove='sudo apt autoremove --purge'

# Display a list of manually installed packages in a format that
# 'dpkg --set-selections' can understand and use

alias listmanpkgs='sudo apt-mark showmanual | sed "s/$/ \tinstall/"'

# Completely purge packages (including config files etc.) that have been
# deinstalled (disabled by default due to risk of config loss)

#alias purgedeinstalled='sudo aptitude purge $(dpkg --get-selections | sed -n "s/\tdeinstall$//p")'

# Show which package contains a command that is not installed, or the
# location(s) of an installed command (requires command-not-found installed)

alias whatcontains='/usr/lib/command-not-found --no-failure-msg'


### Hardware ###

# System information summary (requires inxi installed)

alias sysinfo='sudo sh -c "inxi -F"'

alias sysinfomax='sudo sh -c "inxi -FdfiJlmopruxt"'

# Quick and dirty hardware summary where inxi or lshw are not available

alias gethw='(printf "\nCPU\n---\n\n"; lscpu; printf "\nMEMORY\n------\n\n"; free -h; printf "\nSTORAGE\n-------\n\n"; lsblk; printf "\nPCI\n---\n\n"; lspci; printf "\nUSB\n---\n\n"; lsusb; printf "\nNETWORK\n-------\n\n"; ifconfig) | less'

# Show CPU model

alias cpumodel='LANG=C lscpu | grep "^Model name: " | cut -d ":" -f 2 | tr -d " "'

# Show CPU architecture

alias cpuarch='LANG=C lscpu | grep "^Architecture: " | cut -d ":" -f 2 | tr -d " "'

# Show number of CPU cores

alias cpucores='nproc'

# Show maximum CPU frequency

alias cpumaxfreq='LANG=C lscpu | grep "^CPU max MHz: " | cut -d ":" -f 2 | tr -d " "'

# Show BogoMIPS

alias bogomips='LANG=C lscpu | grep "^BogoMIPS: " | cut -d ":" -f 2 | tr -d " "'

# CPU speed monitor

alias cpumon='watch -tn1 "sudo dmidecode -t processor | grep \"Current Speed: \" | cut -d \":\" -f 2 | tr -d \" \""'

# System temperature monitor

alias tempmon='watch -tn1 sensors'

# Show battery charge percentage

alias battery='upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep percentage | cut -d ":" -f 2 | tr -d " "'


### Filesystem ###

# Show currently mounted filesystems in a nice layout

alias mounts='mount | column -t | sort'

# List all physical storage devices in the system

alias disks='lsblk | grep "disk" | cut -f 1 -d " "'

# Spin down an IDE drive (for example external USB drive)

alias spindown='sudo hdparm -y'

# Fast-overwrite free disk space with zeroes using a temporary zero.000 file

alias wipefreefast='sudo sh -c "dd if=/dev/zero of=zero.000 status=progress; sync; rm -f zero.000; sync"'

# Clear swap file(s)

alias clearswap='sudo swapoff -a; sudo swapon -a'

# Make the current user the owner of the given file(s) or directory, descends
# recursively

alias makemine='sudo chown -R $(id -un):$(id -gn)'

# Recursively grep all files within a directory tree

alias greptree='grep --color -IsHr'

# Show which files are different between two directories

alias dirdiff='diff -qr'

# Sync-copy files or directories (creates or updates files at target)

alias scopy='rsync -azhv --progress'

# Sync-copy files or directories over ssh

alias sshcopy='rsync -azhve ssh --progress'

# Sync-move files or directories (deletes synced source files)

alias smove='rsync -azhv --remove-source-files --progress'

# Synchronize destination with source, skip newer files, delete files as
# required

alias ssync="rsync -azhvu --delete --progress"

# Create a directory including parent directories

alias mkpath='mkdir -p'


### Processes ###

# List the top 10 memory consuming processes

alias memtop='ps aux --sort=-%mem | head -n 11 | sed G'

# Run a command restrained to maximum 10 % usage of one CPU core (requires
# cpulimit installed)

alias restrain10='cpulimit -l 10 --'

# With hybrid graphics, run a game on the discrete graphics adapter

alias game='DRI_PRIME=1'

# Make the first found Java VM process run with background priority (for
# Java daemons like BubbleUPnP Server or Freenet)

alias javabg='renice -n 20 -p $(pidof -s java)'


### Memory ###

# Show free RAM as a human-readable value

alias memfree='free -h | tail +2 | head -n 1 | tr -s " " | cut -d " " -f 3'

# Show free RAM in MiB

alias memfreem='free -m | tail +2 | head -n 1 | tr -s " " | cut -d " " -f 3'

# Show free RAM in GiB

alias memfreeg='free -g | tail +2 | head -n 1 | tr -s " " | cut -d " " -f 3'

# Show free RAM in percent

alias memfreepc='local freem=$(free | sed -e "2q;d" | tr -s " "); printf "%.2f\n" $(( $(printf $freem | cut -d " " -f 4).0 / $(printf $freem | cut -d " " -f 2).0 * 100 ))'

# Clear the PageCache (filesystem cache) if eating too much memory. May turn
# the computer partly unresponsive for some time.

alias dropcache='sync; sudo sh -c "echo 1 > /proc/sys/vm/drop_caches"'


### Network ###

# Show a colored list of nearby wifi hotspots (requires network-manager
# installed)

alias hotspots='nmcli device wifi list'

# Disable all wireless interfaces (requires rfkill installed)

alias rfoff='sudo rfkill block all'

# Enable all wireless interfaces (requires rfkill installed)

alias rfon='sudo rfkill unblock all'

# Show all live hosts on the local network (requires nmap and net-tools
# installed)

alias livehosts='nmap -sP "$(ip -4 -o route get 1 | cut -d " " -f 7)"/24 | grep report | cut -d " " -f 5-'

# Scan for open ports on the local network (requires nmap and net-tools
# installed)

alias networkscan='nmap -sT "$(ip -4 -o route get 1 | cut -d " " -f 7)"/24'

# Thorough port scan of a host or IP with service detection (requires nmap
# installed)

alias portscan='nmap -sT -A'

# Show which ports are in use

alias ports='sudo netstat -tulpan | sort'

# Show which processes are using the internet connection

alias inetapps='lsof -P -i -n'

# Start an instant PHP web server in the current directory (requires php-cli
# installed)

alias webserver='php -S localhost:8000'

# Alternative: instant Python web server in the current directory

alias pywebserver='python3 -m http.server 8000'

# Public IP address

alias myip='curl ident.me'

# Public IP address and geolocation information in a column layout

alias ipinfo='curl -s ipinfo.io | sed -e "s/\",//g" | tr -d "{\"}" | column'


### Shell ###

# Show the name of the currently running shell

alias whatshell='ps -p $$ | tail -n 1 | grep -o "[^ ]*$"'

# Wipe out the running shell’s history

alias wipehist='history -c; history -w'


### Desktop ###

# Emergency Plasma desktop restart (just a GUI restart, without logoff)

alias restart-plasma='pkill plasmashell && plasmashell &'

# Emergency Plasma desktop logoff (if GUI is unresponsive)

alias logoff-plasma='qdbus org.kde.ksmserver /KSMServer logout 0 0 0'

# Force regenerate the font cache in case new fonts don’t show up

alias updatefontcache='sudo fc-cache -f -v'

# Fix "unknown media type in type" warnings in KDE

alias kdemimefix='sudo sh -c "rm /usr/share/mime/packages/kde.xml && update-mime-database /usr/share/mime"'


### Media ###

# Brief OpenGL information

alias glinfo='info=$(glxinfo) && echo $info | grep "^OpenGL vendor string: " | head -n 1 | cut -d " " -f 4- | tr -d "\n" && printf " "  && echo $info | grep "^OpenGL renderer string: " | head -n 1 | cut -d " " -f 4- | tr -d "\n" && printf ", OpenGL " && echo $info | grep "^OpenGL version string: " | head -n 1 | cut -d " " -f 4-'

# Brief Vulkan information

alias vkinfo='info=$(vulkaninfo) && printf "Vulkan version: " && echo $info | grep "^Vulkan Instance Version: " | cut -d " " -f 4- | tr -d "\n" && printf ", GPUs: " && echo $info | grep "^GPU id : " | cut -d " " -f 5- | tr ":" "," | tr -d "\n" && echo'

# List all PulseAudio sinks and sources, minus monitors

alias palist='LANG=C pactl list sinks | grep -P "\tDescription: " | cut -d " " -f 2- && LANG=C pactl list sources | grep -P "\tDescription: " | cut -d " " -f 2- | grep -v "Monitor of"'

# List PulseAudio sinks

alias pasinks='LANG=C pactl list sinks | grep -P "\tDescription: " | cut -d " " -f 2-'

# List PulseAudio sources, minus monitors

alias pasources='LANG=C pactl list sources | grep -P "\tDescription: " | cut -d " " -f 2- | grep -v "Monitor of"'

# Play a “ding” sound (requires pulseaudio-utils and sound-theme-freedesktop
# installed), with fallback to the system beep

alias ding='command -v paplay >/dev/null && paplay /usr/share/sounds/freedesktop/stereo/complete.oga || printf \\a'

# Display a random picture from the internet as console ASCII art (requires
# jp2a and ncurses-bin installed)

alias randompic='jp2a --colors --border https://picsum.photos/$(tput cols)/$(tput lines)'

# Play some ambient pink noise with a band pass around human voice frequencies
# (requires sox installed)

alias pinknoise='play -c 2 -n synth pinknoise band -n 2500 4000 reverb 20'

# Fix: attempt to set all connected bluetooth devices to high quality A2DP
# mode (requires pulseaudio-utils installed)

alias bta2dp='for card in $(pacmd list-cards | grep "name: " | sed "s/.*<\(.*\)>.*/\1/"); do { printf "$card … "; pacmd set-card-profile $card a2dp_sink; } done; printf "\n"'

# Wipe all image thumbnails to free space or to have them regenerated

alias wipethumbs='rm -rf ~/.cache/thumbnails'


    ###############
### SHELL FUNCTIONS ###
    ###############

### General ###

# Shell pocket calculator (pure sh; you might need to quote the input;
# requires bc installed)

calc (){
  printf "%.8g\n" $(printf "%s\n" "$*" | bc -l)
}


### Package management ###

# Show which package installed a command

whatinstalled () {
  local cmdpath=$(realpath -eP $(which -a $1 | grep -E "^/" | tail -n 1) 2>/dev/null) && [ -x "$cmdpath" ] && dpkg -S $cmdpath 2>/dev/null | grep -E ": $cmdpath\$" | cut -d ":" -f 1
}

# List the binaries installed by a package

binaries () {
  for f in $(dpkg -L "$1" | grep "/bin/"); do
    basename "$f"
  done
}


### Filesystem ###

# Wrapper for unpacking archive files

ex () {
  if [ -f "$1" ] ; then
    case $1 in
      *.tar)            tar xvf $1 ;;
      *.tar.gz|*.tgz)   tar xvzf $1 ;;
      *.tar.bz2|*.tbz2) tar xvjf $1 ;;
      *.tar.xz|*.txz)   tar xvJf $1 ;;
      *.gz)             gunzip $1 ;;
      *.bz2)            bunzip2 $1 ;;
      *.xz)             xz -d $1 ;;
      *.zip)            unzip $1 ;;
      *.rar)            unrar x $1 ;;
      *.Z)              uncompress $1 ;;
      *.7z)             7zr x $1 ;;
      *)                echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Securely wipe free disk space in the given directory (requires secure-delete
# installed)

wipefree () {
  sudo sh -c "sfill -f -v $1"
}

# Show the available I/O schedulers for the given device

listioschedulers () {
  [ -z "$1" ] && echo "Please specify a disk (e.g. sda)." && return
  cat /sys/block/$1/queue/scheduler | tr -d "[]" | tr -s " " "\n"
}

# Show the active I/O scheduler for the given device

getioscheduler () {
  [ -z "$1" ] && echo "Please specify a disk (e.g. sda)." && return
  cat /sys/block/$1/queue/scheduler | cut -f 2 -d "[" | cut -f 1 -d "]"
}

# Set the I/O scheduler $2 for a given device $1

setioscheduler () {
  [ "$#" != "2" ] && echo "Please specify a disk (e.g. sda) and I/O scheduler (e.g. cfq)." && return
  sudo sh -c "echo $2 > /sys/block/$1/queue/scheduler && echo -n 'Done. Active scheduler: ' && cat /sys/block/$1/queue/scheduler"
}
