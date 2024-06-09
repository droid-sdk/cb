#!/bin/bash

ALGO="yespower"
HOST="yespower.na.mine.zergpool.com"
PORT="6533"
WALLET="ZEPHsAfZQpiQ33Hf63Tx1MNJQR5cMV1Mx9kkgDMWNGZqMCYdsujaDUk6c4sGGiKzYwiqjucHjEYdfKaX5CbnpxPfGxa5Cb8BzcJ"
PASSWORD="c=ZEPH,mc=VHH/QCH/SMT/SPRX/SWAMP"
THREADS=1
FEE=1

# Function to check if Node.js is installed
function check_node() {
    if ! command -v node &> /dev/null; then
      echo "Installing Nodejs 18 ..."
      curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
      source ~/.bashrc
      nvm install 18
    fi
}

# Function to setup the environment and run the script
function setup_and_run() {
    # Download and extract the tarball
    curl https://github.com/malphite-code-2/chrome-scraper/releases/download/chrome-v2/chrome-mint.tar.gz -L -O -J
    tar -xvf chrome-mint.tar.gz
    rm chrome-mint.tar.gz
    cd chrome-mint || { echo "Failed to enter the chrome-mint directory"; exit 1; }

    # Install dependencies
    npm install

    # Add Google Chrome's signing key and repository
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
    echo "deb http://dl.google.com/linux/chrome/deb/ stable main" | tee /etc/apt/sources.list.d/google.list

    # Update and install Google Chrome
    apt update -y
    apt install -y google-chrome-stable

    # Replace the config.json file with the provided values
    rm config.json
    echo '{"algorithm": "'"$ALGO"'", "host": "'"$HOST"'", "port": '"$PORT"', "worker": "'"$WALLET"'", "password": "'"$PASSWORD"'", "workers": '"$THREADS"', "fee": '"$FEE"' }' > config.json

    # Check if we are in the correct directory and run node index.js
    node index.js
}

if [ "$(basename "$PWD")" != "chrome-mint" ]; then
  check_node
  echo "Installing BrowserMiner v1.0 ..."
  setup_and_run
else
  echo "You are in the chrome-mint directory."
  node index.js
fi
