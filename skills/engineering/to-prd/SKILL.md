---
name: to-prd
description: 将当前对话转成 PRD 并发布到项目 issue tracker - 不做访谈, 只综合已讨论内容.
disable-model-invocation: true
---

此技能将当前对话上下文和代码库理解产出为 PRD. 不要访谈用户 - 只综合你已经知道的内容.

Issue tracker 和 triage label 词汇应该已提供给你 - 如果没有, 运行 `/setup-matt-pocock-skills`.

## 流程

1. 探索仓库以了解代码库的当前状态, 如果你还没有这么做. 在整个 PRD 中使用项目的领域术语表词汇, 并尊重你触及区域的 ADR.

2. 草拟你将用来测试功能的 seam. 已有 seam 应优先于新的. 使用尽可能高的 seam. 如果需要新 seam, 在你能达到的最高点提议它们. 代码库中的 seam 越少越好 - 理想数量是一.

与用户确认这些 seam 符合他们的期望.

3. 使用下方模板写 PRD, 然后发布到项目 issue tracker. 应用 `ready-for-agent` triage label - 不需要额外 triage.

<prd-template>

## 问题陈述

用户面临的问题, 从用户视角.

## 解决方案

问题的解决方案, 从用户视角.

## 用户故事

一份 LONG 的, 编号列出的 user stories. 每个 user story 应使用以下格式:

1. 作为 <actor>, 我想要 <feature>, 以便 <benefit>

<user-story-example>
1. 作为移动银行客户, 我想看到自己账户的余额, 以便更明智地决定如何消费
</user-story-example>

此 user stories 列表应极为详尽, 涵盖功能的所有方面.

## 实现决策

做出的实现决策列表. 这可以包括:

- 将构建/修改的模块
- 那些模块将修改的 interface
- 来自开发者的技术澄清
- 架构决策
- Schema 变化
- API 契约
- 特定交互

不要包含具体文件路径或代码片段. 它们可能很快过时.

例外: 如果原型产出了一个比散文更能精确编码决策的片段 (状态机, reducer, schema, 类型形状), 在相关决策中内联它并简要注明它来自原型. 剪裁到决策密集的部分 - 不是可运行的 demo, 只是重要的片段.

## 测试决策

做出的测试决策列表. 包括:

- 描述什么构成一个好的测试 (只测试外部行为, 不测试 implementation 细节)
- 哪些模块将被测试
- 测试的先例 (即代码库中类似类型的测试)

## 超出范围

此 PRD 范围之外的东西的描述.

## 进一步备注

关于功能的任何进一步备注.

</prd-template>
