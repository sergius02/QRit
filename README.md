<p align="center">
  <img src="data/icons/128/com.github.sergius02.qrit.svg" alt="Icon" />
</p>
<h1 align="center">QRit</h1>

![Last Release](https://img.shields.io/github/v/release/sergius02/QRit?include_prereleases&style=for-the-badge)
![Build Status](https://img.shields.io/travis/sergius02/QRit/master?style=for-the-badge)
![License](https://img.shields.io/github/license/sergius02/QRit?style=for-the-badge)

----------

|![alt](screenshots/QRit.png) |![alt](screenshots/QRit2.png)|
|---------------------|---------------------|
|![alt](screenshots/QRit3.png) |![alt](screenshots/QRit4.png)|

<p align="center">
  <a href="https://appcenter.elementary.io/com.github.sergius02.qrit"><img src="https://appcenter.elementary.io/badge.svg" alt="Get it on AppCenter" /></a>
</p>

With QRit you can create awesome QR codes 🤖️, you can change the background and foreground color to help you integrate them in any place.

This application use the incredible [qrencode](https://github.com/fukuchi/libqrencode)

## Dependencies

Ensure you have these dependencies installed

* valac
* glib-2.0
* gtk+-3.0
* [qrencode](https://fukuchi.org/works/qrencode/)

## Install, build and run

```bash
# FOR ELEMENTARY OS USERS
sudo apt install elementary-sdk

# FOR THE REST
sudo apt install cmake libgtk-3-dev gettext

# install meson and ninja
sudo apt install meson ninja-build

# install qrencode
sudo apt install qrencode

# clone repository
git clone https://github.com/sergius02/QRit QRit

# cd to dir
cd QRit

# run meson
meson build --prefix=/usr

# cd to build
cd build

# build
ninja

# install
sudo ninja install
```

Important
>
>For the file QR generation, the limit is approximately 3KB


## Credits

* [qrencode](https://github.com/fukuchi/libqrencode)
* [REMIXICON](https://remixicon.com/)
* [Visual studio code](https://code.visualstudio.com/)

----------

If you like my work you can

<a href="https://www.buymeacoffee.com/sergius02" target="_blank"><img src="https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png" alt="Buy Me A Coffee" style="height: 41px !important;width: 174px !important;box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;-webkit-box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;" ></a>
