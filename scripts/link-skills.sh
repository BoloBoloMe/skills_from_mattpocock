#!/usr/bin/env bash
set -euo pipefail

# 将仓库中的所有 skills 链接到 ~/.claude/skills，以便
# 本地 Claude CLI 可以使用它们。

REPO="$(cd "$(dirname "$0")/.." && pwd)"
DEST="$HOME/.claude/skills"

# 如果 ~/.claude/skills 是一个解析到此仓库内的符号链接，我们最终会
# 把每个 skill 的符号链接写回仓库自己的 skills/ 树。检测这种情况，
# 并直接退出，避免污染工作副本。
if [ -L "$DEST" ]; then
  resolved="$(readlink -f "$DEST")"
  case "$resolved" in
    "$REPO"|"$REPO"/*)
      echo "错误：$DEST 是指向此仓库内部的符号链接（$resolved）。" >&2
      echo "请删除它（rm \"$DEST\"）后重新运行；脚本会把它重新创建为真实目录。" >&2
      exit 1
      ;;
  esac
fi

mkdir -p "$DEST"

find "$REPO/skills" -name SKILL.md -not -path '*/node_modules/*' -not -path '*/deprecated/*' -print0 |
while IFS= read -r -d '' skill_md; do
  src="$(dirname "$skill_md")"
  name="$(basename "$src")"
  target="$DEST/$name"

  if [ -e "$target" ] && [ ! -L "$target" ]; then
    rm -rf "$target"
  fi

  ln -sfn "$src" "$target"
  echo "已链接 $name -> $src"
done
