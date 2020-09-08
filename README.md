<p align="center">
  <img src="data/icons/128/com.github.sergius02.qrit.svg" alt="Icon" />
</p>
<h1 align="center">QRit</h1>

----------

|![alt](screenshots/QRit.png) |![alt](screenshots/QRit2.png)|
|---------------------|---------------------|
|![alt](screenshots/QRit3.png) |![alt](screenshots/QRit4.png)|

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
# install elementary-sdk, meson and ninja
sudo apt install elementary-sdk meson ninja
# install qrencode
sudo apt install qrencode
# clone repository
git clone https://github.com/sergius02/QRit QRit
# cd to dir
cd QRit
# run meson
meson build --prefix=/usr
# cd to build, build and test
cd build
ninja
sudo ninja install
```

## Credits

* [qrencode](https://github.com/fukuchi/libqrencode)
* [REMIXICON](https://remixicon.com/)
* [Visual studio code](https://code.visualstudio.com/)

----------

If you like my work you can

<a href="https://www.buymeacoffee.com/sergius02" target="_blank"><img src="https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png" alt="Buy Me A Coffee" style="height: 41px !important;width: 174px !important;box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;-webkit-box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;" ></a>