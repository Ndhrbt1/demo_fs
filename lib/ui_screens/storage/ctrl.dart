import 'package:demo_fs/ui_screens/storage/data.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

Future<String> uploadImage() async {
  final imageName = uploadPickedFile!.name;
  final imageType = uploadPickedFile!.mimeType;
  final imageId = UniqueKey().toString();
  // debugPrint(imageType.toString());

  final imageBytes = await uploadPickedFile!.readAsBytes();
  final task = await FirebaseStorage.instance.ref('$imageId $imageName').putData(
        imageBytes,
        SettableMetadata(contentType: imageType),
      );
  final url = await task.ref.getDownloadURL();
  return url;
}
