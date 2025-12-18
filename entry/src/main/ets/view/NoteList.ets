import { StorageUtils } from '../common/StorageUtils';
import common from '@ohos.app.ability.common';
import promptAction from '@ohos.promptAction';

interface NoteItem {
  time: string;
  content: string;
}

@Component
export struct NoteList {
  @State noteList: Array<NoteItem> = [];
  @State isEditing: boolean = false; // 控制是否在编辑模式
  @State editContent: string = '';     // 编辑框内容
  private context = getContext(this) as common.UIAbilityContext;

  async aboutToAppear() {
    this.noteList = await StorageUtils.getData(this.context, 'note_list');
  }

  saveData() {
    StorageUtils.putData(this.context, 'note_list', this.noteList);
  }

  // 获取当前时间字符串（大二基础）
  getCurrentTime(): string {
    const date = new Date();
    return `${date.getMonth() + 1}-${date.getDate()} ${date.getHours()}:${date.getMinutes()}`;
  }

  build() {
    Column() {
      // 通过if控制显示“列表”还是“编辑页”
      if (this.isEditing) {
        // --- 编辑模式 UI ---
        Column() {
          TextArea({ text: this.editContent, placeholder: '在此输入笔记内容...' })
            .height('80%')
            .width('100%')
            .onChange((value) => {
              this.editContent = value;
            })

          Row() {
            Button('取消')
              .backgroundColor('#CCCCCC')
              .onClick(() => {
                this.isEditing = false; // 返回列表
              })

            Button('保存笔记')
              .margin({ left: 20 })
              .onClick(() => {
                if (this.editContent.trim() === '') {
                  promptAction.showToast({ message: '内容不能为空' });
                  return;
                }
                // 保存逻辑：时间 + 内容
                this.noteList.unshift({
                  time: this.getCurrentTime(),
                  content: this.editContent
                });
                this.saveData();
                this.isEditing = false; // 保存后返回列表
              })
          }
          .margin({ top: 20 })
        }
        .padding(15)
        .height('100%')

      } else {
        // --- 列表模式 UI ---
        Column() {
          Button('+ 新建笔记')
            .width('90%')
            .margin({ top: 10, bottom: 10 })
            .onClick(() => {
              this.editContent = ''; // 清空之前的输入
              this.isEditing = true; // 切换到编辑页
            })

          List({ space: 10 }) {
            ForEach(this.noteList, (item: NoteItem, index: number) => {
              ListItem() {
                Row() {
                  Column() {
                    // 显示第一行内容的简略信息
                    Text(item.content.split('\n')[0])
                      .fontSize(16)
                      .fontWeight(FontWeight.Bold)
                      .maxLines(1)
                      .textOverflow({ overflow: TextOverflow.Ellipsis })

                    Text(item.time)
                      .fontSize(12)
                      .fontColor(Color.Gray)
                      .margin({ top: 5 })
                  }
                  .alignItems(HorizontalAlign.Start)
                  .layoutWeight(1)

                  Button('删除')
                    .fontSize(12)
                    .backgroundColor(Color.Red)
                    .height(25)
                    .onClick(() => {
                      this.noteList.splice(index, 1);
                      this.saveData();
                    })
                }
                .width('100%')
                .padding(15)
                .backgroundColor('#F9F9F9')
                .borderRadius(8)
              }
            })
          }
          .layoutWeight(1)
          .width('100%')
          .padding({ left: 10, right: 10 })
        }
      }
    }
    .height('100%')
    .width('100%')
  }
}