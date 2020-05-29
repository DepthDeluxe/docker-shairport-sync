[![depthdeluxe](https://circleci.com/gh/depthdeluxe/docker-shairport-sync.svg?style=svg)](https://app.circleci.com/pipelines/github/DepthDeluxe/docker-shairport-sync)

[shairport-sync](https://github.com/mikebrady/shairport-sync) is an Apple AirPlay receiver. It can receive audio directly from iOS devices, iTunes, etc. Multiple instances of shairport-sync will stay in sync with each other and other AirPlay devices when used with a compatible multi-room player, such as iTunes or [forked-daapd](https://github.com/jasonmc/forked-daapd).

## Run

    docker run -d \
        --net host \
        --device /dev/snd \
        -e AIRPLAY_NAME=Docker \
        -e OUTPUT_DEVICE=default \
        -e OUTPUT_DEVICE=true \
        depthdeluxe/shairport-sync

### Parameters

* `--net host` must be run in host mode
* `--device /dev/snd` share host alsa system with container. Does not require `--privileged` as `-v /dev/snd:/dev/snd` would
* `-e AIRPLAY_NAME=Docker` set the AirPlay device name. Defaults to Docker
* `-e OUTPUT_DEVICE=default` sets the shairport-sync output device.  Defaults to `default` which is specified by the parent system
* `-e WITH_AVAHI=true` configures the system to run with the Avahi daemon inside the container.  Default is `true`.
* extra arguments will be passed to shairport-sync (try `-- help`)

## More examples

Send output to a named pipe:

    mkfifo /some/pipe
    docker run -d \
        --net host \
        -v /some/pipe:/output \
        kevineye/shairport-sync \
            -o pipe \
            -- /output
