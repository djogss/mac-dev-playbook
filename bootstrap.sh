#!/bin/sh

# Bootstrap new OSX system with common CLI utilities and scripts.

# Pre-requisites 
# Download xcode-select from  https://developer.apple.com/downloads/index.action

echo "Dev machine bootstrap start"

# Installing brew
# Check to see if Homebrew is installed, and install it if it is not
command -v brew >/dev/null 2>&1 || { echo >&2 "Installing Homebrew Now"; \
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"; }

#sudo easy_install pip
#sudo pip install ansible

brew install git

echo "Creating directory structure"
GITLIBS=$HOME/workspaces/tools/gitlibs
dirs=($GITLIBS)

for dir in ${dirs[*]}
do
	printf "%s\n" $dir
	mkdir -p $dir
done


# Clone macOS setup repository
if [ ! -d "$GITLIBS/mac-dev-playbook" ]; then
git clone https://github.com/djogss/mac-dev-playbook.git $GITLIBS/mac-dev-playbook
fi

cd $GITLIBS/mac-dev-playbook
ansible-galaxy install -r requirements.yml

cd ..
git clone https://github.com/djogss/dotfiles.git

echo "Dev machine bootstrap finish"
