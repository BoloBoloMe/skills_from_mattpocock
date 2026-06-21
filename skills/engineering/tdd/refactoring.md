# 重构候选

TDD 循环后, 寻找:

- **重复** -> 提取函数/类
- **长方法** -> 拆为私有辅助 (保持测试在公共 interface 上)
- **Shallow module** -> 合并或 deepen
- **Feature envy** -> 将逻辑移到数据所在之处
- **Primitive obsession** -> 引入值对象
- **现有代码** 新代码揭示为有问题的
