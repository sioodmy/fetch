#!/bin/bash
# Author: https://github.com/rxyhn 

magenta="\033[1;35m"
green="\033[1;32m"
white="\033[1;37m"
blue="\033[1;34m"
red="\033[1;31m"
black="\033[1;40;30m"
yellow="\033[1;33m"
cyan="\033[1;36m"
reset="\033[0m"
bgyellow="\033[1;43;33m"
bgwhite="\033[1;47;37m"
c0=${reset}
c1=${magenta}
c2=${green}
c3=${white}
c4=${blue}
c5=${red}
c6=${yellow}
c7=${cyan}
c8=${black}
c9=${bgyellow}
c10=${bgwhite}

getUptime() {

  # Parse the system-uptime since boot.
  IFS=. read -r s _ </proc/uptime

  # Convert uptime into readable value.
  d="$((s / 60 / 60 / 24))"
  h="$((s / 60 / 60 % 24))"
  m="$((s / 60 % 60))"

  # Hide empty fields and make the output of uptime smaller.
  [ "$d" -eq 0 ] || UPTIME="${d}d "
  [ "$h" -eq 0 ] || UPTIME="${UPTIME}${h}h "
  [ "$m" -eq 0 ] || UPTIME="${UPTIME}${m}m "
  [  -n  "$m"  ] || UPTIME="${UPTIME}${s}s ${sp}"

  # Show system-uptime information.
  printf "${rs}%s" "${UPTIME%,\ }"

}

user="${USER}"
shell="$(basename ${SHELL})"
distro=$(. /etc/os-release ; echo "$ID")
wm="$(xprop -id $(xprop -root -notype | awk '$1=="_NET_SUPPORTING_WM_CHECK:"{print $5}') -notype -f _NET_WM_NAME 8t | grep "WM_NAME" | cut -f2 -d \")"
kernel="$(uname -r | cut -d '-' -f1)"
disk="$(df --output=pcent / | tail -n 1)"
memory="$(free --mega | awk 'NR == 2 { print $3"/"$2"" }')"

printf '%b' "
             ${c1}os${c3}    ${distro}
             ${c2}ker${c3}   ${kernel}  
     ${c3}•${c8}_${c3}•${c0}     ${c7}wm${c3}    ${wm}
     ${c8}${c0}${c9}oo${c0}${c8}|${c0}     ${c4}sh${c3}    ${shell}
    ${c8}/${c0}${c10} ${c0}${c8}'\'${c0}    ${c6}up${c3}    $(getUptime)
   ${c9}(${c0}${c8}\_;/${c0}${c9})${c0}    ${c1}disk${c3} ${disk}
             ${c2}ram${c3}   ${memory}  

      ${c6}󰮯  ${c6}${c2}󰊠  ${c2}${c4}󰊠  ${c4}${c5}󰊠  ${c5}${c7}󰊠  ${c7}

\033[0m
"
