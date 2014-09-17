#!/bin/sh

sudo apt-get install tree -y
sudo apt-get install curl -y
\curl -L https://get.rvm.io | bash -s stable --ruby --autolibs=enable --auto-dotfiles
sudo mv /bin/sh /bin/sh.orig
sudo ln -s /bin/bash /bin/sh