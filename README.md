godoc-docker
============

With this container, you can:

    export GO_PKGS=export GO_PKGS="github.com/spf13/viper github.com/mitchellh/go-homedir"
    docker run -d -e "GO_PKGS=$(GO_PKGS)" -p 6060:6060 --name yourgodoc godoc

and have a running instance of godoc at :6060 with the base packages and any that you installed.

You may also want to install from internal repositories or something more complex than regular go gets. In this case, just replace the run.sh and you should be good to go.
