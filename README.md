# Windscribe-HTTPproxy-dockerized
Let's you use any Windscribe server over a HTTP proxy. Uses Docker so multiple HTTP proxies at different locations can be created on the same machine simultaneously!

Note you need to copy `env.sample` to `.env` and fill it with your windscribe account details for this to work. It should consist of the following:

```
WINDSCRIBE_USERNAME=        # Insert Windscribe account username here
WINDSCRIBE_PASSWORD=        # Corresponding account password

#Optional
LOCAL_PORT=                 # Local port number to run HTTP proxy on (8888 is default)
WINDSCRIBE_COUNTRY=         # Change VPN server country (Current location as determined by Windscribe is default)
```

WINDSCRIBE_COUNTRY is completely optional and LOCAL_PORT will need to be changed per Docker instance to resolve port conflicts.

You can start docker with [`localproxy.sh`](https://github.com/jay-to-the-dee/Windscribe-HTTPproxy-dockerized/blob/master/localproxy.sh) script for the correct parameters to be passed to Docker.

Or if you have Docker Compose installed you can just do `docker-compose up -d`.
