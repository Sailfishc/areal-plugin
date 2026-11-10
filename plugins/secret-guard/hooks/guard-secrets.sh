#!/bin/sh
# PreToolUse hook: the tool call arrives as JSON on stdin. Exit 2 with a reason on
# stderr blocks the call; exit 0 lets it run. Only POSIX sh and grep are used so
# the hook runs on a stock macOS or Linux install.
payload=$(cat)

# Paths that commonly hold credentials. Example files such as .env.example are allowed.
pattern='(^|[^A-Za-z0-9_.-])\.env(\.[A-Za-z0-9_-]+)?($|[^A-Za-z0-9_.-])|\.ssh/|id_(rsa|dsa|ecdsa|ed25519)($|[^A-Za-z0-9_.-])|\.aws/credentials|\.config/gcloud/|\.kube/config|\.netrc|\.npmrc|\.pypirc|\.docker/config\.json|\.(pem|p12|pfx|key)($|[^A-Za-z0-9_.-])'
allowed='\.env\.(example|sample|template|defaults)($|[^A-Za-z0-9_.-])'

matches=$(printf '%s' "$payload" | grep -oE "$pattern" | grep -vE "$allowed" || true)
if [ -n "$matches" ]; then
  first=$(printf '%s\n' "$matches" | head -n 1 | sed 's/^[^A-Za-z0-9_.~-]*//; s/[^A-Za-z0-9_.~/-]*$//')
  echo "Blocked by Secret guard: this tool call touches a secret file ($first). Ask the user to share the specific value you need, or to turn off Secret guard for this project." >&2
  exit 2
fi
exit 0
