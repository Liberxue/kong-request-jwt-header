
# kong-request-jwt-header

## Install 

```bash
    luarocks install kong-request-jwt-header
```

## Run kong By Docker

```bash
    bash run.sh
```

```bash
# Create sign in API
curl -X POST \
  --url http://localhost:8001/services/ \
  --data 'name=mock-Post-JWT-service' \
  --data 'url=http://httpbin.org/' 
```
```bash 

```bash
```
# Create consumer
curl -X POST -H 'Content-Type: application/json' -d '{"username": "test"}' localhost:8001/consumers

curl -X POST -d 'key=value' http://localhost:8001/test
```