**中文** | [English](README.en.md)

# AReaL 官方插件市场

AReaL Harness 内置的默认插件来源。产品在后台拉取本仓库；拉取失败时继续使用上一次的快照。

## 目录

| 文件 | 作用 |
| --- | --- |
| `.agents/plugins/marketplace.json` | 插件条目：名称、来源（本仓库子目录，或固定到提交的外部仓库）、分类 `category`、精选（`tags` 含 `featured`）。 |
| `connectors.json` | 连接器映射表。把别家插件 `.app.json` 里声明的连接器 ID 对应到公开的远程 MCP 地址和登录方式。安装时据此把连接器解析成普通 MCP 服务；表里没有的 ID 显示“此服务暂不支持”。 |
| `plugins/<name>/` | 本仓库自己维护的插件包。 |

## 第一批插件

| 插件 | 内容 | 用户要做什么 |
| --- | --- | --- |
| 网页搜索 `web-search` | Exa 托管 MCP（`web_search_exa` 搜索、`web_fetch_exa` 读正文），加一个教模型何时搜索、怎么引用来源的 Skill | 无。匿名可用，有频率限制 |
| GitHub `github` | GitHub 官方远程 MCP | 填一个 GitHub 个人访问令牌 |
| 库文档查询 `context7` | Context7 托管 MCP，查开源库当前版本的文档 | 无 |
| 敏感文件保护 `secret-guard` | 一个 PreToolUse Hook，拦下读写 `.env`、SSH 和云凭据、私钥文件的工具调用 | 确认一次 Hook |
| Chrome 调试 `chrome-devtools` | Chrome DevTools MCP（本机 `npx` 启动） | 本机需要 Node.js 和 Chrome |
| Linear `linear` | Linear 官方远程 MCP | 登录 Linear |
| Notion `notion` | Notion 官方远程 MCP | 登录 Notion |
| Heptabase `heptabase` | Heptabase 官方插件，固定到上游提交 | 登录 Heptabase |
| 浏览器控制、电脑控制 | 调用 AReaL 内置 `browser_v1`、`computer_v1` 工具的 Skill | 无（电脑控制需在设置里开启并授予系统权限） |

## 新增插件或连接器映射

向本仓库提 PR：

- 自维护插件：在 `plugins/` 下加一个 Agent Plugins 1.0.0 包（`plugin.json`、`mcp.json`、`skills/`）；带 Hook 的插件把 `hooks/hooks.json` 放在同一个包里（Claude 格式包里的 Hook 不执行），再在 `marketplace.json` 加一条。
- 第三方插件：只在 `marketplace.json` 写来源，`git-subdir` 的 `ref` 必须是完整提交号。
- 连接器映射：在 `connectors.json` 的 `services` 加一条，`aliases` 写原始 ID，`mcp` 与 `auth` 沿用 Agent Plugins MCP 服务和 `com.openai` 认证声明的格式。

不需要发版，合并后用户下次刷新即可看到。

## 许可

本仓库自有内容按 Apache-2.0 发布。外部来源的插件按其各自的许可证。各远程服务的使用受其服务条款约束。
