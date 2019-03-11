{% if grains['osmajorrelease'] == "6" %}
zabbix_filter_accept port accept 6:
  iptables.insert:
    - position: 1
    - table: filter
    - family: ipv4
    - chain: INPUT
    - jump: ACCEPT
    - match:
        -  state
    - connstate: NEW
    - source: 36.110.218.130
    - dport: 10050
    - proto: tcp
    - save: True

configure the iptables 6:
  iptables.insert:
    - position: 1
    - table: filter
    - family: ipv4
    - chain: INPUT
    - jump: ACCEPT
    - match:
        -  state
    - connstate: NEW
    - source: 202.108.253.234,36.110.218.130,36.110.62.179
    - dport: 22
    - proto: tcp
    - save: True
{% endif %}

{% if grains['osmajorrelease'] == "7" %}
zabbix_filter_accept port accept 7:
  cmd.run:
    - names:
      - firewall-cmd --permanent --zone=public --add-rich-rule="rule family="ipv4" source address="36.110.218.130/32" port protocol="tcp" port="10050" accept"
      - firewall-cmd --reload
configure the firewalld 7:
  cmd.run:
    - names:
      - firewall-cmd --permanent --zone=public --add-rich-rule="rule family="ipv4" source address="36.110.62.179/32" port protocol="tcp" port="22" accept"
      - firewall-cmd --permanent --zone=public --add-rich-rule="rule family="ipv4" source address="36.110.218.130/32" port protocol="tcp" port="22" accept"
      - firewall-cmd --permanent --zone=public --add-rich-rule="rule family="ipv4" source address="202.108.253.234/32" port protocol="tcp" port="22" accept"
      - firewall-cmd --reload
{% endif %}


	
