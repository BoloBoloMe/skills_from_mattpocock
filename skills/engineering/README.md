# 工程

日常代码工作中使用的技能.

## 用户调用

仅在你手动输入时可达 (`disable-model-invocation: true`).

- **[ask-matt](./ask-matt/SKILL.md)** - 询问哪个技能或流程适合你的情况. 本仓库中 user-invoked 技能的路由器.
- **[grill-with-docs](./grill-with-docs/SKILL.md)** - 在 grilling 会话中同时构建项目的领域模型, 锐化术语并内联更新 `CONTEXT.md` 和 ADR.
- **[triage](./triage/SKILL.md)** - 将 issue 推进 triage 角色状态机.
- **[improve-codebase-architecture](./improve-codebase-architecture/SKILL.md)** - 扫描代码库寻找 deepening 机会, 以可视化 HTML 报告呈现, 然后 grilling 你选定的那一个.
- **[setup-matt-pocock-skills](./setup-matt-pocock-skills/SKILL.md)** - 为 engineering 技能配置本仓库 (issue tracker, triage label, 领域文档布局). 每个仓库运行一次.
- **[to-issues](./to-issues/SKILL.md)** - 将任何计划, spec 或 PRD 拆分为可独立抓取的 issue, 使用 vertical slice.
- **[to-prd](./to-prd/SKILL.md)** - 将当前对话转化为 PRD 并发布到 issue tracker.
- **[prototype](./prototype/SKILL.md)** - 构建一次性原型 - 用于状态/逻辑问题的可运行终端应用, 或多个可切换的 UI 变体.

## 模型调用

模型或用户可达 (丰富的触发短语让模型可以主动调用).

- **[diagnosing-bugs](./diagnosing-bugs/SKILL.md)** - 针对 hard bug 和性能回归的严谨诊断循环: 复现 -> 最小化 -> 提假设 -> 插桩 -> 修复 -> 回归测试.
- **[tdd](./tdd/SKILL.md)** - 使用 red-green-refactor 循环的测试驱动开发. 每次一个 vertical slice 来构建功能或修复 bug.
- **[domain-modeling](./domain-modeling/SKILL.md)** - 主动构建并锐化项目的领域模型 - 挑战术语, 用场景做压力测试, 内联更新 `CONTEXT.md` 和 ADR.
- **[codebase-design](./codebase-design/SKILL.md)** - 设计 deep module 的共享纪律与词汇: 小接口, 清洁 seam, 可通过接口测试.
