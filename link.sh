for service in nvim sway waybar alacritty; do
  ln -rs $service/.config/$service ~/.config/
done
