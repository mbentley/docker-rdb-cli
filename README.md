# mbentley/rdb-cli

Docker image for [rdb-cli](https://github.com/redis/librdb) which can be used to migrate from redis to valkey, even if you are running redis >= 7.4 which uses a proprietary data format.

## Tags

* `latest` - multi-arch for `amd64` and `arm64`

## Usage

```bash
docker run -it --rm \
  -v /path/with/your/rdb/file:/data \
  -w /data \
  mbentley/rdb-cli \
    rdb-cli /data/dump.rdb -l /dev/stdout redis -h <valkey-host-IP> -p <valkey-port-number>
```

`rdb-cli` will log to stdout with `-l /dev/stdout` or if you remove the argument, it will create a log in the present working directory - in this example, in the volume used as `rdb-cli.log`. For full usage info, run `rdb-cli` as the command without arguments.

Currently, `rdb-cli` seems to only support non-TLS and IP addresses, not hostnames.
