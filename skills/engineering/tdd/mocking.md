# 何时 Mock

仅在 **系统边界** 处 mock:

- 外部 API (支付, 邮件等)
- 数据库 (有时 - 偏好测试数据库)
- 时间/随机性
- 文件系统 (有时)

不要 mock:

- 你自己的类/模块
- 内部合作者
- 你控制的任何东西

## 为可 Mock 性而设计

在系统边界处, 设计容易 mock 的 interface:

**1. 使用依赖注入**

传入外部依赖而不是内部创建它们:

```typescript
// 易 mock
function processPayment(order, paymentClient) {
  return paymentClient.charge(order.total);
}

// 难 mock
function processPayment(order) {
  const client = new StripeClient(process.env.STRIPE_KEY);
  return client.charge(order.total);
}
```

**2. 偏好 SDK 风格 interface 而不是通用 fetcher**

为每个外部操作创建特定函数, 而不是一个带条件逻辑的通用函数:

```typescript
// GOOD: 每个函数独立可 mock
const api = {
  getUser: (id) => fetch(`/users/${id}`),
  getOrders: (userId) => fetch(`/users/${userId}/orders`),
  createOrder: (data) => fetch('/orders', { method: 'POST', body: data }),
};

// BAD: Mocking 需要在 mock 内部有条件逻辑
const api = {
  fetch: (endpoint, options) => fetch(endpoint, options),
};
```

SDK 方法意味着:
- 每个 mock 返回一种特定形状
- 测试设置中无条件逻辑
- 更容易看到哪个 endpoint 一个测试在行使
- 每个 endpoint 的类型安全
