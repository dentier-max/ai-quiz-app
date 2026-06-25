@echo off
chcp 65001 >nul
echo ========================================
echo   题宝 TiBo - 离线安装包
echo ========================================
echo.
echo 正在创建桌面快捷方式...

set "SHORTCUT_NAME=题宝 TiBo"
set "SHORTCUT_URL=https://dentier-max.github.io/ai-quiz-app/"
set "DESKTOP=%USERPROFILE%\Desktop"

(echo [InternetShortcut]
echo URL=%SHORTCUT_URL%
echo IconIndex=0) > "%DESKTOP%\%SHORTCUT_NAME%.url"

echo.
echo ✅ 桌面快捷方式已创建！
echo.
echo 使用说明：
echo 1. 双击桌面"题宝 TiBo"图标即可打开
echo 2. 首次打开后，浏览器会自动缓存所有数据
echo 3. 之后即使断网也能正常使用！
echo 4. Chrome浏览器可以点击地址栏右侧的安装图标
echo    将题宝安装为独立APP（像桌面软件一样）
echo.
echo ========================================
pause
