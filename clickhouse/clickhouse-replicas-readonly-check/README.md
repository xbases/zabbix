# Zabbix Clickhouse replicas table is readonly check

* clickhouse_replicas_readonly_check.conf
  
  Zabbix UserParameter

* clickhouse_replicas_readonly_check.sh
  
  use clickhouse-client get system.replicas info

* zbx_clickhouse_replicas_readonly_check.xml
  
  zabbix template
  
## Install

1. download clickhouse_replicas_readonly_check.conf clickhouse_replicas_readonly_check.sh zbx_clickhouse_replicas_readonly_check.xml files.

2. upload clickhouse_replicas_readonly_check.conf clickhouse_replicas_readonly_check.sh to /etc/zabbix/zabbix_agentd.d/ who running clickhouse server

3. import zbx_clickhouse_replicas_readonly_check.xml to zabbix
