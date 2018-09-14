set -e

/sbin/syslogd -n -O /dev/stdout &
PID=$!

cd /root
curl -L "https://juicefs.io/static/juicefs" -o juicefs
chmod +x juicefs

./juicefs auth "${JFS_VOL}" --token "${JFS_TOKEN}" --accesskey "${JFS_ACCESS_KEY}" --secretkey "${JFS_SECRET_KEY}"
./juicefs mount "${JFS_VOL}" /mnt/juicefs --cache-size 100000 --writeback --metacache

rpcbind
rpc.statd -L
cat<<EOF>/etc/ganesha/ganesha.conf
EXPORT{
    Export_Id = 77;
    Path = /mnt/juicefs;
    Pseudo = /;
    FSAL {
        name = VFS;
    }
    Access_type = RW;
    Protocols = 4;
}
EOF

cat<<EOF>/etc/samba/smb.conf
   workgroup = WORKGROUP
   bind interfaces only = yes
   logging = syslog
   server role = standalone server
   usershare allow guests = yes

[share]
   path = /mnt/juicefs
   browsable = yes
   guest ok = yes
   read only = yes
EOF
/usr/bin/ganesha.nfsd -N NIV_EVENT
smbd

wait "${PID}"
