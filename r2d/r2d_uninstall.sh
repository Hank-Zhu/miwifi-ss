        echo "开始卸载Shadowsocks"
        echo -e "停止相关进程--------------------------------------\c"
        /etc/init.d/myshadowsocks stop 1>/dev/null 2>&1
        /etc/init.d/myshadowsocks disable 1>/dev/null 2>&1
        echo -e "[\e[32m完成\e[37m]"
        echo -e "删除相关文件--------------------------------------\c"
        rm -rf /etc/init.d/myshadowsocks
        rm -rf /etc/dnsmasq.d/dnsmasq_list.conf
        sed -i '/ipset -N gfwlist iphash -!/d' /etc/firewall.user
        sed -i '/iptables -t nat -A PREROUTING -p tcp -m set --match-set gfwlist dst -j REDIRECT --to-port 1081/d' /etc/firewall.user
	/etc/init.d/firewall restart
	/etc/init.d/dnsmasq restart
	echo "卸载Shadowsocks完成"