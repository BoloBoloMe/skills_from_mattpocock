# CONTEXT.md 格式

## 结构

```md
# {Context 名称}

{一两句话描述这个 context 是什么以及为什么存在.}

## 语言

**Order**:
{一两句话描述该术语}
_避免_: Purchase, transaction

**Invoice**:
在交付后发送给客户的付款请求.
_避免_: Bill, payment request

**Customer**:
下单的人或组织.
_避免_: Client, buyer, account
```

## 规则

- **要有观点.** 当多个词指代同一概念时, 挑最好的那个, 并将其他列在 `_Avoid_` 下.
- **保持定义紧凑.** 最多一两句话. 定义它 IS 什么, 不是它做什么.
- **仅包含特定于本项目 context 的术语.** 通用编程概念 (超时, 错误类型, 工具模式) 即使本项目大量使用它们也不属于这里. 在添加术语之前问: 这是本 context 独有的概念, 还是通用编程概念? 只有前者属于此处.
- **在自然集群出现时将术语分组在子标题下.** 如果所有术语属于一个单一连贯领域, 平铺列表也可以.

## 单一 vs 多 context 仓库

**单一 context (大多数仓库):** 仓库根目录的一个 `CONTEXT.md`.

**多个 context:** 仓库根目录的 `CONTEXT-MAP.md` 列出各 context, 它们在哪里, 以及它们如何相互关联:

```md
# Context Map

## Contexts

- [Ordering](./src/ordering/CONTEXT.md) - 接收并跟踪客户订单
- [Billing](./src/billing/CONTEXT.md) - 生成发票并处理付款
- [Fulfillment](./src/fulfillment/CONTEXT.md) - 管理仓库拣货和发货

## Relationships

- **Ordering -> Fulfillment**: Ordering 发出 `OrderPlaced` 事件; Fulfillment 消费它们以开始拣货
- **Fulfillment -> Billing**: Fulfillment 发出 `ShipmentDispatched` 事件; Billing 消费它们以生成发票
- **Ordering <-> Billing**: 共享类型 `CustomerId` 和 `Money`
```

技能推断适用哪种结构:

- 如果 `CONTEXT-MAP.md` 存在, 读取它以找到 context
- 如果只有根目录 `CONTEXT.md` 存在, 单一 context
- 如果两者都不存在, 在第一个术语被确定时惰性创建根目录 `CONTEXT.md`

当多个 context 存在时, 推断当前主题属于哪个 context. 如果不确定, 询问.
