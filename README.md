# dotfiles



## 软件安装管理

```bash
# For M1/M2
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# For X86_64
softwareupdate --install-rosetta
arch -x86_64 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
mv /usr/local/bin/brew /usr/local/bin/ibrew
alias ibrew="arch -x86_64 /usr/local/bin/ibrew"


brew --prefix [package]
brew info [package]
brew install mas
```

[mas-cli/mas: :package: Mac App Store command line interface](https://github.com/mas-cli/mas)

[macos - installing python@3.7 MacBook Air m1 problem - Stack Overflow](https://stackoverflow.com/questions/70315418/installing-python3-7-macbook-air-m1-problem)

## Shell/Terminal

```bash
brew install zsh
sh -c "$(wget -O- https://install.ohmyz.sh/)"
cp /path/.zshrc ~/.zshrc
```

[ohmyzsh/ohmyzsh](https://github.com/ohmyzsh/ohmyzsh)

## CLI工具

```bash
brew install cmake gnu-sed wget
brew install zoxide exa bat dust erdtree bottom htop
brew install fzf fd ripgrep
brew install starship tldr navi
brew install hyperfine
brew install neovim
```

`cd`: [ajeetdsouza/zoxide: A smarter cd command. Supports all major shells.](https://github.com/ajeetdsouza/zoxide)

`ls`: [ogham/exa: A modern replacement for ‘ls’.](https://github.com/ogham/exa)

`cat`: [sharkdp/bat: A cat(1) clone with wings.](https://github.com/sharkdp/bat)

`du`: [bootandy/dust: A more intuitive version of du in rust](https://github.com/bootandy/dust)

`tree`: [solidiquis/erdtree](https://github.com/solidiquis/erdtree)

`top`: [ClementTsang/bottom: Yet another cross-platform graphical process/system monitor.](https://github.com/ClementTsang/bottom)

`top`: [htop-dev/htop: htop - an interactive process viewer](https://github.com/htop-dev/htop)

`find`: [sharkdp/fd: A simple, fast and user-friendly alternative to 'find'](https://github.com/sharkdp/fd)

fuzzy `find`: [junegunn/fzf: :cherry_blossom: A command-line fuzzy finder](https://github.com/junegunn/fzf)

search: [BurntSushi/ripgrep: ripgrep recursively searches directories for a regex pattern while respecting your gitignore](https://github.com/BurntSushi/ripgrep)

prompt: [starship/starship: ☄🌌️ The minimal, blazing-fast, and infinitely customizable prompt for any shell!](https://github.com/starship/starship)

cli cheatsheet: [tldr-pages/tldr: 📚 Collaborative cheatsheets for console commands](https://github.com/tldr-pages/tldr)

cli cheatsheet: [denisidoro/navi: An interactive cheatsheet tool for the command-line](https://github.com/denisidoro/navi)

benchmark: [sharkdp/hyperfine: A command-line benchmarking tool](https://github.com/sharkdp/hyperfine)

## 字体

```bash
brew tap homebrew/cask-fonts  # You only need to do this once!
brew install --cask font-sf-mono
brew install --cask font-fira-code
brew install --cask font-roboto-mono
brew install --cask font-dejavu-sans-mono
brew install --cask font-symbols-only-nerd-font
brew install --cask sf-symbols
```

## 编程

```bash
brew install autoenv
ibrew install python@3.8
brew install python # default 3.11 now
# Rust
# lisp
# Node
```

关于Python

```bash
##### 系统自带 #####
/Applications/Xcode.app/Contents/Developer/usr/bin/python3
# 等价于
/usr/bin/python3
# 包地址
/usr/bin/python3 -m site

##### X86 #####
python3.8
##### M1/2 #####
python3.11
```

