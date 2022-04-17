for service in nvim sway waybar alacritty mako; do
  ln -rs $service/.config/$service ~/.config/
done
