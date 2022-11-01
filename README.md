# TODO Helper
collect all your TODO's and notes in one place!

## about
### Why Haskell?
I wanted to do a mini project to learn Haskell, but I didn't expect that this project would be mainly IO's xd
## preparation for use
- Linux
``` shell
git clone https://github.com/Hukasx0/TODOhelper
cd TODOhelper/
chmod +x preparation_lin.sh && preparation_lin.sh
```
- Windows
``` cmd
git clone https://github.com/Hukasx0/TODOhelper
cd TODOhelper
.\preparation_win.bat
```
## usage
- Linux
``` shell
./TODO      # displays TODO's or help menu if TODO.log is empty
./TODO <filename>       # adds file TODO if file contains TODO 
./TODO n "place to put your note"       # add custom note
./TODO d            # delete all TODO's
```
- Windows
``` cmd
.\TODO
.\TODO <filename>
.\TODO n "place to put your note"
.\TODO d
```