@echo off
chcp 65001 >nul
cd /d "%~dp0"
set "PATH=%ProgramFiles%\nodejs;%PATH%"
echo ====================================
echo   正在构建并发布博客...
echo ====================================
call hexo clean
call hexo generate
if errorlevel 1 (
    echo [错误] 构建失败，请检查文章格式
    pause
    exit /b 1
)
call hexo deploy
if errorlevel 1 (
    echo [错误] 发布失败，请检查网络
    pause
    exit /b 1
)
echo ====================================
echo   发布完成！约 1 分钟后生效：
echo   https://wyr520.github.io/cake/
echo ====================================
pause
