@echo off
cd /d %~dp0
setlocal enabledelayedexpansion

set Pic=*.jpg,*.jpeg,*.png,*.bmp,*.gif
call :PicVBS

(
echo module.exports = {
for /f "delims=" %%a in ('dir /a-d/s/b %Pic%') do (
for /f "tokens=1-4 delims=x" %%b in ('cscript -nologo "%tmp%\GetImgInfo.vbs" "%%~sa"') do (
::echo %%~nxa  像素: %%~bx%%~c  分辨率: %%~d dpi 原始格式: %%~e
echo "%%~na":{"width":%%~b,"height":%%~c,"name":"%%~nxa"},
 )
)
echo })>images_info.js

pause
exit
:PicVBS
(echo '获取图片文件的宽、高、DPI、格式
echo On Error Resume Next
echo Dim Img
echo Set Img = CreateObject^("WIA.ImageFile"^)
echo Img.LoadFile WScript.Arguments^(0^)
echo Wscript.Echo Img.Width ^& "x" ^& Img.Height ^& "x" ^& Img.HorizontalResolution ^& "x" ^& Img.FileExtension)>"%tmp%\GetImgInfo.vbs"
goto :eof
