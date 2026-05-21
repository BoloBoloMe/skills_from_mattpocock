# 问题跟踪器：GitLab

此仓库的 issue 和 PRD 存放在 GitLab issues 中。所有操作都使用 [`glab`](https://gitlab.com/gitlab-org/cli) CLI。

## 约定

- **创建 issue**：`glab issue create --title "..." --description "..."`。多行 description 使用 heredoc。传入 `--description -` 可打开编辑器。
- **读取 issue**：`glab issue view <number> --comments`。使用 `-F json` 获取机器可读输出。
- **列出 issues**：`glab issue list -F json`，并使用合适的 `--label` 过滤器。
- **评论 issue**：`glab issue note <number> --message "..."`。GitLab 把 comments 称为 “notes”。
- **应用 / 移除 labels**：`glab issue update <number> --label "..."` / `--unlabel "..."`。多个 labels 可以用逗号分隔，或重复传入该 flag。
- **关闭**：`glab issue close <number>`。`glab issue close` 不接受关闭 comment，因此先用 `glab issue note <number> --message "..."` 发布说明，再关闭。
- **合并请求（Merge requests）**：GitLab 把 PR 称为 “merge requests”。使用 `glab mr create`、`glab mr view`、`glab mr note` 等——形态与 `gh pr ...` 相同，只是用 `mr` 替代 `pr`，用 `note`/`--message` 替代 `comment`/`--body`。

从 `git remote -v` 推断仓库——在克隆仓库（clone）内运行时，`glab` 会自动完成这件事。

## 当某个技能说“发布到问题跟踪器（publish to the issue tracker）”时

创建一个 GitLab issue。

## 当某个技能说“获取相关工单（fetch the relevant ticket）”时

运行 `glab issue view <number> --comments`。
