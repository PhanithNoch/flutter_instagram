import 'package:get_storage/get_storage.dart';

class StorageHelper {
  static final StorageHelper _instance = StorageHelper._internal();

  factory StorageHelper() {
    return _instance;
  }

  StorageHelper._internal();

  static final _box = GetStorage();

  static void write(String key, dynamic value) {
    _box.write(key, value);
  }

  static dynamic read(String key) {
    return _box.read(key);
  }

  static void remove(String key) {
    _box.remove(key);
  }

  static void erase() {
    _box.erase();
  }
}
