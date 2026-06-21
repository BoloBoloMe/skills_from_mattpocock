---
name: to-issues
description: 使用 tracer-bullet 垂直切片, 将计划, spec 或 PRD 拆成项目 issue tracker 上可独立领取的 issues.
disable-model-invocation: true
---

# 转为 Issues

使用 vertical slice (tracer bullet) 将计划拆为可独立抓取的 issue.

Issue tracker 和 triage label 词汇应该已提供给你 - 如果没有, 运行 `/setup-matt-pocock-skills`.

## 流程

### 1. 收集上下文

从对话上下文中已有的任何内容工作. 如果用户传递了一个 issue 引用 (issue 编号, URL, 或路径) 作为参数, 从 issue tracker 获取它并读取其完整 body 和评论.

### 2. 探索代码库 (可选)

如果你还没有探索代码库, 做一下以了解代码的当前状态. Issue 标题和描述应使用项目的领域术语表词汇, 并尊重你触及区域的 ADR.

寻找 prefactor 代码的机会以使实现更容易. "先让变更变得容易, 然后做那个容易的变更."

### 3. 草拟 vertical slice

将计划拆为 **tracer bullet** issue. 每个 issue 是一个切穿 ALL 集成层端到端的 thin vertical slice, 不是一层的水平切片.

<vertical-slice-rules>

- 每个 slice 交付一条狭窄但 COMPLETE 的穿过每一层 (schema, API, UI, tests) 的路径
- 一个完成的 slice 可独立 demo 或验证
- 任何 prefactoring 应先完成

</vertical-slice-rules>

### 4. 向用户提问

将拟议的拆分以编号列表展示. 对于每个 slice, 展示:

- **Title**: 短描述性名称
- **Blocked by**: 哪些其他 slice (如果有) 必须先完成
- **覆盖的 user stories**: 这个 slice 涵盖哪些 user stories (如果源材料有它们)

问用户:

- 粒度感觉合适吗? (太粗 / 太细)
- 依赖关系正确吗?
- 有任何 slice 应合并还是进一步拆分?

迭代直到用户批准拆分.

### 5. 将 issue 发布到 issue tracker

对于每个批准的 slice, 向 issue tracker 发布一个新 issue. 使用下方 issue body 模板. 这些 issue 被视为 ready for AFK agent, 所以用正确的 triage label 发布它们, 除非另有指示.

按依赖顺序发布 issue (先发布 blocker), 这样你可以在 "Blocked by" 字段中引用真实的 issue 标识符.

<issue-template>
## 父级

对 issue tracker 上 parent issue 的引用 (如果来源是已有 issue, 否则省略此章节).

## 要构建什么

此 vertical slice 的简洁描述. 描述端到端行为, 不是逐层实现.

避免具体文件路径或代码片段 - 它们很快过期. 例外: 如果原型产出了一个比散文更能精确编码决策的片段 (状态机, reducer, schema, 类型形状), 在此处内联它并简要注明它来自原型. 剪裁到决策密集的部分 - 不是可运行的 demo, 只是重要的片段.

## 验收标准

- [ ] 标准 1
- [ ] 标准 2
- [ ] 标准 3

## 被什么阻塞

- 对 blocker ticket 的引用 (如果有)

或 "None - can start immediately" 如果没有 blocker.

</issue-template>

不要关闭或修改任何 parent issue.
