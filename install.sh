#!/bin/bash
set -e

export mode=${"compile"}
export PYTHONPATH=${2:-"$PYTHONPATH"}

# pre
sudo apt-get install -y libx11-dev libxkbfile-dev
sudo apt-get install -y libsecret-1-dev
sudo apt-get install -y build-essential

# nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
source ~/.bashrc
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# node
nvm install 12.14.1

# yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update && sudo apt-get -y install yarn


if [[ "$mode" = "compile" ]]; then
    # theia build
    yarn --frozen-lockfile install && \
    NODE_OPTIONS="--max_old_space_size=8192" yarn theia build ; \
    yarn theia download:plugins

    yarn autoclean --init && \
    echo *.ts >> .yarnclean && \
    echo *.ts.map >> .yarnclean && \
    echo *.spec.* >> .yarnclean && \
    yarn autoclean --force && \
    yarn cache clean

    npm run build-deb
elif [[ "$mode" = "download" ]]; then
    echo "NOT IMPLEMENTED"

fi

mkdir $HOME/.theia
cp settings.json $HOME/.theia/ 

DEFAULT_PYTHON="/usr/bin/python"
sed -i -e "s/${DEFAULT_PYTHON}/${PYTHONPATH}/g" $HOME/.theia/settings.json
sudo mkdir /.metals
sudo chown -R $(id -u):$(id -g) /.metals
sudo apt-get install -y ./theia-example_0.0.1_all.deb


