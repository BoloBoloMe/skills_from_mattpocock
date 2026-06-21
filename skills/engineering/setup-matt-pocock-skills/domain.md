# 领域文档

Engineering 技能探索代码库时应如何消费本仓库的领域文档.

## 探索之前, 阅读这些

- 仓库根的 **`CONTEXT.md`**, 或
- 仓库根的 **`CONTEXT-MAP.md`** 如果它存在 - 它指向每个 context 的一个 `CONTEXT.md`. 读取与主题相关的每一个.
- **`docs/adr/`** - 读取触及你即将工作区域的 ADR. 在多 context 仓库中, 也检查 `src/<context>/docs/adr/` 获取 context 级别的决策.

如果这些文件中有任何一个不存在, **默默继续.** 不要标记它们的缺失; 不要建议提前创建它们. `/domain-modeling` 技能 (通过 `/grill-with-docs` 和 `/improve-codebase-architecture` 访问) 在术语或决策真正被确定时惰性创建它们.

## 文件结构

单一 context 仓库 (大多数仓库):

```
/
|---- CONTEXT.md
|---- docs/adr/
|   |---- 0001-event-sourced-orders.md
|   `---- 0002-postgres-for-write-model.md
`---- src/
```

多 context 仓库 (根目录存在 `CONTEXT-MAP.md`):

```
/
|---- CONTEXT-MAP.md
|---- docs/adr/                          <- 系统级决策
`---- src/
    |---- ordering/
    |   |---- CONTEXT.md
    |   `---- docs/adr/                  <- context 级别决策
    `---- billing/
        |---- CONTEXT.md
        `---- docs/adr/
```

## 使用术语表的词汇

当你的输出命名一个领域概念 (在 issue 标题, 重构提案, 假设, 测试名称中), 使用 `CONTEXT.md` 中定义的术语. 不要漂移到术语表明确避免的同义词.

如果你需要的概念不在术语表中, 这是一个信号 - 要么你在发明项目不用的语言 (重新考虑), 要么有一个真实的空白 (标记它给 `/domain-modeling`).

## 标记 ADR 冲突

如果你的输出与现有 ADR 矛盾, 明确提出而不是静默覆盖:

> _与 ADR-0007 (event-sourced orders) 矛盾 - 但值得重新打开因为..._
