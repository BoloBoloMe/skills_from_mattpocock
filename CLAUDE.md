技能按 bucket 文件夹组织在 `skills/` 下：

- `engineering/` — 日常代码工作
- `productivity/` — 日常非代码工作流工具
- `misc/` — 保留下来但很少使用
- `personal/` — 绑定到我自己的设置，不推广
- `in-progress/` — 尚未准备发布的草稿
- `deprecated/` — 不再使用

`engineering/`、`productivity/` 或 `misc/` 中的每个 skill，都必须在顶层 `README.md` 中有引用，并且在 `.claude-plugin/plugin.json` 中有条目。`personal/`、`in-progress/` 和 `deprecated/` 中的 skill 不得出现在二者中。

顶层 `README.md` 中的每个 skill 条目，都必须把 skill 名称链接到它的 `SKILL.md`。

每个 bucket 文件夹都有一个 `README.md`，列出该 bucket 中的每个 skill 及一行说明，并且 skill 名称链接到它的 `SKILL.md`。
