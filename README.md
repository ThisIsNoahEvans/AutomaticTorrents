# AutomaticTorrents
[WIP] Automatically add &amp; download torrents over VPN, then rename &amp; move them

## Important
This project is in very early stages and is barely functional. Currently, only a Transmission web client and NordVPN connection is available.

You should not deploy this. If you would like something similar, try [docker-transmission-openvpn](https://github.com/haugene/docker-transmission-openvpn).

Only NordVPN is supported for now. Custom OpenVPN configuration will be available soon.

## Functionality
- [x] Transmission Web Client
- [x] Automatic NordVPN connection
- [ ] Embedded Firefox browser to find & download torrent files
- [ ] Automatically add downloaded torrent files to Transmission
- [ ] Send notifications when torrent starts/completes
- [ ] Automatically move completed torrent data to a location and rename; for example, to a Plex library folder

## Building
Whilst this project is nowhere near completion, you may build it by cloning the repo, opening a Terminal to the `AutomaticTorrents` directory, and running the below commands:

`docker build -t thisisnoahevans/automatictorrents .`
`docker run --name=automatictorrents -e NORD_USERNAME=username -e NORD_PASSWORD=password -e NORD_SERVER_ID=server -e NORD_PROTOCOL=proto -p 9091:9091 --cap-add=NET_ADMIN --device /dev/net/tun -d thisisnoahevans/automatictorrents`

Find your NordVPN username & password [here](https://my.nordaccount.com/dashboard/nordvpn) and add them to the command.

Then choose a server (here)[https://nordvpn.com/servers/tools]. It's reccomended that you choose a server in your country for speed & latency, however you may wish to choose another for privacy or blocking reasons. You're reccomended to choose a P2P server type, as this increases performance in Transmission when finding peers. Add the server ID to the command in the format `uk2239`. 

For a security protocol, select either OpenVPN UDP or OpenVPN TCP and specify this as `udp` or `tcp` in the command.

After checking the logs to see `Initialization Sequence Completed`, OpenVPN will be connected. This usually takes a couple of seconds. Transmision will also be running on port 9091 of your host. 