# `setup-matt-pocock-skills` 的验证/检查模式

本项目不会为 `setup-matt-pocock-skills` 添加专门的验证/检查模式（或单独的验证 skill）。

## 为什么不在范围内

为检查 `docs/agents/*.md` 产物是否仍匹配种子模板 schema 而添加第二个 skill——或 `--verify` 标志——会重复现有 setup skill 已经能在对话中处理的工作。

预期工作流是：**运行 `/setup-matt-pocock-skills`，并告诉它验证你当前的设置。** 这个 skill 由提示词驱动，因此维护者可以把它限定为一次验证流程（“不要重写任何内容，只检查我现有文件是否符合当前种子模板，并报告漂移”），而不需要单独的代码路径。添加标志或同级 skill 会拆分一个已经可以通过自然语言入口表达的功能面。

将配置管理保持在单个 skill 中，也避免了种子模板演进时两个 skills 彼此漂移的维护成本。

## 过往请求

- #106 — 功能请求：setup-matt-pocock-skills 的验证/检查模式
