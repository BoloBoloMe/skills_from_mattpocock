# Issue tracker 集成仅限主流工具

`setup-matt-pocock-skills` 只为**主流** issue tracker 提供一等支持。为小众、新兴或单一厂商实验性 tracker 添加支持的请求不在范围内。

## 为什么不在范围内

每个 issue-tracker 后端都会把一种 CLI 形态硬编码进 skills（命令、标志、输出解析）。每新增一个后端都是永久维护面——它必须随着该工具 CLI 的演进持续可用，并且必须持续针对 `/to-prd`、`/to-issues`、`/triage` 及相关技能进行测试。只有当相当一部分用户确实在使用某个 tracker 时，这种成本才值得承担。

“主流”是一种判断，而不是数字门槛：

- GitHub、GitLab 和 Backlog.md 属于我们会认为主流的工具——知名度高、使用广泛，并且早已越过实验阶段。
- 一个全新的、面向 agent 的工具，即使设计再有趣，只要只有几百个 GitHub 星标（star），也不算主流。

星标数（Star 数）、存在时间和下载量在判断时都是有用信号，但没有任何一个是规则。规则是：典型工程师会认识这个工具，并且有可能为自己的团队选择它吗？

面向非主流 tracker 的逃生口已经存在：

- `local markdown` 用于轻量级仓库内跟踪。
- `other/custom` 用于想要自行接线的用户。

两者都不要求核心 skills 了解具体工具。

## 过往请求

- #99 — “添加 dex 作为 issue tracker 后端”（提出请求时，dex 大约存在 3 个月，约有 300 个星标（star））
