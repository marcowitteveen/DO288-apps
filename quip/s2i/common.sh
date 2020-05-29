# common shell routines for s2i scripts

# insert settings for HTTP proxy into settings.xml if supplied as
# separate variables HTTP_PROXY_HOST, _PORT, _SCHEME, _USERNAME,
# _PASSWORD, _NONPROXYHOSTS
function configure_proxy_write() {
  local settings="${1:-$HOME/.m2/settings.xml}"
  if [ -n "$HTTP_PROXY_HOST" -a -n "$HTTP_PROXY_PORT" ]; then
    xml="<proxy>\
         <id>genproxy</id>\
         <active>true</active>\
         <protocol>${HTTP_PROXY_SCHEME:-http}</protocol>\
         <host>$HTTP_PROXY_HOST</host>\
         <port>$HTTP_PROXY_PORT</port>"
    if [ -n "$HTTP_PROXY_USERNAME" -a -n "$HTTP_PROXY_PASSWORD" ]; then
      xml="$xml\
         <username>$HTTP_PROXY_USERNAME</username>\
         <password>$HTTP_PROXY_PASSWORD</password>"
    fi
    if [ -n "$HTTP_PROXY_NONPROXYHOSTS" ]; then
      xml="$xml\
         <nonProxyHosts>$HTTP_PROXY_NONPROXYHOSTS</nonProxyHosts>"
    fi
  xml="$xml\
       </proxy>"
    local sub="<!-- ### configured http proxy ### -->"
    sed -i "s^${sub}^${xml}^" "$settings"
  fi
}

# break a supplied url (as would be in HTTP_PROXY) up into constituent bits and
# export the bits as variables that match our old scheme for configuring proxies
# $settings - file to edit
function configure_proxy_url() {
"common.sh" [readonly] 180L, 5746C

