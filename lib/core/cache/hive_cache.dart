import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

class HiveCache {
  static late Box myBox;

  static Future<void> openHive() async {
    if (!Hive.isBoxOpen('localDB')) {
      await Hive.initFlutter((await getApplicationDocumentsDirectory()).path);
    }
    myBox = await Hive.openBox('localDB');
  }

  static Future<void> saveData(
      {required String key, required dynamic value}) async {
    await myBox.put(key, value);
  }

  static dynamic getData({required String key}) {
    return myBox.get(key);
  }

  static Future<void> deleteData({required String key}) async {
    await myBox.delete(key);
  }

  static Future<void> clearData() async {
    await myBox.clear();
  }

  static Future<void> closeHive() async {
    await myBox.close();
  }

  static Future<void> updateData(
      {required String key, required dynamic value}) async {
    await myBox.put(key, value);
  }
}
