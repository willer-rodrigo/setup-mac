#! /bin/bash

# XCode
sudo xcode-select --install
sudo xcode-select --switch /Applications/Xcode.app

#OhMyZsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

# Plugins
sh -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"

echo '

SPACESHIP_PROMPT_ORDER=(
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  hg            # Mercurial section (hg_branch  + hg_status)
  exec_time     # Execution time
  line_sep      # Line break
  vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)
SPACESHIP_USER_SHOW=always
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_CHAR_SYMBOL="❯"
SPACESHIP_CHAR_SUFFIX=" "

# Plugins
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions

alias work="cat ~/.ssh/config-work > ~/.ssh/config && cat ~/.gitconfig-work > ~/.gitconfig"
alias personal="cat ~/.ssh/config-personal > ~/.ssh/config && cat ~/.gitconfig-personal > ~/.gitconfig"

' >> ~/.zshrc

# Remove warnings on your terminal.app
compaudit | xargs chmod g-w,o-w

touch ~/.ssh/config-work
touch ~/.ssh/config-personal
touch ~/.ssh/gitconfig-personal
touch ~/.ssh/gitconfig-work

# Git Multiple SSH Config
echo '
# Work GitHub account
Host github.com
  HostName github.com
  User git
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/builders
' >> ~/.ssh/config-work

echo '
# Personal GitHub account
Host github.com
  HostName github.com
  User git
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_rsa
' >> ~/.ssh/config-personal

echo '
# This is Gits per-user configuration file.
[user]

# Please adapt and uncomment the following lines:
	name = Your Name
	email = your@email.com
' >> ~/.gitconfig-personal

echo '
# This is Gits per-user configuration file.
[user]

# Please adapt and uncomment the following lines:
	name = Your Name
	email = your@email.com
' >> ~/.gitconfig-work

# End
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
echo "\n\n${GREEN}Setup finished!"
echo "🚨🚨🚨 ${RED}DONT FORGET ${GREEN}to set your ssh name and email in ${RED}~/.gitconfig-personal ${GREEN}and ${RED}~/.gitconfig-work ${GREEN}files!"
echo "⚠️⚠️⚠️ ${RED}DONT FORGET ${GREEN}to add your ssh new keys with ${RED}ssh-add -K ~/.ssh/builders ${GREEN}and ${RED}ssh-add -K ~/.ssh/id_rsa ${GREEN}commands!"
echo "${YELLOW}HAVE A NICE DAY, ${GREEN}CODING! ❤️💻\n\n"
