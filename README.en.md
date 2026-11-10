[中文](README.md) | **English**

# AReaL official plugin marketplace

The default plugin source built into AReaL Harness. The product fetches this repository in the background and keeps using the last snapshot when a fetch fails.

## Layout

| File | Purpose |
| --- | --- |
| `.agents/plugins/marketplace.json` | Plugin entries: name, source (a folder in this repository, or an external repository pinned to a commit), `category`, and featured (`tags` contains `featured`). |
| `connectors.json` | Connector map. Maps connector IDs declared in other harnesses' `.app.json` files to public remote MCP endpoints and their sign-in method. Installation resolves a connector into an ordinary MCP server; unknown IDs show as "not supported yet". |
| `plugins/<name>/` | Plugins maintained in this repository. |

## First batch

| Plugin | Contents | What the user does |
| --- | --- | --- |
| Web search `web-search` | Exa hosted MCP (`web_search_exa`, `web_fetch_exa`) plus a Skill on when to search and how to cite | Nothing. Works anonymously with rate limits |
| GitHub `github` | GitHub's official remote MCP | Paste a GitHub personal access token |
| Library docs `context7` | Context7 hosted MCP for current library documentation | Nothing |
| Secret guard `secret-guard` | A PreToolUse hook that blocks tool calls touching `.env`, SSH and cloud credentials, and private keys | Confirm the hook once |
| Chrome DevTools `chrome-devtools` | Chrome DevTools MCP, started locally with `npx` | Needs Node.js and Chrome |
| Linear `linear` | Linear's official remote MCP | Sign in to Linear |
| Notion `notion` | Notion's official remote MCP | Sign in to Notion |
| Heptabase `heptabase` | Heptabase's official plugin, pinned to an upstream commit | Sign in to Heptabase |
| Browser control, Computer control | Skills that use AReaL's built-in `browser_v1` and `computer_v1` tools | Nothing (computer control must be enabled in Settings and granted OS permissions) |

## Adding a plugin or connector mapping

Open a pull request:

- Own plugin: add an Agent Plugins 1.0.0 package under `plugins/` (`plugin.json`, `mcp.json`, `skills/`); a plugin with hooks puts `hooks/hooks.json` in the same package (hooks in Claude-format packages do not run), then add an entry to `marketplace.json`.
- Third-party plugin: add only its source to `marketplace.json`; a `git-subdir` `ref` must be a full commit SHA.
- Connector mapping: add an item to `services` in `connectors.json`, with the raw IDs in `aliases` and `mcp` / `auth` in the Agent Plugins server and `com.openai` auth shapes.

No release is needed; users see the change on their next refresh.

## License

Content authored here is Apache-2.0. Plugins from external sources keep their own licenses. Each remote service is subject to its own terms.
