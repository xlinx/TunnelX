# TunnelX


##goLang
https://go.dev/doc/devel/release
https://go.dev/dl/
https://go.dev/wiki/MinimumRequirements

## macOS 14.6.1 go1.25 hhGod
```shell
sw_vers

```

## macOS 10.14 
### tailscale 1.44.3-ERR-BuildInfo 
### go1.20 sdGod

```shell
install tail on mac
brew install go
go install tailscale.com/cmd/tailscale{,d}@main

go install tailscale.com/cmd/tailscale{,d}@v1.44.3

```
## macOS 11.52
### go version go1.24.7 darwin/amd64

```shell
    softwareupdate --list
    sudo softwareupdate --install "Xcode-<version>"

install tail on mac
brew install go@1.23
sudo installer -pkg ./go1.25.1.darwin-amd64.pkg -target /
go install tailscale.com/cmd/tailscale{,d}@main


```
macOS (née OS X, aka Darwin)¶
macOS Sierra 10.12 or higher requires Go 1.7.1 or above.

macOS Monterey 12 or higher requires Go 1.11 or above.

Go 1.15 and later only support macOS Sierra 10.12 or newer; see https://go.dev/doc/go1.15#darwin.

Go 1.17 and later only support macOS High Sierra 10.13 or newer; see https://go.dev/doc/go1.17#darwin.

Go 1.21 and later only support macOS Catalina 10.15 or newer; see https://go.dev/doc/go1.20#darwin.

Go 1.23 and later only support macOS Big Sur 11 or newer; see https://go.dev/doc/go1.23#darwin.

We have builders for macOS 10.14 through macOS 13 as of 2023-05-31.