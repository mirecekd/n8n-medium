VERSION=1.104.2
docker rmi n8nio/n8n:latest
docker pull n8nio/n8n:$VERSION
docker tag n8nio/n8n:$VERSION latest
cd ~/DEVEL/n8n
docker build --build-arg VERSION=$VERSION -t mirecekd/n8n:$VERSION .
docker stop n8n
docker rm n8n
docker run -d --name n8n -p 5678:5678 \
           -e GENERIC_TIMEZONE="Europe/Prague" \
           -e TZ="Europe/Prague" \
           -e N8N_EDITOR_BASE_URL="https://n8n.mirecek.org" \
           -e WEBHOOK_URL="https://n8n.mirecek.org/" \
           -e N8N_HOST="n8n.mirecek.org" \
           -e N8N_SECURE_COOKIE=true \
           -e N8N_RUNNERS_ENABLED=true \
           -e N8N_ENDPOINT_WEBHOOK="wh" \
           -e N8N_ENDPOINT_WEBHOOK_TEST="wht" \
           -e N8N_COMMUNITY_PACKAGES_ENABLED=true \
           -e N8N_COMMUNITY_PACKAGES_ALLOW_TOOL_USAGE=true \
           -e N8N_LOG_LEVEL=debug \
           --restart always \
           -v ~/DATA/n8n:/home/node/.n8n \
           mirecekd/n8n:$VERSION
