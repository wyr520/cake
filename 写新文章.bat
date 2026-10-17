@echo off
chcp 65001 >nul
cd /d "%~dp0"
set "PATH=%ProgramFiles%\nodejs;%PATH%"
set /p title=请输入新文章标题（回车确认）：
if "%title%"=="" (
    echo 标题不能为空！
    pause
    exit /b 1
)
call hexo new "%title%"
echo.
echo 文章已创建，去 source\_posts 文件夹里编辑它，
echo 写完后双击「一键发布博客.bat」即可上线！
pause
