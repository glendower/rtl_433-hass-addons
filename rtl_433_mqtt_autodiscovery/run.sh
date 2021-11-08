#!/usr/bin/env bashio

MQTT_HOST=$(bashio::services mqtt "host")
MQTT_PORT=$(bashio::services mqtt "port")
export MQTT_USERNAME=$(bashio::services mqtt "username")
export MQTT_PASSWORD=$(bashio::services mqtt "password")
RTL_TOPIC=$(bashio::config "rtl_topic")
DISCOVERY_PREFIX=$(bashio::config "discovery_prefix")
DISCOVERY_INTERVAL=$(bashio::config "discovery_interval")

OTHER_ARGS=""
if bashio::config.true "mqtt_retain"; then
  OTHER_ARGS="${OTHER_ARGS} --retain"
fi
if bashio::config.true "force_update"; then
  OTHER_ARGS="${OTHER_ARGS} --force_update"
fi
if bashio::config.true "debug"; then
  OTHER_ARGS="${OTHER_ARGS} --debug"
fi

echo "Starting rtl_433_mqtt_hass.py..."
python3 -u /rtl_433_mqtt_hass.py -H $MQTT_HOST -p $MQTT_PORT -R "$RTL_TOPIC" -D "$DISCOVERY_PREFIX" -i $DISCOVERY_INTERVAL $OTHER_ARGS
