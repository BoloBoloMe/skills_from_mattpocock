---
name: handoff
description: 将当前对话压缩成交接文档, 供另一个 agent 接手.
argument-hint: "下一个会话将用于什么?"
disable-model-invocation: true
---

写一个总结当前对话的 handoff 文档, 让一个新 agent 可以继续工作. 保存到用户 OS 的临时目录 - 不是当前工作区.

在文档中包含 "suggested skills" 章节, 建议该 agent 应调用的技能.

不要复制已在其他工件 (PRD, 计划, ADR, issue, commit, diff) 中捕获的内容. 用路径或 URL 引用它们.

隐去任何敏感信息, 如 API key, 密码, 或个人身份信息.

如果用户传递了参数, 将其视为下一个会话将聚焦什么的描述, 并相应地定制文档.
