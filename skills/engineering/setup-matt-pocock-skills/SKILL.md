---
name: setup-matt-pocock-skills
description: 在 AGENTS.md/CLAUDE.md 和 `docs/agents/` 中设置 `## Agent skills` 区块，让工程技能知道此仓库的问题跟踪器（issue tracker，GitHub 或本地 Markdown）、分流标签（triage label）词汇，以及领域文档布局。首次使用 `to-issues`、`to-prd`、`triage`、`diagnose`、`tdd`、`improve-codebase-architecture` 或 `zoom-out` 前运行；如果这些技能似乎缺少问题跟踪器、分流标签或领域文档上下文，也可运行。
disable-model-invocation: true
---

# 设置 Matt Pocock 的技能

搭建工程技能所假定的每仓库配置：

- **问题跟踪器（Issue tracker）**——issue 存放在哪里（默认 GitHub；也内置支持本地 Markdown）
- **分流标签（Triage labels）**——五个标准分流（triage）角色所使用的字符串
- **领域文档**——`CONTEXT.md` 和 ADR 的位置，以及读取它们的消费规则

这是一个由提示驱动的技能，而不是确定性脚本。先探索，展示发现，向用户确认，然后再写入。

## 流程

### 1. 探索

查看当前仓库，理解它的初始状态。读取已经存在的内容；不要假设：

- `git remote -v` 和 `.git/config`——这是 GitHub 仓库吗？是哪一个？
- 仓库根目录的 `AGENTS.md` 和 `CLAUDE.md`——是否存在其中之一？其中是否已经有 `## Agent skills` 区块？
- 仓库根目录的 `CONTEXT.md` 和 `CONTEXT-MAP.md`
- `docs/adr/` 和任何 `src/*/docs/adr/` 目录
- `docs/agents/`——这个技能之前的输出是否已经存在？
- `.scratch/`——表示可能已经在使用本地 markdown issue tracker 约定

### 2. 展示发现并询问

总结已存在和缺失的内容。然后带用户逐一完成三个决策——展示一个区块（section），获得用户回答，再进入下一个。不要一次性倾倒三个问题。

假设用户不知道这些术语是什么意思。每个区块都以简短解释开头（它是什么、为什么这些技能需要它、如果选择不同选项会有什么变化）。然后展示选项和默认值。

**Section A——问题跟踪器（Issue tracker）。**

> 解释：“issue tracker” 是此仓库中 issue 存放的地方。`to-issues`、`triage`、`to-prd` 和 `qa` 等技能会读取并写入它——它们需要知道是调用 `gh issue create`、在 `.scratch/` 下写 markdown 文件，还是遵循你描述的其他工作流。请选择你实际用于此仓库追踪工作的地方。

默认姿态：这些技能是为 GitHub 设计的。如果 `git remote` 指向 GitHub，就建议 GitHub。如果 `git remote` 指向 GitLab（`gitlab.com` 或自托管 host），就建议 GitLab。否则（或如果用户偏好），提供：

- **GitHub**——issue 位于仓库的 GitHub Issues（使用 `gh` CLI）
- **GitLab**——issue 位于仓库的 GitLab Issues（使用 [`glab`](https://gitlab.com/gitlab-org/cli) CLI）
- **本地 markdown**——issue 作为文件存放在此仓库的 `.scratch/<feature>/` 下（适合个人项目或没有 remote 的仓库）
- **其他**（Jira、Linear 等）——请用户用一段话描述工作流；本技能会把它记录为自由形式散文（prose）

**Section B——分流标签（Triage label）词汇。**

> 解释：当 `triage` 技能处理传入 issue 时，它会让 issue 通过一个状态机——需要评估、等待 reporter、准备好由 AFK agent 接手、准备好由人类处理，或不会修复。为此，它需要应用与你*实际配置*的字符串匹配的 labels（或 issue tracker 中等价的东西）。如果你的仓库已经使用不同的 label 名称（例如 `bug:triage` 而不是 `needs-triage`），请在这里映射它们，这样技能会应用正确的 label，而不是创建重复项。

五个标准角色：

- `needs-triage`——maintainer 需要评估
- `needs-info`——等待 reporter
- `ready-for-agent`——已完整说明，适合 AFK（agent 无需人类上下文即可接手）
- `ready-for-human`——需要人类实施
- `wontfix`——不会处理

默认值：每个角色的字符串都等于它自己的名称。询问用户是否想覆盖其中任何一个。如果他们的 issue tracker 没有现有 labels，默认值即可。

**Section C——领域文档。**

> 解释：一些技能（`improve-codebase-architecture`、`diagnose`、`tdd`）会读取 `CONTEXT.md` 文件来了解项目的领域语言，并读取 `docs/adr/` 来了解过去的架构决策。它们需要知道仓库是一个全局上下文，还是多个上下文（例如分别有 frontend/backend 上下文的 monorepo），这样才能在正确位置查找。

确认布局：

- **单上下文**——仓库根目录有一个 `CONTEXT.md` + `docs/adr/`。大多数仓库都是这样。
- **多上下文**——根目录有 `CONTEXT-MAP.md`，指向每个上下文的 `CONTEXT.md` 文件（通常是 monorepo）。

### 3. 确认并编辑

向用户展示以下草稿：

- 要添加到正在编辑的 `CLAUDE.md` / `AGENTS.md` 中的 `## Agent skills` 区块（选择规则见第 4 步）
- `docs/agents/issue-tracker.md`、`docs/agents/triage-labels.md`、`docs/agents/domain.md` 的内容

在写入前允许用户修改。

### 4. 写入

**选择要编辑的文件：**

- 如果 `CLAUDE.md` 存在，编辑它。
- 否则如果 `AGENTS.md` 存在，编辑它。
- 如果两者都不存在，询问用户要创建哪一个——不要替用户选择。

当 `CLAUDE.md` 已存在时，永远不要创建 `AGENTS.md`（反之亦然）——始终编辑已经存在的那个。

如果所选文件中已经存在 `## Agent skills` 区块，就原地更新其内容，而不是追加重复区块。不要覆盖周边 section 中的用户编辑。

区块：

```markdown
## Agent skills

### Issue tracker

[问题追踪位置的一行摘要]。见 `docs/agents/issue-tracker.md`。

### Triage labels

[label 词汇的一行摘要]。见 `docs/agents/triage-labels.md`。

### Domain docs

[布局的一行摘要——"single-context" 或 "multi-context"]。见 `docs/agents/domain.md`。
```

然后使用此技能文件夹中的种子模板作为起点，写入三个 docs 文件：

- [issue-tracker-github.md](./issue-tracker-github.md)——GitHub 问题跟踪器（issue tracker）
- [issue-tracker-gitlab.md](./issue-tracker-gitlab.md)——GitLab 问题跟踪器（issue tracker）
- [issue-tracker-local.md](./issue-tracker-local.md)——本地 Markdown 问题跟踪器（issue tracker）
- [triage-labels.md](./triage-labels.md)——label 映射
- [domain.md](./domain.md)——领域文档消费规则 + 布局

对于“其他”问题跟踪器（issue tracker），根据用户描述从零编写 `docs/agents/issue-tracker.md`。

### 5. 完成

告诉用户设置已完成，以及哪些工程技能现在会读取这些文件。说明他们之后可以直接编辑 `docs/agents/*.md`——只有当他们想切换问题跟踪器（issue tracker） 或从头开始时，才需要重新运行此技能。
