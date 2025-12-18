import { StorageUtils } from '../common/StorageUtils';
import common from '@ohos.app.ability.common';
import promptAction from '@ohos.promptAction';

// 定义代办事项的数据结构
interface TodoItem {
  content: string;
  isDone: boolean;
}

@Component
export struct TodoList {
  // 当前输入框的内容
  @State inputValue: string = '';
  // 代办列表数据
  @State todoList: Array<TodoItem> = [];
  // 获取上下文，用于存储数据
  private context = getContext(this) as common.UIAbilityContext;

  // 组件加载时，读取本地数据
  async aboutToAppear() {
    this.todoList = await StorageUtils.getData(this.context, 'todo_list');
  }

  // 封装保存逻辑，每次数据变动都调用
  saveData() {
    StorageUtils.putData(this.context, 'todo_list', this.todoList);
  }

  build() {
    Column() {
      // 1. 顶部添加栏
      Row() {
        TextInput({ placeholder: '输入作业/考试/还书...', text: this.inputValue })
          .layoutWeight(1) // 占据剩余宽度
          .onChange((value) => {
            this.inputValue = value;
          })

        Button('添加')
          .margin({ left: 10 })
          .onClick(() => {
            if (this.inputValue.trim() === '') {
              promptAction.showToast({ message: '请输入内容' }); // 基础容错
              return;
            }
            // 往数组头部添加新数据
            this.todoList.unshift({ content: this.inputValue, isDone: false });
            this.inputValue = ''; // 清空输入框
            this.saveData(); // 保存
          })
      }
      .width('100%')
      .padding(15)
      .backgroundColor('#F1F3F5')

      // 2. 代办列表
      List({ space: 10 }) {
        ForEach(this.todoList, (item: TodoItem, index: number) => {
          ListItem() {
            Row() {
              // 核心交互：Checkbox
              Checkbox({ name: 'checkbox', group: 'todos' })
                .select(item.isDone)
                .onChange((value: boolean) => {
                  item.isDone = value; // 更新状态
                  // 强制刷新列表UI（ArkTS有时需要重新赋值触发刷新，简单处理）
                  this.todoList = [...this.todoList];
                  this.saveData();
                })

              // 核心交互：文字颜色变化
              Text(item.content)
                .fontSize(18)
                .fontColor(item.isDone ? '#999999' : '#000000') // 灰/黑切换
                .decoration({ type: item.isDone ? TextDecorationType.LineThrough : TextDecorationType.None }) // 选做：加删除线更直观
                .layoutWeight(1)
                .margin({ left: 10 })

              // 删除按钮
              Button('删除')
                .backgroundColor(Color.Red)
                .fontSize(14)
                .height(30)
                .onClick(() => {
                  this.todoList.splice(index, 1); // 移除该项
                  this.saveData();
                })
            }
            .width('100%')
            .padding(10)
            .backgroundColor(Color.White)
            .borderRadius(8)
          }
        })
      }
      .layoutWeight(1) // 占满剩余高度
      .padding(10)
      .width('100%')
    }
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}