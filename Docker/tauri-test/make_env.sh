#!/bin/sh
set -eu
echo "LOCALUID=$(id -u)" > .env
echo "LOCALGID=$(id -g)" >> .env
echo "LOCALUNAME=$(whoami)" >> .env
echo ".env was generated."
