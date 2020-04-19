# How to run

## 1. start mock server
```bash
docker-compose -f docker/docker-compose.yml up
```

## 2. configure and start your implementation.

This is specific to your app.

## 3. update config.sh to match your implementation

Adjust config file so it points to your API and sends the right payload.
Be aware that methods might need to be adjusted in run.sh as well.
