# JuiceFS Gateway

```
docker run --detach \
    -p 111:111 \
    -p 111:111/udp \
    -p 662:662 \
    -p 2049:2049 \
    -p 137:137/udp \
    -p 138:138/udp \
    -p 139:139 \
    -p 445:445 \
    --init \
    --privileged \
    --cap-add SYS_ADMIN \
    --device /dev/fuse \
    --env JFS_VOL=volume-name \
    --env JFS_TOKEN=token-of-juicefs-volume \
    --env JFS_ACCESS_KEY=access-key \
    --env JFS_SECRET_KEY=secret-key \
    juicedata/juicefs-gateway:latest
```
