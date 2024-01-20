import 'package:demo_fs/models/user.dart';
import 'package:demo_fs/ui_screens/users/ctrl.dart';
import 'package:demo_fs/ui_screens/users/data.dart';
import 'package:flutter/material.dart';

class UserInput extends StatefulWidget {
  const UserInput({super.key});

  @override
  State<UserInput> createState() => _UserInputState();
}

class _UserInputState extends State<UserInput> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Input'),
      ),
      // ignore: prefer_const_constructors
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: ctrl1,
              onChanged: (value) {
                setState(() {
                  isShowClear1 = value.isNotEmpty;
                });
              },
              decoration: InputDecoration(
                suffixIcon: isShowClear1
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          ctrl1.clear();
                          setState(() {
                            isShowClear1 = false;
                          });
                        },
                      )
                    : null,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: ctrl2,
              onChanged: (value) {
                setState(() {
                  isShowClear2 = value.isNotEmpty;
                });
              },
              decoration: InputDecoration(
                suffixIcon: isShowClear2
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          ctrl2.clear();
                          setState(() {
                            isShowClear2 = false;
                          });
                        },
                      )
                    : null,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () async {
                final valNama = ctrl1.text;
                final valUmur = int.parse(ctrl2.text);
                final id = UniqueKey().toString();
                // final z = {'nama': x, 'umur': y};
                final newUser = UserX(
                  createdAt: DateTime.now().toString(),
                  id: id,
                  nama: valNama,
                  umur: valUmur,
                );
                debugPrint(newUser.toString());

                setState(() {
                  isLoading = true;
                });
                await createDoc(newUser);
                setState(() {
                  isLoading = false;
                });
                ctrl1.clear();
                ctrl2.clear();
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              },
              child: Text(isLoading ? 'loading...' : 'submit'),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
