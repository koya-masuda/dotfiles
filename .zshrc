# copy and paste
alias clip='iconv -f UTF-8 -t CP932 | clip.exe'
alias paste='powershell.exe -Command Get-Clipboard'

# alias
alias bruby='bundle exec ruby'
alias brails='bundle exec rails'
alias brake='bundle exec rake'
alias brspec='bundle exec rspec'
alias b='bundle install'
alias bexec='bundle exec'
alias grun='go run'
alias open='explorer.exe'
alias vim='nvim'
alias vi='vim'
alias kubectl='minikube kubectl --'

# ls拡張
alias la='ls -a --color=auto'
alias ll='ls -lht --color=auto'
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# parallel-ssh
alias pssh='parallel-ssh'

# cdr
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':chpwd:*' recent-dirs-max 500
zstyle ':chpwd:*' recent-dirs-default yes

# git alias
alias g='git'
alias gs='git switch'
alias gsm='git switch master'
alias gsc='git switch -c'
alias gc='git commit'
alias gpush='git push origin HEAD'
alias gp='git pull'
alias gpull='git pull origin master'
alias gst='git status'
alias gsth='git stash'
alias ga='git add'
alias gmm='git merge master'
alias gm='git merge'
alias gd='git diff ^HEAD'
alias gl='git log --graph --oneline'
alias gg='git graph'
alias gb='git branch'
alias gr='git reset'
alias grh='git reset --hard'

# docker
alias d='docker'
alias de'docker exec'
alias dc='docker-compose'
alias dcud='docker-compose up -d'

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# Load pure theme
zinit ice pick"async.zsh" src"pure.zsh" # with zsh-async library that's bundled with it.
zinit light sindresorhus/pure
# promptの色を変える
zstyle :prompt:pure:path color green
zstyle :prompt:pure:git:branch color red

# シェルでシンタックスハイライトを効かせる
zinit light zdharma-continuum/fast-syntax-highlighting
# コマンド補完拡張
zinit light zsh-users/zsh-completions
# 予測補完
zinit light zsh-users/zsh-autosuggestions

function fzf-cdr() {
    local target_dir=`cdr -l | sed 's/^[^ ][^ ]*  *//' | fzf --query "$LBUFFER"`
    if [ -n "$target_dir" ]; then
        BUFFER="cd ${target_dir}"
        zle accept-line
    fi
}
zle -N fzf-cdr
bindkey "^[" fzf-cdr

setopt hist_expire_dups_first # 履歴を切り詰める際に、重複する最も古いイベントから消す
setopt hist_ignore_all_dups   # 履歴が重複した場合に古い履歴を削除する
setopt share_history          # 全てのセッションで履歴を共有する

# awscli s3 lsをpecoに渡す
zinit light koya-masuda/peco-s3arch

function gitmain() {
  git config --global user.name "Koya Masuda"
  git config --global user.email "koya.masuda@rooter.co.jp"
}

function gitsub() {
  git config --global user.name "koya-masuda"
  git config --global user.email "masuda.58.koya@gmail.com"
}
