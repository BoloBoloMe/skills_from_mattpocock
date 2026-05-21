---
name: scaffold-exercises
description: 创建包含章节、题目、解答和讲解的练习目录结构，并确保通过 lint。当用户想搭建练习、创建练习存根，或设置新的课程章节时使用。
---

# 搭建练习

创建能通过 `pnpm ai-hero-cli internal lint` 的练习目录结构，然后用 `git commit` 提交。

## 目录命名

- **章节**：位于 `exercises/` 内的 `XX-section-name/`（例如 `01-retrieval-skill-building`）
- **练习**：位于某个章节内的 `XX.YY-exercise-name/`（例如 `01.03-retrieval-with-bm25`）
- 章节编号 = `XX`，练习编号 = `XX.YY`
- 名称使用短横线命名法（dash-case，小写、连字符）

## 练习变体

每个练习至少需要以下子文件夹之一：

- `problem/` - 学生工作区，包含 TODO
- `solution/` - 参考实现
- `explainer/` - 概念材料，不含 TODO

创建存根时，除非计划另有说明，否则默认使用 `explainer/`。

## 必需文件

每个子文件夹（`problem/`、`solution/`、`explainer/`）都需要一个 `readme.md`，并且它必须：

- **非空**（必须有真实内容，即使只有一行标题也可以）
- 没有损坏的链接

创建存根时，创建一个包含标题和描述的最小 readme：

```md
# 练习标题

在此写描述
```

如果子文件夹包含代码，还需要一个 `main.ts`（超过 1 行）。但对于存根，只包含 readme 的练习也可以。

## 工作流

1. **解析计划** - 提取章节名称、练习名称和变体类型
2. **创建目录** - 对每个路径使用 `mkdir -p`
3. **创建 readme 存根** - 每个变体文件夹一个 `readme.md`，包含标题
4. **运行 lint** - 使用 `pnpm ai-hero-cli internal lint` 验证
5. **修复所有错误** - 反复处理直到 lint 通过

## Lint 规则摘要

lint 检查器（linter，`pnpm ai-hero-cli internal lint`）会检查：

- 每个练习都有子文件夹（`problem/`、`solution/`、`explainer/`）
- 至少存在 `problem/`、`explainer/` 或 `explainer.1/` 之一
- 主子文件夹中存在 `readme.md` 且非空
- 没有 `.gitkeep` 文件
- 没有 `speaker-notes.md` 文件
- readme 中没有损坏的链接
- readme 中没有 `pnpm run exercise` 命令
- 除非是仅 readme 的练习，否则每个子文件夹都需要 `main.ts`

## 移动/重命名练习

重新编号或移动练习时：

1. 使用 `git mv`（不是 `mv`）重命名目录 - 保留 git 历史
2. 更新数字前缀以保持顺序
3. 移动后重新运行 lint

示例：

```bash
git mv exercises/01-retrieval/01.03-embeddings exercises/01-retrieval/01.04-embeddings
```

## 示例：根据计划创建存根

给定如下计划：

```
第 05 节：记忆技能构建
- 05.01 记忆简介
- 05.02 短期记忆（explainer + problem + solution）
- 05.03 长期记忆
```

创建：

```bash
mkdir -p exercises/05-memory-skill-building/05.01-introduction-to-memory/explainer
mkdir -p exercises/05-memory-skill-building/05.02-short-term-memory/{explainer,problem,solution}
mkdir -p exercises/05-memory-skill-building/05.03-long-term-memory/explainer
```

然后创建 readme 存根：

```
exercises/05-memory-skill-building/05.01-introduction-to-memory/explainer/readme.md -> "# 记忆简介"
exercises/05-memory-skill-building/05.02-short-term-memory/explainer/readme.md -> "# 短期记忆"
exercises/05-memory-skill-building/05.02-short-term-memory/problem/readme.md -> "# 短期记忆"
exercises/05-memory-skill-building/05.02-short-term-memory/solution/readme.md -> "# 短期记忆"
exercises/05-memory-skill-building/05.03-long-term-memory/explainer/readme.md -> "# 长期记忆"
```
