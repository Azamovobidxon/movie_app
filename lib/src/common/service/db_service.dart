
import 'package:shared_preferences/shared_preferences.dart';

enum StorageKeys{
  movies('movies');
  const StorageKeys(this.key);
  final String key;
}
final $storage = SharedPreferences.getInstance();