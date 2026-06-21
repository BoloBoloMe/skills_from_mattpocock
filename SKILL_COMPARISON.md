# 仓库 skills 与本机正式 skills 对比

对比范围:

- 仓库 active skills: `.claude-plugin/plugin.json` 中声明的 skills.
- 仓库 misc skills: `README.md` Reference 中列出的 misc skills.
- 未纳入: `personal/`, `in-progress/`, `deprecated/`.
- `.github/workflows/release.yml` 是 changesets release workflow, 不是 skill.

| 仓库 skill | 路径 | 判定 | `~/.pi` 中最接近的正式 skill | 说明 |
|---|---|---:|---|---|
| `prototype` | `skills/engineering/prototype/` | 高度重叠 | `prototype` | 同名同核心能力. 仓库版和正式版都分 logic TUI 与 UI variants. 正式版增加了中文落盘, 跨系统脚本等本地约束. |
| `diagnosing-bugs` | `skills/engineering/diagnosing-bugs/` | 高度重叠 | `diagnose` | 都是 reproduce -> minimise -> hypothesise -> instrument -> fix -> regression-test 的诊断循环. |
| `grill-with-docs` | `skills/engineering/grill-with-docs/` | 高度重叠 | `grill-with-docs` | 同名同功能, 围绕计划/领域语言/ADR 拷问式打磨. |
| `triage` | `skills/engineering/triage/` | 高度重叠 | `triage` | 都管理 issue triage 状态机, 标签, brief. |
| `improve-codebase-architecture` | `skills/engineering/improve-codebase-architecture/` | 高度重叠 | `improve-codebase-architecture` | 同名同类, 都做架构扫描, 深化模块, 重构候选. |
| `tdd` | `skills/engineering/tdd/` | 高度重叠 | `tdd` | 同名同功能, red-green-refactor. |
| `to-issues` | `skills/engineering/to-issues/` | 高度重叠 | `to-issues` | 都把计划/PRD 拆成垂直切片 issues. |
| `to-prd` | `skills/engineering/to-prd/` | 高度重叠 | `to-prd` | 都把上下文沉淀为 PRD 并发布到议题系统. |
| `grill-me` | `skills/productivity/grill-me/` | 高度重叠 | `grill-me` | 同名同功能, 纯对话式追问计划/设计. |
| `handoff` | `skills/productivity/handoff/` | 高度重叠 | `handoff` | 同名同功能, 压缩上下文成交接文档. |
| `writing-great-skills` | `skills/productivity/writing-great-skills/` | 高度重叠 | `write-a-skill` | 都服务于编写/改进 skill. 仓库版更像原则参考, 正式版更偏创建流程. |
| `ask-matt` | `skills/engineering/ask-matt/` | 部分重叠 | `orchestrate` | 都是路由器. 仓库版面向 MattPocock skills, 正式版面向本地 workflow skills 和子代理分派. |
| `setup-matt-pocock-skills` | `skills/engineering/setup-matt-pocock-skills/` | 部分重叠 | `setup-workspace` | 都做项目前置配置. 仓库版专门配置 MattPocock skills, 正式版更通用. |
| `domain-modeling` | `skills/engineering/domain-modeling/` | 部分重叠 | `grill-with-docs` | 正式版把领域语言/ADR 压力测试吸收到 `grill-with-docs` 中, 不是独立 skill. |
| `codebase-design` | `skills/engineering/codebase-design/` | 部分重叠 | `improve-codebase-architecture` | 仓库版偏设计词汇/原则, 正式版偏架构评审和候选输出. |
| `grilling` | `skills/productivity/grilling/` | 部分重叠 | `grill-me`, `grill-with-docs` | 仓库版是可复用 model-invoked grilling loop, 正式版主要通过两个用户入口承载. |
| `teach` | `skills/productivity/teach/` | 全新 | 无明显等价 | 正式 skills 中没有状态化教学工作区类 skill. |
| `git-guardrails-claude-code` | `skills/misc/git-guardrails-claude-code/` | 全新 | 无明显等价 | 正式 skills 中没有 Claude Code git hook 防护配置类 skill. |
| `migrate-to-shoehorn` | `skills/misc/migrate-to-shoehorn/` | 全新 | 无明显等价 | 正式 skills 中没有 `@total-typescript/shoehorn` 迁移专项. |
| `scaffold-exercises` | `skills/misc/scaffold-exercises/` | 全新 | 无明显等价 | 正式 skills 中没有课程练习目录脚手架专项. |
| `setup-pre-commit` | `skills/misc/setup-pre-commit/` | 全新 | 无明显等价 | 正式 skills 中没有 Husky/lint-staged/pre-commit 配置专项. |

## 只看指定路径

| 路径 | 结论 |
|---|---|
| `.github/workflows/` | 没有 skill, 只有 release workflow. |
| `skills/engineering/prototype/` | 不是全新, 与 `~/.pi/agent/skills/prototype/` 高度重叠. |
