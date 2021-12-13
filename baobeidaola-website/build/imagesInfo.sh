
cmd.exe /C imagesInfo.bat

sed -i 's/_v[0-9]\+"/"/g' images_info.js
echo ok