import dataPreferences from '@ohos.data.preferences';
import common from '@ohos.app.ability.common';

// 定义常量，防止写错字符串
const STORE_NAME = 'StudentMemoStore';

export class StorageUtils {
  // 获取Preferences实例
  static async getStore(context: common.UIAbilityContext) {
    return await dataPreferences.getPreferences(context, STORE_NAME);
  }

  // 保存数据（通用方法：传入key和对象）
  static async putData(context: common.UIAbilityContext, key: string, value: any) {
    const store = await StorageUtils.getStore(context);
    // 将复杂的对象或数组转为字符串存储，简单粗暴
    await store.put(key, JSON.stringify(value));
    await store.flush(); // 必须刷盘，否则重启丢失
  }

  // 读取数据
  static async getData(context: common.UIAbilityContext, key: string) {
    const store = await StorageUtils.getStore(context);
    // 默认返回 '[]' 代表空数组的字符串
    const val = await store.get(key, '[]');
    return JSON.parse(val as string);
  }
}