#!/bin/sh

PATH=/sbin:/usr/sbin:$PATH

do_pre_init() {
   iptables-restore < /etc/iptables/simple_firewall.rules
}

do_connect() {
    ip addr flush dev $TUNDEV
    ip link set $TUNDEV up  mtu $INTERNAL_IP4_MTU
    ip addr add $INTERNAL_IP4_ADDRESS/$INTERNAL_IP4_NETMASK dev $TUNDEV
    ip route add 8.8.8.8 dev $TUNDEV
    ip route add 8.8.4.4 dev $TUNDEV
    ip route add default dev $TUNDEV table fuckgfw
    ip rule | grep -q 'from all fwmark 0xc8 lookup fuckgfw' || \
    ip rule add fwmark 200 table 200
}

do_disconnect() {
   ip link set $TUNDEV down
   ip addr flush dev $TUNDEV
   ip rule del from all fwmark 0xc8 lookup fuckgfw
}

if [ -z "$reason" ]; then
	echo "this script must be called from vpnc" 1>&2
	exit 1
fi

case "$reason" in
	pre-init)
		do_pre_init
		;;
	connect)
		do_connect
		;;
	disconnect)
		do_disconnect
		;;
	reconnect)
		do_disconnect
		do_connect
		;;
	*)
		echo "unknown reason '$reason'. Maybe vpnc-script is out of date" 1>&2
		exit 1
		;;
esac

exit 0
