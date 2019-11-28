# Zabbix Linux OS TCP State

* tcp_state.conf
  
  Zabbix UserParameter

* tcp_state.sh
  
  use ss -naH get TCP State info

* zbx_tcp_state.xml
  
  zabbix template
  
## Install

* zabbix >= 3.4

1. download tcp_state.conf tcp_state.sh zbx_tcp_state.xml files.

2. upload tcp_state.conf tcp_state.sh to /etc/zabbix/zabbix_agentd.d/

3. import zbx_tcp_state.xml to zabbix
