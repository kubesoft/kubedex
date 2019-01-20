#!/bin/bash -e

cd "$(dirname "$0")"

mkdir -p state gen

STATE=state/state.yaml
CONFIG=state/config.yaml
MANIFEST=gen/manifest.yaml
TMP=/tmp/state$$

if [ ! -f "$STATE" ]; then
  echo "---" > "$STATE"
fi


mv "$STATE" "$STATE.bak"

spiff merge - rules.yaml "$CONFIG" "$STATE.bak" <<<"state:" > "$STATE" || ( mv "$STATE.bak" "$STATE"; exit 1 )
spiff merge template.yaml rules.yaml "$CONFIG" "$STATE" > "$MANIFEST"
