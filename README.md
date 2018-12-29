# Windscribe-HTTPproxy-dockerized
Let's you use any Windscribe server over a HTTP proxy. Uses Docker so multiple HTTP proxies at different locations can be created on the same machine simultaneously!

Note you need to make an executable file called `vars.sh` with your windscribe account details for this to work. It should consist of the following:

```
#!/bin/bash

export WINDSCRIBE_USERNAME=!USERNAME HERE!
export WINDSCRIBE_PASSWORD=!PASSWORD HERE!
WINDSCRIBE_COUNTRY=
LOCAL_PORT=8888
```

WINDSCRIBE_COUNTRY is completely optional and LOCAL_PORT will need to be changed per Docker instance to resolve port conflicts.
