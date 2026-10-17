@echo off
chcp 65001 >nul
cd /d "%~dp0"
set "PATH=%ProgramFiles%\nodejs;%PATH%"

echo ====================================
echo   一键发布博客（同步+验证+推送）
echo ====================================

echo [1/4] 同步网页端的最新改动...
git pull origin source --rebase
if errorlevel 1 (
    echo [错误] 同步失败，可能有冲突
    pause
    exit /b 1
)

echo [2/4] 本地构建验证文章格式...
call hexo clean >nul 2>&1
call hexo generate >nul 2>&1
if errorlevel 1 (
    echo [错误] 构建失败，请检查文章格式
    pause
    exit /b 1
)

echo [3/4] 提交更改...
git add -A
git diff --cached --quiet
if errorlevel 1 (
    git commit -m "更新博客"
) else (
    echo     没有需要提交的更改
)

echo [4/4] 推送到 GitHub，自动构建上线...
git push origin source
if errorlevel 1 (
    echo [错误] 推送失败，请检查网络
    pause
    exit /b 1
)

echo ====================================
echo   完成！GitHub 正在自动构建
echo   约 2-3 分钟后生效：
echo   https://wyr520.github.io/cake/
echo ====================================
pause
