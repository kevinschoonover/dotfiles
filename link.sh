for service in nvim sway waybar alacritty mako kitty; do
  ln -rs $service/.config/$service ~/.config/
done

ln -rs ./tmux/.tmux.conf ~/.tmux.conf
ln -rs ./git/.gitconfig ~/.gitconfig
