# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

mdd() {
    mkdir -p $1 &&
    cd $1
}

codee() {
    mkdir -p $1 &&
    code $1 "${@:2}"
}

tch() {
    # error if no arguments
    if [ $# -eq 0 ]; then
        echo "Usage: tch /path/to/file"
        return 1
    fi

    file_path=$(dirname $1)
    file=$(basename $1)
    mkdir -p $file_path && touch $file_path/$file
}   

setupdotvenv() {
    python -m venv .venv
    source .venv/bin/activate
    for f in "requirements.txt" "requirements-dev.txt" do
        if [[ -f $f ]]; then
            pip install -r $f
        fi
}
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
