#!/bin/bash

# clickhouse-client path

CLICKHOUSE_CLI=/usr/bin/clickhouse-client

SQL_DB_TABLES="select database,table from system.replicas;"

SQL_READONLY="select database,table,is_readonly from system.replicas;"

function discover_db_tables() {
  TMP=$(mktemp)
  pre="{\"data\":["
  post="]}"
  item_list=""

  $CLICKHOUSE_CLI -m -q "$SQL_DB_TABLES" 1>$TMP

  while read line; do
    db_name=$(echo $line | awk '{print $1}')
    table_name=$(echo $line | awk '{print $2}')
    item="{\"{#DB}\":\"$db_name\",\"{#TABLE}\":\"$table_name\"},"
    item_list="$item_list$item"
  done <$TMP

  item_list=$(echo $item_list | sed 's/\(.*\),$/\1/g')
  echo "${pre}${item_list}${post}"
  rm -f $TMP
}

function query_replicas_readonly() {
  TMP=$(mktemp)
  pre="{\"is_readonly\":{"
  post="}}"
  item_dict=""

  $CLICKHOUSE_CLI -m -q "$SQL_READONLY" 1>$TMP

  while read line; do
    db_name=$(echo $line | awk '{print $1}')
    table_name=$(echo $line | awk '{print $2}')
    is_readonly=$(echo $line | awk '{print $3}')
    item="\"${db_name}_T_${table_name}\":${is_readonly},"
    item_dict="${item_dict}${item}"
  done <$TMP

  item_dict=$(echo $item_dict | sed 's/\(.*\),$/\1/g')
  echo "${pre}${item_dict}${post}"
  rm -f $TMP
}

case $1 in
discover) discover_db_tables ;;
is_readonly) query_replicas_readonly ;;
esac
