---
name: ask-matt
description: 询问哪个技能或流程适合当前情况. 本仓库用户调用技能的路由器.
disable-model-invocation: true
---

# 询问 Matt

你不可能记住每一个技能, 所以问一下.

一个 **flow** 是一条穿越技能的路径. 大多数路径沿一条 **main flow** 运行, 两个 **on-ramps** 汇入其中. 其他技能独立运行.

## 主流程: 想法 -> 交付

大多数工作走的路线. 你有一个想法并希望将其落地.

1. **`/grill-with-docs`** - 通过访谈锐化想法. 当你 **已有代码库** 时从这里开始: 它是有状态的, 将学到的东西保存在 `CONTEXT.md` 和 ADR 中. (没有代码库? 用 `/grill-me` - 见 Standalone.)
2. **分支 - 你能在对话中解决所有问题吗?** 如果一个问题需要可运行的答案 (状态, 业务逻辑, 你需要亲眼看到的 UI), 通过原型绕行, 由 **`/handoff`** 在两个方向桥接 (见 Crossing sessions):
 - **`/handoff`** 出去, 然后基于该文件打开一个新会话,
 - **`/prototype`** 用一次性代码回答该问题,
 - **`/handoff`** 回传你学到的内容, 并在原始想法线程中引用它.
3. **分支 - 这是多会话构建吗?**
 - **是** -> **`/to-prd`** (将线程转为 PRD) -> **`/to-issues`** (将 PRD 拆为可独立抓取的 issue). 因为 issue 是独立的, **在每个 issue 之间清除上下文**: 每个 issue 开始新会话并启动 **`/implement`**, 传入 PRD 和要处理的单个 issue.
 - **否** -> **`/implement`** 直接在这里, 在同一个上下文窗口中.

### 上下文卫生

将步骤 1-3 保持在 **一个不间断的上下文窗口** 中 - 不要在 `/to-issues` 之前压缩或清除 - 这样 grilling, PRD 和 issue 都建立在相同的思考基础上. 每个 `/implement` 然后从 issue 开始全新工作.

这里的上限是 **[smart zone](https://www.aihero.dev/ai-coding-dictionary/smart-zone)**: 模型仍能清晰推理的窗口范围 (~120k tokens, 在最先进的模型上). 如果会话在 `/to-issues` 之前接近该上限, 不要在衰退状态下继续 - `/handoff` 并在新线程中继续.

## 入口路径

一个起始情况会产生工作, 然后汇入 main flow.

- **Bug 和请求堆积** -> **`/triage`**. 它将 issue 推进 triage 角色并生成 agent-ready 的 issue, 后续由 **`/implement`** 接手.

  Triage 只适用于 **你没有创建** 的 issue - bug 报告, 收到的功能请求, 任何原始到达的东西. `/to-issues` 产出的 issue 已经是 agent-ready, 所以 **不要对它们做 triage**.

## 代码库健康

不是功能工作 - 是维护.

- **`/improve-codebase-architecture`** - 在你有空闲时间时运行, 保持代码库对 agent 的可操作性. 它展示 deepening 机会; 选择一个 _生成一个想法_, 你可以将其带入 main flow 的 `/grill-with-docs`.

## 跨会话

- **`/handoff`** - 当线程满了或你需要分支 (例如进入 `/prototype` 会话), 这将对话压缩为一个 markdown 文件. 你不在原地继续 - 你 **打开一个新会话并引用该文件** 来传递上下文. 它是上下文窗口之间的桥梁, 方向不限. 当你想要 **新会话** 但需要 **保留当前对话** 时使用.
- **`/compact`** (内置) - 保持在 **同一对话** 中, 让前面的轮次被摘要. 在 **阶段之间的有意断点** 使用, 当你不介意丢失逐字历史时. 不要在阶段中间压缩 - agent 可能迷失方向. `/handoff` 分叉; `/compact` 继续.

## 独立流程

完全脱离 main flow.

- **`/grill-me`** - 和 `/grill-with-docs` 一样的不懈访谈, 但适用于你 **没有代码库** 的情况. 无状态: 它不在本地保存任何内容, 不构建 `CONTEXT.md`. 用它来锐化任何不在仓库中的计划或设计.
- **`/teach`** - 在多个会话中学习一个概念, 使用当前目录作为有状态的教学工作区.
- **`/writing-great-skills`** - 写好和编辑好技能的参考: 让技能可预测的词汇和原则.

## 前置条件

**`/setup-matt-pocock-skills`** - 在你的第一个 engineering 流程之前运行, 配置其他技能依赖的 issue tracker, triage label 和文档布局. 自定义 issue tracker 也可用.
