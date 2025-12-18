

# 📝 StudentMemo - 极简校园备忘录

> 基于 OpenHarmony (ArkTS) 开发的大学生日常事务管理工具。

## 📖 项目介绍

**StudentMemo** 是一款专为高校学生设计的轻量级备忘录应用。针对大学生的日常学习场景（如作业截止、考试复习、社团任务），提供了极简的「待办事项」与「随手笔记」功能。

本项目采用 **DevEco Studio** 开发，基于 **ArkTS** 声明式 UI 框架，不依赖任何第三方重型数据库，利用系统原生 `Preferences` 实现轻量级数据持久化，确保应用启动快、体积小、无广告。

## ✨ 核心功能

### 1. ✅ 待办清单 (Todo List)

* **快速记录**：支持输入课程作业、还书提醒、小组会议等事项。
* **状态管理**：通过原生 `Checkbox` 组件一键标记完成/未完成。
* **视觉反馈**：完成项自动变灰并显示（样式区分），任务状态一目了然。
* **数据持久化**：重启 APP 后，任务列表与勾选状态不丢失。

### 2. 📒 随手笔记 (Quick Notes)

* **即时记录**：支持多行文本输入，适合记录课堂灵感或复习重点。
* **时间戳**：自动生成笔记创建/修改时间，按时间倒序排列（最新的在最前）。
* **极简交互**：支持新建、编辑、保存及删除操作。

## 🛠️ 技术栈

* **开发工具**: DevEco Studio (3.1/4.0+)
* **开发语言**: ArkTS (TypeScript 扩展)
* **SDK 版本**: API 9 / API 10 (Stage 模型)
* **核心组件**:
* `Tabs` / `TabContent`: 底部双页签导航
* `List` / `ListItem`: 高效列表渲染
* `@State` / `@Link`: 页面状态管理
* `Preferences`: 轻量级本地数据存储 (JSON 序列化)



## 📂 目录结构

```text
entry/src/main/ets
├── common
│   └── StorageUtils.ts    // [工具类] 封装 Preferences 数据读写逻辑
├── components (或 view)
│   ├── TodoList.ets       // [组件] 代办事项页面视图
│   └── NoteList.ets       // [组件] 笔记列表与编辑视图
├── pages
│   └── Index.ets          // [主页] 应用入口，包含 Tabs 导航
└── entryability
    └── EntryAbility.ts    // [系统] Ability 生命周期管理

```

## 🚀 如何运行

1. **环境准备**：确保已安装 **DevEco Studio** 并下载好 OpenHarmony SDK (API 9 或以上)。
2. **导入项目**：
* 打开 DevEco Studio -> `Open Project` -> 选择项目根目录。


3. **启动模拟器**：
* 点击工具栏 `Device Manager`。
* 新建或启动 `Phone` 类型的模拟器 (推荐 P50 镜像)。


4. **编译运行**：
* 等待 `Sync` 完成。
* 点击顶部绿色三角形 ▶️ 按钮运行。



## 📸 项目截图 (可选)


| 待办页 | 笔记页 |
| --- | --- |

| <img width="563" height="982" alt="image" src="https://github.com/user-attachments/assets/9ccce3f8-5396-4978-9636-defe74934592" />

 | <img width="556" height="981" alt="image" src="https://github.com/user-attachments/assets/265fea1c-d1a1-4eed-a469-352035351220" />
 |

## 🔮 未来规划 (To-Do)

* [ ] 增加按优先级（红/黄/绿）标记待办事项。
* [ ] 支持笔记关键词搜索功能。
* [ ] 适配深色模式 (Dark Mode)。
