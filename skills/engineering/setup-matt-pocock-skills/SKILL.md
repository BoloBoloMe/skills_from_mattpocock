---
name: setup-matt-pocock-skills
description: 为本仓库配置 engineering 技能 - 设置 issue tracker, triage label 词汇和领域文档布局. 首次使用其他 engineering 技能前运行一次.
disable-model-invocation: true
---

# 设置 Matt Pocock 的技能

搭设 engineering 技能假设的 per-repo 配置:

- **Issue tracker** - issue 所在的位置 (默认 GitHub; 本地 markdown 也开箱支持)
- **Triage labels** - 五个规范 triage 角色使用的字符串
- **Domain docs** - `CONTEXT.md` 和 ADR 所在的位置, 以及消费它们的规则

这是一个提示驱动的技能, 不是确定性脚本. 探索, 展示你发现的, 与用户确认, 然后写入.

## 流程

### 1. 探索

查看当前仓库以了解其起始状态. 读取任何已有的内容; 不要假设:

- `git remote -v` 和 `.git/config` - 这是一个 GitHub 仓库吗? 哪一个?
- 仓库根的 `AGENTS.md` 和 `CLAUDE.md` - 其中任何一个存在吗? 是否已有 `## Agent skills` 章节?
- 仓库根的 `CONTEXT.md` 和 `CONTEXT-MAP.md`
- `docs/adr/` 和任何 `src/*/docs/adr/` 目录
- `docs/agents/` - 此技能的先前输出是否已存在?
- `.scratch/` - 表明本地 markdown issue tracker 约定已在使用

### 2. 展示发现并询问

总结什么存在什么缺失. 然后 **逐个** 引导用户走过三个决策 - 展示一个章节, 得到用户答案, 然后进入下一个. 不要一次性抛出三个.

假设用户不知道这些术语意味着什么. 每个章节以简短解释开始 (它是什么, 为什么这些技能需要它, 如果他们选择不同会改变什么). 然后展示选择和默认值.

**章节 A - Issue tracker.**

> 解释: "issue tracker" 是本仓库 issue 所在的位置. 像 `to-issues`, `triage`, `to-prd`, 和 `qa` 的技能从中读取和写入 - 它们需要知道是调用 `gh issue create`, 在 `.scratch/` 下写 markdown 文件, 还是遵循你描述的其他工作流. 选择你实际跟踪本仓库工作的地方.

默认姿态: 这些技能为 GitHub 设计. 如果 `git remote` 指向 GitHub, 提议它. 如果 `git remote` 指向 GitLab (`gitlab.com` 或自托管主机), 提议 GitLab. 否则 (或如果用户偏好), 提供:

