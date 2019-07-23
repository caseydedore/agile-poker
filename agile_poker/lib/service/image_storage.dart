import 'dart:io';
import 'package:path_provider/path_provider.dart';

class ImageStorage {
  Future<String> saveImage(File image) async {
    if (image?.path?.isEmpty ?? true) {
      return '';
    }
    final fileStorage = await getApplicationDocumentsDirectory();
    final path = fileStorage.absolute.path;
    final imageName = image.path.split(RegExp(r'\/|\\')).last;
    final appFilePath = '$path/$imageName';
    final savedFile = File(appFilePath);
    await savedFile.writeAsBytes(image.readAsBytesSync());
    return appFilePath;
  }

  Future deleteImage(String path) async {
    if (path.isEmpty) {
      return Future.value();
    }
    final file = File(path);
    return file.delete();
  }
}