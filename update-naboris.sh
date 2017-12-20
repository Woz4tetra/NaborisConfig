mkdir -p ./naboris/etc/network
sudo cp /etc/network/interfaces ./naboris/etc/network/interfaces

sudo cp /etc/dnsmasq.conf ./naboris/etc

mkdir -p ./naboris/etc/hostapd/hostapd.conf
sudo cp /etc/hostapd/hostapd.conf ./naboris/etc/hostapd/dnsmasq.conf

sudo cp /etc/rc.local ./naboris/etc
