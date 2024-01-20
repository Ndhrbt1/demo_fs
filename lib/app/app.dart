import 'package:demo_fs/ui_screens/users/widgets/user_list.dart';
// import 'package:demo_fs/ui_screens/storage/widgets/storage_view.dart';
// import 'package:demo_fs/ui_screens/users/widgets/user_list.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData.dark(),
      // home: const AuthView(),
      // home: const StorageView(),
      home: const UserList(),
      // home: const InputX(),
    );
  }
}
