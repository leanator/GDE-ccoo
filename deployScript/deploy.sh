#!/bin/sh 
export LC_ALL=en_US.UTF-8 
export LANG=en_US.UTF-8 
export LANGUAGE=en_US.UTF-8 
dirWAR="/usr/local/tomcat/webapps" 
export VAR_URI_NEXUS=$1
export VAR_VERSION_MODULO=$2
export VAR_NOMBRE_ARTEFACTO=$3

echo $VAR_URI_NEXUS
echo $VAR_VERSION_MODULO
echo $VAR_NOMBRE_ARTEFACTO
url="http://${VAR_URI_NEXUS}/${VAR_NOMBRE_ARTEFACTO}/${VAR_VERSION_MODULO}/${VAR_NOMBRE_ARTEFACTO}-${VAR_VERSION_MODULO}.war"
echo $url
echo "Bajando artefacto"
curl $url --output $dirWAR/ccoo-web.war
