# 仅为硬依赖显式提示 `/setup-matt-pocock-skills`

工程技能依赖由 `/setup-matt-pocock-skills` 播种的每仓库配置（问题跟踪器 issue tracker、分流标签 triage label 词汇表、领域文档布局）。有些技能没有这些配置就无法有意义地工作——它们必须发布到特定问题跟踪器（issue tracker），或应用特定标签字符串。另一些只用这些配置来让输出更精准（词汇、ADR 感知），即使没有配置也能优雅降级。

我们把它们拆分为**硬依赖**和**软依赖**技能：

- **硬依赖**（`to-issues`、`to-prd`、`triage`）——包含明确的一行提示：_“……应该已经提供给你——如果没有，请运行 `/setup-matt-pocock-skills`。”_ 没有这份映射，输出就是错误的，而不只是模糊。
- **软依赖**（`diagnose`、`tdd`、`improve-codebase-architecture`、`zoom-out`）——只用较模糊的文字引用“项目的领域词汇表”和“你触及区域中的 ADR”。如果这些文档不存在，skill 仍然可用；只是输出没那么锐利。

这种拆分让软依赖技能保持低 token 消耗，并避免把 setup 提示（pointer）货物崇拜式地塞进并不承重的位置。
