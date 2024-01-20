import 'package:demo_fs/ui_screens/storage/ctrl.dart';
import 'package:demo_fs/ui_screens/storage/data.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class StorageView extends StatefulWidget {
  const StorageView({super.key});

  @override
  State<StorageView> createState() => _StorageViewState();
}

class _StorageViewState extends State<StorageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('storage view'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  final imagePicker = await ImagePicker().pickImage(source: ImageSource.gallery);

                  pickedFile = imagePicker;

                  setState(() {});
                },
                child: const Text(
                  "pick image from galery",
                ),
              ),
              const SizedBox(height: 10),
              Text('${pickedFile?.path}', textAlign: TextAlign.center),
              pickedFile == null
                  ? const SizedBox.shrink()
                  : SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.network(pickedFile!.path),
                    ),
              const SizedBox(height: 10),
              pickedFile == null
                  ? const SizedBox.shrink()
                  : FutureBuilder(
                      future: uploadPickedFile == null ? Future.delayed(Duration.zero) : uploadImage(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        }
                        return ElevatedButton(
                          onPressed: () async {
                            uploadPickedFile = pickedFile;
                            final getUrl = await uploadImage();
                            imageUrl = getUrl;

                            setState(() {});
                          },
                          child: const Text(
                            "upload",
                          ),
                        );
                      },
                    ),
              const SizedBox(height: 10),
              Text(imageUrl, textAlign: TextAlign.center),
              const SizedBox(height: 10),
              imageUrl.isEmpty
                  ? const SizedBox.shrink()
                  : SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.network(imageUrl),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
