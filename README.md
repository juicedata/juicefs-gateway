# JuiceFS Gateway

start container

```
export JFS_VOL="name of JuiceFS volume"
export JFS_TOKEN="token of JuiceFS volume"
export JFS_ACCESS_KEY="access key"
export JFS_SECRET_KEY="secret key"
export JFS_CACHE="docker volume for cache of JuiceFS"

docker run -d -p 2049:2049 -p 137:137/udp -p 138:138/udp -p 139:139 -p 445:445 --init --privileged --cap-add SYS_ADMIN --device /dev/fuse -v "${JFS_CACHE}:/var/jfsCache:z" -e JFS_VOL="${JFS_VOL}" -e JFS_TOKEN="${JFS_TOKEN}" -e JFS_ACCESS_KEY="${JFS_ACCESS_KEY}" -e JFS_SECRET_KEY="${JFS_SECRET_KEY}" juicedata/juicefs-gateway:latest
```

smbclient

```
smbclient //127.0.0.1/share
```

NFS

```
mount -t nfs4 127.0.0.1:/ /mnt/juicefs
```
