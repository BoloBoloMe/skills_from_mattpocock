---
name: resolving-merge-conflicts
description: "当你需要解决正在进行的 git merge/rebase 冲突时使用."
---

1. **查看当前状态** 的 merge/rebase. 检查 git 历史和冲突文件.

2. **找到每个冲突的主要来源.** 深入理解为什么每个变更被做出, 以及原始意图是什么. 阅读提交消息, 检查 PR, 检查原始 issue/ticket.

3. **解决每个冲突块.** 在可能的地方保留双方意图. 当不兼容时, 选择匹配 merge 目标的那一方并注明 trade-off. **绝不** 发明新行为. 总是解决; 绝不 `--abort`.

4. 发现项目的 **自动化检查** 并运行它们 - 通常 typecheck, 然后 tests, 然后 format. 修复 merge 破坏的任何东西.

5. **完成 merge/rebase.** 暂存一切并提交. 如果是 rebase, 继续 rebase 过程直到所有提交被 rebased.
