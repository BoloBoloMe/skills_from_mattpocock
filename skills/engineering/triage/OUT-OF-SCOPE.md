# 超出范围知识库

仓库中的 `.out-of-scope/` 目录存储被拒绝功能请求的持久记录. 它有两个目的:

1. **机构记忆** - 为什么一个功能被拒绝, 所以推理在 issue 关闭时不会丢失
2. **去重** - 当一个新 issue 进来时匹配先前拒绝, 技能可以提出先前决策而不是重新辩论

## 目录结构

```
.out-of-scope/
|---- dark-mode.md
|---- plugin-system.md
`---- graphql-api.md
```

每个 **概念** 一个文件, 不是每个 issue. 多个请求同一东西的 issue 被归在一个文件下.

## 文件格式

文件应以轻松, 可读的风格写 - 更像短设计文档而不是数据库条目. 使用段落, 代码示例和示例使推理清晰有用, 给第一次遇到它的人.

```markdown
# Dark Mode

This project does not support dark mode or user-facing theming.

## Why this is out of scope

The rendering pipeline assumes a single color palette defined in
`ThemeConfig`. Supporting multiple themes would require:

- A theme context provider wrapping the entire component tree
- Per-component theme-aware style resolution
- A persistence layer for user theme preferences

This is a significant architectural change that doesn't align with the
project's focus on content authoring. Theming is a concern for downstream
consumers who embed or redistribute the output.

```ts
// The current ThemeConfig interface is not designed for runtime switching:
interface ThemeConfig {
  colors: ColorPalette; // single palette, resolved at build time
  fonts: FontStack;
}
```

## Prior requests

- #42 - "Add dark mode support"
- #87 - "Night theme for accessibility"
- #134 - "Dark theme option"
```

### 文件命名

使用短的, 描述性的 kebab-case 名称命名概念: `dark-mode.md`, `plugin-system.md`, `graphql-api.md`. 名称应足够可辨认, 让浏览目录的人不需打开文件就理解什么被拒绝了.

### 写理由

理由应有实质 - 不是 "我们不想要这个" 而是 为什么. 好的理由参考:

- 项目范围或理念 ("本项目聚焦 X; theming 是下游关注")
- 技术约束 ("支持这个需要 Y, 与我们的 Z 架构冲突")
- 战略决策 ("我们选择使用 A 而不是 B 因为...")

理由应持久. 避免引用暂时情况 ("我们现在太忙") - 那些不是真正的拒绝, 是推迟.

## 何时检查 `.out-of-scope/`

在 triage (步骤 1: 收集上下文) 中, 读取 `.out-of-scope/` 中所有文件. 当评估新 issue 时:

- 检查请求是否匹配已有的 out-of-scope 概念
- 匹配按概念相似性, 不是关键词 - "night theme" 匹配 `dark-mode.md`
- 如果有匹配, 向维护者提出: "这与 `.out-of-scope/dark-mode.md` 类似 - 我们之前拒绝了它因为 [理由]. 你现在还是同样的看法吗?"

维护者可以:

- **确认** - 新 issue 被添加到已有文件的 "Prior requests" 列表, 然后关闭
- **重新考虑** - out-of-scope 文件被删除或更新, issue 经过正常 triage
- **不同意** - issue 相关但不同, 继续正常 triage

## 何时写入 `.out-of-scope/`

仅当一个 **enhancement** (不是 bug) 被以 `wontfix` *拒绝* 时. 这同样适用于 enhancement PR - 被拒绝的 PR 记录在这里, 以便相同请求不会以新鲜代码返回.

当某物因 **已实现** 而被以 `wontfix` 关闭时 **不要** 写入这里. 那是一个已构建的功能, 不是被拒绝的; 记录它会用虚假拒绝毒化去重检查. 取而代之, 关闭评论指向功能已存在的位置.

流程:

1. 维护者决定功能请求超出范围
2. 检查匹配的 `.out-of-scope/` 文件是否已存在
3. 如果有: 将新 issue 追加到 "Prior requests" 列表
4. 如果没有: 用概念名称, 决策, 理由和第一个先前请求创建新文件
5. 在 issue 上发布解释决策的评论并提及 `.out-of-scope/` 文件
6. 以 `wontfix` label 关闭 issue

## 更新或删除 out-of-scope 文件

如果维护者对先前被拒绝的概念改变了想法:

- 删除 `.out-of-scope/` 文件
- 技能不需要重新打开旧 issue - 它们是历史记录
- 触发重新考虑的新 issue 经过正常 triage