- **GitHub** - issue 存在于仓库的 GitHub Issues (使用 `gh` CLI)
- **GitLab** - issue 存在于仓库的 GitLab Issues (使用 [`glab`](https://gitlab.com/gitlab-org/cli) CLI)
- **Local markdown** - issue 作为文件存在于本仓库 `.scratch/<feature>/` 下 (适合单人项目或没有远程的仓库)
- **其他** (Jira, Linear 等) - 请用户用一段话描述工作流; 技能将其记录为自由格式文字

仅当 - 且仅当 - 用户选择了 **GitHub** 或 **GitLab** 时, 问一个后续问题:

> 解释: 开源仓库经常收到功能请求作为 pull request, 不只是 issue - 一个 PR 是附带代码的 issue. 如果你启用此选项, `/triage` 将 *外部* PR 拉入同一队列, 并以相同的 label 和状态运行它们 (合作者进行中的 PR 不受影响). 如果 PR 不是你的请求表面, 关掉它.

- **PR 作为请求表面** - yes / no (默认: no). 将答案记录在 `docs/agents/issue-tracker.md` 中. 对于 local-markdown 和其他 tracker, 跳过此问题 - 没有 PR.

**章节 B - Triage label 词汇.**

> 解释: 当 `triage` 技能处理收到的 issue 时, 它通过一个状态机移动 - 需要评估, 等待报告者, ready for AFK agent 拿取, ready for human, 或 won't fix. 为此, 它需要应用 label (或你 issue tracker 中的等效物), 匹配 *你实际配置过的* 字符串. 如果你的仓库已使用不同的 label 名称 (例如 `bug:triage` 代替 `needs-triage`), 在此处映射, 这样技能应用正确的 label 而不是创建重复的.

五个规范角色:

- `needs-triage` - 维护者需要评估
- `needs-info` - 等待报告者
- `ready-for-agent` - 完全明确, AFK-ready (agent 无需人类上下文即可拿取)
- `ready-for-human` - 需要人类实现
- `wontfix` - 不会采取行动

默认: 每个角色的字符串等于其名称. 询问用户是否要覆盖任何. 如果他们的 issue tracker 没有现有 label, 默认即可.

**章节 C - Domain docs.**

> 解释: 一些技能 (`improve-codebase-architecture`, `diagnosing-bugs`, `tdd`) 读取 `CONTEXT.md` 文件来学习项目的领域语言, 和 `docs/adr/` 获取过去的架构决策. 它们需要知道仓库有单一全局 context 还是多个 (例如 monorepo 有独立的前端/后端 context), 以便在正确位置查找.

确认布局:

- **Single-context** - 仓库根的一个 `CONTEXT.md` + `docs/adr/`. 大多数仓库是这样.
- **Multi-context** - 根的 `CONTEXT-MAP.md` 指向 per-context 的 `CONTEXT.md` 文件 (通常是 monorepo).

### 3. 确认并编辑

向用户展示草稿:

- 要添加到 `CLAUDE.md` / `AGENTS.md` 中的 `## Agent skills` 块 (见步骤 4 的选择规则)
- `docs/agents/issue-tracker.md`, `docs/agents/triage-labels.md`, `docs/agents/domain.md` 的内容

让他们在写入前编辑.

### 4. 写入

**选择要编辑的文件:**

- 如果 `CLAUDE.md` 存在, 编辑它.
- 否则如果 `AGENTS.md` 存在, 编辑它.
- 如果两者都不存在, 询问用户要创建哪一个 - 不要替他们选.

当 `CLAUDE.md` 已存在时绝不创建 `AGENTS.md` (反之亦然) - 总是编辑已有的那个.

如果选择的文件中已有 `## Agent skills` 块, 就原地更新其内容, 而不是追加重复. 不要覆盖用户对周围章节的编辑.

该块:

```markdown
## Agent skills

### Issue tracker

[一句话总结 issue 在哪里跟踪, 加上外部 PR 是否是 triage surface]. 见 `docs/agents/issue-tracker.md`.

### 分流 labels

[一句话总结 label 词汇]. 见 `docs/agents/triage-labels.md`.

### Domain docs

[一句话总结布局 - "single-context" 或 "multi-context"]. 见 `docs/agents/domain.md`.
```

然后使用此技能文件夹中的种子模板作为起点写入三个文档文件:

- [issue-tracker-github.md](./issue-tracker-github.md) - GitHub 议题跟踪器
- [issue-tracker-gitlab.md](./issue-tracker-gitlab.md) - GitLab 议题跟踪器
- [issue-tracker-local.md](./issue-tracker-local.md) - 本地 Markdown 议题跟踪器
- [triage-labels.md](./triage-labels.md) - label 映射
- [domain.md](./domain.md) - domain doc 消费规则 + 布局

对于 "其他" issue tracker, 使用用户的描述从头写 `docs/agents/issue-tracker.md`.

### 5. 完成

告诉用户设置已完成以及哪些 engineering 技能现在会读取这些文件. 提及他们可以后续直接编辑 `docs/agents/*.md` - 仅在想要切换 issue tracker 或从头重新开始时才需要重新运行此技能.
