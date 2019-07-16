import 'dart:io';
import 'package:path_provider/path_provider.dart';

class ImageStorage {
  Future<String> saveImage(File image) async {
    if(image.path.isEmpty){
      return image.path;
    }
    final fileStorage = await getApplicationDocumentsDirectory();
    final path = fileStorage.absolute.path;
    final imageName = image.path.split(RegExp(r'\/|\\')).last;
    final appFilePath = '$path/$imageName';
    final savedFile = File(appFilePath);
    await savedFile.writeAsBytes(image.readAsBytesSync());
    return appFilePath;
  }
}