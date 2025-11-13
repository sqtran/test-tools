#!/bin/bash

awk '
  NR==1 {
    print $0
    next
  }
  function hex2dec(hex) { return strtonum("0x" hex) }
  function iphex_to_dec(iphex) {
    ip = ""
    for (i=1; i<=8; i+=2) {
      octet = substr(iphex, 9 - i - 1, 2)
      ip = ip ? ip "." hex2dec(octet) : hex2dec(octet)
    }
    return ip
  }
  function state_decode(state) {
    states["01"]="ESTABLISHED"; states["02"]="SYN_SENT"; states["03"]="SYN_RECV"
    states["04"]="FIN_WAIT1"; states["05"]="FIN_WAIT2"; states["06"]="TIME_WAIT"
    states["07"]="CLOSE"; states["08"]="CLOSE_WAIT"; states["09"]="LAST_ACK"
    states["0A"]="LISTEN"; states["0B"]="CLOSING"
    return states[state] ? states[state] : "UNKNOWN"
  }
  NR>1 {
    split($2, la, ":")
    l_ip = iphex_to_dec(la[1])
    l_port = hex2dec(la[2])
    split($3, ra, ":")
    r_ip = iphex_to_dec(ra[1])
    r_port = hex2dec(ra[2])
    conn_state = state_decode($4)
    printf "%-4s %-15s:%-5d %-15s:%-5d %-12s %s %s %s %s %s %s %s %s\n", $1, l_ip, l_port, r_ip, r_port, conn_state, $5, $6, $7, $8, $9, $10, $11, $12
  }
' /proc/net/tcp