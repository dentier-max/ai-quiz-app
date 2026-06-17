# 一键部署到 GitHub Pages
# 用法: 先修改下面的 USERNAME，然后右键"使用 PowerShell 运行"

$USERNAME = "dentier-max"   # GitHub 用户名
$REPO = "ai-quiz-app"

# 1. 进入文件目录
$DIR = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $DIR

# 2. 初始化 Git 仓库（如果还没有）
if (-not (Test-Path .git)) {
    git init
    Write-Host "✅ Git 仓库已初始化" -ForegroundColor Green
}

# 3. 添加文件并提交
git add index.html
git commit -m "first deploy" 2>$null
if ($LASTEXITCODE -ne 0) {
    git commit -m "first deploy" --allow-empty
}
Write-Host "✅ 文件已提交" -ForegroundColor Green

# 4. 关联远程仓库并推送
git remote remove origin 2>$null
git remote add origin "https://github.com/$USERNAME/$REPO.git"

# 先尝试推送，如果失败可能是仓库不存在
Write-Host "🚀 正在推送到 GitHub..." -ForegroundColor Cyan
git branch -M main
git push -u origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "🎉 部署成功！" -ForegroundColor Green
    Write-Host ""
    Write-Host "请按以下步骤开启 GitHub Pages:" -ForegroundColor Yellow
    Write-Host "1. 打开 https://github.com/$USERNAME/$REPO/settings/pages" -ForegroundColor White
    Write-Host "2. Source 选择 Deploy from a branch" -ForegroundColor White
    Write-Host "3. Branch 选择 main -> /(root) -> Save" -ForegroundColor White
    Write-Host ""
    Write-Host "等待 1-2 分钟后访问:" -ForegroundColor Yellow
    Write-Host "https://$USERNAME.github.io/$REPO/" -ForegroundColor Cyan
} else {
    Write-Host ""
    Write-Host "❌ 推送失败，可能原因:" -ForegroundColor Red
    Write-Host "   - GitHub 仓库不存在，请先创建: https://github.com/new" -ForegroundColor White
    Write-Host "   - 或仓库名不是 $REPO" -ForegroundColor White
    Write-Host "   - 或未登录 GitHub 账号" -ForegroundColor White
}

Write-Host ""
Read-Host "按 Enter 键退出"
