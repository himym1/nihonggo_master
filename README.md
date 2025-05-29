# 日语大师 (Nihongo Master)

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![License](https://img.shields.io/badge/license-MIT-blue.svg?style=for-the-badge)](LICENSE)

一款极致、愉悦、智能的日语学习移动应用，成为每个日语学习者口袋里的私人向导与陪练。

## 🎯 项目愿景

打造一款集智能AI导师、科学记忆系统、沉浸式体验于一体的综合性日语学习平台：

- **体验至上**: 提供精美、流畅、充满微交互的UI/UX，让学习过程不再枯燥
- **智能驱动**: 深度集成AI（以Google Gemini为核心），提供智能问答、场景对话、作文批改等个性化辅导
- **效率学习**: 引入科学的学习方法，如间隔重复系统(SRS)，帮助用户高效记忆
- **跨平台覆盖**: 基于Flutter实现一套代码库，无缝运行于iOS、Android和Web

## ✨ 核心功能

### 🔤 智能词汇与汉字学习系统
- **闪卡学习**: 交互式卡片，支持3D翻转动画，包含读音、释义、例句
- **间隔重复系统(SRS)**: 根据记忆曲线智能安排复习计划
- **分级学习**: 覆盖JLPT N5-N1等级的词汇和常用汉字
- **多元测验**: 选择题、填空题、听写等多种题型

### 🤖 AI语言导师 - "樱花老师"
- **自由问答**: 解答语法、词汇、文化背景的任何问题
- **场景对话**: 模拟真实场景（购物、问路、点餐）进行人机对话练习
- **语音交互**: 支持语音输入(STT)和标准语音朗读(TTS)
- **作文批改**: AI进行语法、拼写和表达的优化建议

### 📚 系统性语法课程
- **结构化内容**: 按等级和功能分类的语法课程
- **详细讲解**: 规则解析、情景辨析、易错点提醒和多样化例句

### 👤 用户中心与游戏化
- **跨设备同步**: 学习数据云端同步
- **学习统计**: 数据可视化图表展示学习进度
- **游戏化元素**: 学习打卡、连续登录、成就勋章

## 🏗️ 技术架构

### 核心技术栈
- **框架**: Flutter 3.7+ 
- **语言**: Dart
- **状态管理**: Riverpod
- **路由管理**: GoRouter  
- **AI集成**: Google Generative AI (Gemini)
- **HTTP客户端**: HTTP package

### 项目架构
```
lib/
├── main.dart                 # 应用入口
├── app/                      # 应用配置
│   ├── app.dart             # App主配置
│   └── router/              # 路由配置
├── features/                 # 功能模块
│   ├── auth/                # 认证模块
│   ├── home/                # 主页模块  
│   ├── vocabulary/          # 词汇学习模块
│   ├── kanji/               # 汉字学习模块
│   ├── ai_tutor/            # AI导师模块
│   ├── grammar/             # 语法课程模块
│   └── user_profile/        # 用户模块
├── core/                     # 核心共享模块
│   ├── api/                 # API调用封装
│   ├── data/                # 数据模型与仓库
│   ├── ui/                  # 共享UI组件
│   └── utils/               # 工具类
└── generated/               # 自动生成文件
```

### 设计模式
- **分层架构**: UI层 → 状态管理层 → 业务逻辑层 → 数据源层
- **功能模块化**: 每个功能独立组织，包含presentation、data、domain层
- **依赖注入**: 使用Riverpod进行依赖管理

## 🚀 快速开始

### 环境要求
- Flutter SDK >= 3.7.0
- Dart SDK >= 3.0.0
- Android Studio / VS Code
- iOS开发需要Xcode (仅macOS)

### 安装与运行

1. **克隆项目**
   ```bash
   git clone https://github.com/himym1/nihonggo_master.git
   cd nihongo_master
   ```

2. **安装依赖**
   ```bash
   flutter pub get
   ```

3. **配置API密钥**
   - 获取Google Gemini API密钥
   - 在项目中配置API密钥（具体配置方式待完善）

4. **运行应用**
   ```bash
   # 运行在调试模式
   flutter run
   
   # 构建发布版本
   flutter build apk  # Android
   flutter build ios  # iOS
   flutter build web  # Web
   ```

## 📱 支持平台

- ✅ **Android** (API 21+)
- ✅ **iOS** (iOS 12.0+)  
- ✅ **Web** (现代浏览器)
- 🔄 **macOS** (计划中)
- 🔄 **Windows** (计划中)

## 🎨 UI/UX设计原则

- **简洁直观**: 界面元素清晰易懂，用户无需思考即可上手
- **流畅愉悦**: 动画和转场效果平滑、有意义
- **沉浸专注**: 学习界面排除干扰元素，专注内容
- **品牌一致**: 跨平台统一的视觉风格和交互体验

## 📝 开发规范

### 代码风格
- 遵循[Effective Dart](https://dart.dev/guides/language/effective-dart)指南
- 启用`flutter_lints`进行静态分析
- 文件命名使用`snake_case.dart`
- 类名使用`UpperCamelCase`

### Git工作流
- 使用Feature Branch Workflow
- 提交信息使用约定式提交格式
- 代码审查必须通过才能合并

### 测试策略
- 单元测试: 核心业务逻辑和工具类
- Widget测试: 关键页面流程
- 集成测试: 端到端用户场景

## 📊 项目状态

当前版本: `1.0.0-alpha`

### 已完成功能
- ✅ 项目架构搭建
- ✅ 基础UI框架
- ✅ 词汇学习模块（闪卡、列表、分类）
- ✅ AI导师聊天界面
- ✅ 主页导航
- ✅ 用户认证模块
- ✅ 汉字学习模块
- ✅ 语法课程模块

### 开发中功能
- 🔄 SRS间隔重复算法
- 🔄 语音识别与合成
- 🔄 数据持久化
- 🔄 用户学习统计
- 🔄 API后端集成

### 计划功能
- 📋 离线模式
- 📋 社区功能
- 📋 更多测验类型
- 📋 学习计划制定

## 🤝 贡献指南

欢迎任何形式的贡献！请阅读我们的贡献指南：

1. Fork本项目
2. 创建feature分支 (`git checkout -b feature/AmazingFeature`)
3. 提交变更 (`git commit -m 'Add some AmazingFeature'`)
4. Push到分支 (`git push origin feature/AmazingFeature`)
5. 创建Pull Request

## 📄 许可证

本项目采用MIT许可证 - 查看[LICENSE](LICENSE)文件了解详情。

## 📞 联系我们

- 项目链接: [https://github.com/himym1/nihonggo_master](https://github.com/himym1/nihonggo_master)
- 问题反馈: [Issues](https://github.com/himym1/nihonggo_master/issues)

## 🙏 致谢

- [Flutter](https://flutter.dev) - 跨平台UI框架
- [Google Generative AI](https://ai.google.dev) - AI能力支持
- [Riverpod](https://riverpod.dev) - 状态管理
- [GoRouter](https://pub.dev/packages/go_router) - 路由管理

---

**让我们一起让日语学习变得更加智能和有趣！** 🌸
