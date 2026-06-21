# 议题跟踪器: 本地 Markdown

本仓库的 issue 和 PRD 存在于 `.scratch/` 目录中的 markdown 文件.

## 约定

- 一个功能一个目录: `.scratch/<feature-slug>/`
- PRD 为 `.scratch/<feature-slug>/PRD.md`
- Implementation issue 为 `.scratch/<feature-slug>/issues/<NN>-<slug>.md`, 从 `01` 开始编号
- Triage 状态记录为每个 issue 文件顶部附近的 `Status:` 行 (见 `triage-labels.md` 中的角色字符串)
- 评论和对话历史追加到文件底部 `## Comments` 标题下

## 当技能说 "publish to the issue tracker"

在 `.scratch/<feature-slug>/` 下创建新文件 (如需则创建目录).

## 当技能说 "fetch the relevant ticket"

读取引用路径的文件. 用户通常会直接传递路径或 issue 编号.
