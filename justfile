
# Use one or several targets to install the software you need. 
# Usage: just <target>
# To list all the targets, use `just --list`
# You need to install just, using apt, you can use `sudo apt install just`

# list all the commands with a short description
default: dev terminal

# basic dev libs
dev:
	sudo apt install -y git git-lfs
	sudo apt install -y curl wget
	sudo apt install -y build-essential cmake
	sudo apt install -y python3-pip
	sudo apt install -y ssh rsync
	sudo apt install -y stow
	sudo apt install -y ffmpeg

# editors for development
dev_tools:
	sudo apt install -y vim neovim
	snap install code --classic
	snap install drawio
	snap install vlc

#  blender, meshlab
design_3d:
	snap install blender --classic
	sudo apt install -y meshlab

# libreoffice
office:
	snap install libreoffice

# slack
communication:
	snap install slack

# better terminal usage
terminal:
	sudo apt install -y terminator
	sudo apt install -y tmux
	sudo apt install -y htop
	sudo apt install -y zsh eza zoxide fzf ripgrep bat fd-find sd

setup_zsh_plugins: terminal
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
	git clone https://github.com/fdellwing/zsh-bat.git $ZSH_CUSTOM/plugins/zsh-bat
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
	sudo apt remove fzf
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install
	git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab

# Add Docker's tools
docker: 
	sudo apt-get update
	sudo apt-get install ca-certificates curl
	sudo install -m 0755 -d /etc/apt/keyrings
	sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
	sudo chmod a+r /etc/apt/keyrings/docker.asc

	# Add the repository to Apt sources:
	echo \
	"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
		$(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
	sudo apt-get update

	# Install Docker
	sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# copy files to cloud providers like google drive
rclone: dev
	sudo -v ; curl https://rclone.org/install.sh | sudo bash

# install python programs globally safely
pipx:
	apt install -y pipx
	pipx ensurepath

# python development
poetry: pipx
	pipx install poetry

python311:
	sudo apt update
	sudo apt install software-properties-common
	sudo add-apt-repository ppa:deadsnakes/ppa 
	sudo apt install -y python3.11

tmux:
	sudo apt install -y tmux tmux-plugin-manager
	sudo apt install -y python3-tmuxp

# copy dotfiles to home directory
stow:
	cd ~/dotfiles
	stow -t ~/ */
	cd ..

