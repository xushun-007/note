import { TodoList } from '../view/TodoList';
import { NoteList } from '../view/NoteList';

@Entry
@Component
struct Index {
  // 控制当前选中的Tab索引
  @State currentIndex: number = 0;

  build() {
    Column() {
      // 标题栏
      Text(this.currentIndex === 0 ? '学习清单' : '随手笔记')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .padding(15)
        .textAlign(TextAlign.Center)
        .backgroundColor('#FFFFFF')

      // 核心导航：Tabs
      Tabs({ barPosition: BarPosition.Start }) {
        // 1. 代办 Tab
        TabContent() {
          TodoList()
        }
        .tabBar('代办')

        // 2. 笔记 Tab
        TabContent() {
          NoteList()
        }
        .tabBar('笔记')
      }
      .onChange((index) => {
        this.currentIndex = index;
      })
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
  }
}