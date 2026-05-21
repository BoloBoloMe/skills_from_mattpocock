# Matt Pocock Skills

一组由 Claude Code 加载的 agent 技能（斜杠命令和行为）。技能按 bucket 组织，并由 `/setup-matt-pocock-skills` 生成的每仓库配置消费。

## 语言

**Issue tracker**：
托管仓库 issue 的工具——GitHub Issues、Linear、本地 `.scratch/` markdown 约定或类似工具。`to-issues`、`to-prd`、`triage` 和 `qa` 等 skills 会读取并写入它。
_避免使用_：backlog manager、backlog backend、issue host

**Issue**：
**Issue tracker** 内单个被跟踪的工作单元——bug、task、PRD，或由 `to-issues` 产出的 slice。
_避免使用_：ticket（仅在引用把它们称为 tickets 的外部系统时使用）

**Triage role**：
Triage 期间应用到 **Issue** 的规范状态机标签（例如 `needs-triage`、`ready-for-afk`）。每个 role 都会通过 `docs/agents/triage-labels.md` 映射到 **Issue tracker** 中真实的标签字符串。

## 关系

- 一个 **Issue tracker** 包含多个 **Issues**
- 一个 **Issue** 一次只携带一个 **Triage role**

## 已标记的歧义

- “backlog” 以前同时表示托管 issues 的*工具*以及其中的*工作集合*——已解决：该工具是 **Issue tracker**；“backlog” 不再作为领域术语使用。
- “backlog backend” / “backlog manager”——已解决：合并为 **Issue tracker**。
