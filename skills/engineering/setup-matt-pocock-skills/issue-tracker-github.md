# 议题跟踪器: GitHub

本仓库的 issue 和 PRD 存在于 GitHub issues 中. 所有操作使用 `gh` CLI.

## 约定

- **创建 issue**: `gh issue create --title "..." --body "..."`. 多行 body 使用 heredoc.
- **读取 issue**: `gh issue view <number> --comments`, 用 `jq` 过滤评论并获取 labels.
- **列出 issue**: `gh issue list --state open --json number,title,body,labels,comments --jq '[.[] | {number, title, body, labels: [.labels[].name], comments: [.comments[].body]}]'` 配合适当的 `--label` 和 `--state` 过滤器.
- **对 issue 评论**: `gh issue comment <number> --body "..."`
- **应用/移除 label**: `gh issue edit <number> --add-label "..."` / `--remove-label "..."`
- **关闭**: `gh issue close <number> --comment "..."`

从 `git remote -v` 推断仓库 - `gh` 在 clone 中运行时自动完成.

## Pull request 作为 triage surface

**PR 作为请求表面: no.** _(如果本仓库将外部 PR 视为功能请求, 设置为 `yes`; `/triage` 读取此标志.)_

当设置为 `yes` 时, PR 使用 `gh pr` 等效命令走与 issue 相同的 label 和状态:

- **读取 PR**: `gh pr view <number> --comments` 和 `gh pr diff <number>` 查看 diff.
- **列出外部 PR 进行 triage**: `gh pr list --state open --json number,title,body,labels,author,authorAssociation,comments` 然后仅保留 `authorAssociation` 为 `CONTRIBUTOR`, `FIRST_TIME_CONTRIBUTOR` 或 `NONE` 的 (丢弃 `OWNER`/`MEMBER`/`COLLABORATOR`).
- **评论/label/关闭**: `gh pr comment`, `gh pr edit --add-label`/`--remove-label`, `gh pr close`.

GitHub 在 issue 和 PR 之间共享一个编号空间, 所以一个裸 `#42` 可能是两者之一 - 用 `gh pr view 42` 解决, 回退到 `gh issue view 42`.

## 当技能说 "publish to the issue tracker"

创建一个 GitHub issue.

## 当技能说 "fetch the relevant ticket"

运行 `gh issue view <number> --comments`.
