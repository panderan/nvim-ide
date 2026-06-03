param(
  [Parameter(Position = 0)]
  [string]$Action,
  [Parameter(Position = 1)]
  [string]$ProxyUrl = "socks5://127.0.0.1:7897"
)

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$globalProxy = git config --global --get http.proxy 2>$null

switch ($Action) {
  "enable" {
    git config --global http.proxy $ProxyUrl
    git config --global https.proxy $ProxyUrl
    Write-Host "[git-proxy] 已启用代理: $ProxyUrl" -ForegroundColor Green
  }
  "disable" {
    git config --global --unset http.proxy 2>$null
    git config --global --unset https.proxy 2>$null
    Write-Host "[git-proxy] 已取消代理" -ForegroundColor Yellow
  }
  default {
    $httpProxy = git config --global --get http.proxy 2>$null
    $httpsProxy = git config --global --get https.proxy 2>$null
    if ($httpProxy -or $httpsProxy) {
      Write-Host "[git-proxy] 当前代理设置:" -ForegroundColor Cyan
      if ($httpProxy) { Write-Host "  http.proxy  = $httpProxy" }
      if ($httpsProxy) { Write-Host "  https.proxy = $httpsProxy" }
    } else {
      Write-Host "[git-proxy] 未设置代理" -ForegroundColor Gray
    }
  }
}
