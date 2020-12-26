# Configs for terminal view

* All terminal profiles  
```
dconf list /org/gnome/terminal/legacy/profiles:/
```

* List of variables for one of them  
```
dconf list /org/gnome/terminal/legacy/profiles:/:hash/
```

* Read variable  
```
dconf read /org/gnome/terminal/legacy/profiles:/:hash/palette
```

* Favorite palette configs
```
[
  'rgb(255,255,255)', 'rgb(255,80,25)', 'rgb(188,255,45)', 'rgb(255,131,7)',  
  'rgb(89,223,255)', 'rgb(211,54,130)', 'rgb(255,175,95)', 'rgb(255,215,135)',  
  'rgb(255,215,95)', 'rgb(215,95,0)', 'rgb(148,254,121)', 'rgb(135,95,95)',  
  'rgb(95,135,175)', 'rgb(168,168,168)', 'rgb(245,139,139)', 'rgb(0,0,0)'
]
```
