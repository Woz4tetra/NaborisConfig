if [[ $EUID -ne 0 ]]
then
   echo "This script must be run as root.\nTry 'sudo bash configure_iptables.sh"
   exit 1
fi

IPT=/sbin/iptables
LOCAL_IFACE=eth0
INET_IFACE=wlan0
INET_ADDRESS="$(ifconfig $INET_IFACE | sed -n '/inet addr/{s/.*addr://;s/ .*//;p}')"

printf "wifi address: %s\n" ${INET_ADDRESS}

if [ ${#INET_ADDRESS} -gt 0 ]
then
        # Flush the tables
        $IPT -F INPUT
        $IPT -F OUTPUT
        $IPT -F FORWARD

        $IPT -t nat -P PREROUTING ACCEPT
        $IPT -t nat -P POSTROUTING ACCEPT
        $IPT -t nat -P OUTPUT ACCEPT

        # Allow forwarding packets:
        $IPT -A FORWARD -p ALL -i $LOCAL_IFACE -j ACCEPT
        $IPT -A FORWARD -i $INET_IFACE -m state --state ESTABLISHED,RELATED -j ACCEPT

        # Packet masquerading
        $IPT -t nat -A POSTROUTING -o $INET_IFACE -j SNAT --to-source $INET_ADDRESS
else
        printf "Wifi not configured!!!\n"
fi

