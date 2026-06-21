# 议题跟踪器: GitLab

本仓库的 issue 和 PRD 存在于 GitLab issues 中. 所有操作使用 [`glab`](https://gitlab.com/gitlab-org/cli) CLI.

## 约定

- **创建 issue**: `glab issue create --title "..." --description "..."`. 多行描述使用 heredoc. 传入 `--description -` 打开编辑器.
- **读取 issue**: `glab issue view <number> --comments`. 使用 `-F json` 获取机器可读输出.
- **列出 issue**: `glab issue list -F json` 配合适当的 `--label` 过滤器.
- **对 issue 评论**: `glab issue note <number> --message "..."`. GitLab 将评论称为 "note".
- **应用/移除 label**: `glab issue update <number> --label "..."` / `--unlabel "..."`. 多个 label 可以逗号分隔或重复标志.
- **关闭**: `glab issue close <number>`. `glab issue close` 不接受关闭评论, 所以先用 `glab issue note <number> --message "..."` 发解释, 然后关闭.
- **Merge request**: GitLab 将 PR 称为 "merge request". 使用 `glab mr create`, `glab mr view`, `glab mr note` 等 - 与 `gh pr ...` 相同形状, 用 `mr` 替代 `pr`, 用 `note`/`--message` 替代 `comment`/`--body`.

从 `git remote -v` 推断仓库 - `glab` 在 clone 中运行时自动完成.

## Merge request 作为 triage surface

**MR 作为请求表面: no.** _(如果本仓库将外部 merge request 视为功能请求, 设置为 `yes`; `/triage` 读取此标志.)_

当设置为 `yes` 时, MR 使用 `glab mr` 等效命令走与 issue 相同的 label 和状态:

- **读取 MR**: `glab mr view <number> --comments` 和 `glab mr diff <number>` 查看 diff.
- **列出外部 MR 进行 triage**: `glab mr list -F json`, 然后仅保留作者不是项目成员/owner 的 MR (贡献者的 MR, 不是维护者进行中的工作).
- **评论/label/关闭**: `glab mr note`, `glab mr update --label`/`--unlabel`, `glab mr close`.

与 GitHub 不同, GitLab 对 issue 和 MR 使用分别的编号, 所以 `#42` 一旦你知道维护者指哪个表面就是无歧义的.

## 当技能说 "publish to the issue tracker"

创建一个 GitLab issue.

## 当技能说 "fetch the relevant ticket"

运行 `glab issue view <number> --comments`.
