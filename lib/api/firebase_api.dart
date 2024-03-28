import 'package:firebase_storage/firebase_storage.dart';

import '../model/firebase_file.dart';

class FirebaseApi {
  static Future<List<FirebaseFile>> listAll(String path) async {
    final ref = FirebaseStorage.instance.ref(path);
    final result = await ref.listAll();
    final urls = await Future.wait(
        result.items.map((ref) => ref.getDownloadURL()).toList());

    return urls
        .asMap()
        .map((index, url) {
          final ref = result.items[index];
          final name = ref.name;
          final file = FirebaseFile(ref: ref, name: name, url: url);

          return MapEntry(index, file);
        })
        .values
        .toList();
  }
}
