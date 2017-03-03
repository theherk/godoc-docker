for p in ${GO_PKGS}; do go get -d -v $p; done
godoc -http=":6060"
