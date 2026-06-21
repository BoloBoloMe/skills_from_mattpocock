# 好的测试和坏的测试

## 好的测试

**集成式**: 通过真实 interface 测试, 不是内部部分的 mock.

```typescript
// GOOD: 测试可观察行为
test("user can checkout with valid cart", async () => {
  const cart = createCart();
  cart.add(product);
  const result = await checkout(cart, paymentMethod);
  expect(result.status).toBe("confirmed");
});
```

特征:

- 测试用户/调用者关心的行为
- 仅使用公共 API
- 在内部重构中存活
- 描述 WHAT, 不是 HOW
- 每个测试一个逻辑断言

## 坏的测试

**Implementation-detail 测试**: 与内部结构耦合.

```typescript
// BAD: 测试 implementation 细节
test("checkout calls paymentService.process", async () => {
  const mockPayment = jest.mock(paymentService);
  await checkout(cart, payment);
  expect(mockPayment.process).toHaveBeenCalledWith(cart.total);
});
```

红旗:

- Mock 内部合作者
- 测试私有方法
- 断言调用次数/顺序
- 行为不变时重构导致测试断裂
- 测试名称描述 HOW 不是 WHAT
- 通过外部手段验证而不是 interface

```typescript
// BAD: 绕过 interface 来验证
test("createUser saves to database", async () => {
  await createUser({ name: "Alice" });
  const row = await db.query("SELECT * FROM users WHERE name = ?", ["Alice"]);
  expect(row).toBeDefined();
});

// GOOD: 通过 interface 验证
test("createUser makes user retrievable", async () => {
  const user = await createUser({ name: "Alice" });
  const retrieved = await getUser(user.id);
  expect(retrieved.name).toBe("Alice");
});
```
