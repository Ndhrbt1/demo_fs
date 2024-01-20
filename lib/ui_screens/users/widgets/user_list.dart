import 'dart:math';

import 'package:demo_fs/models/user.dart';
import 'package:demo_fs/ui_screens/users/ctrl.dart';
import 'package:demo_fs/ui_screens/users/data.dart';

import 'package:demo_fs/ui_screens/users/widgets/user_detail.dart';
import 'package:demo_fs/ui_screens/users/widgets/user_input.dart';

import 'package:english_words/english_words.dart';

import 'package:flutter/material.dart';

class UserList extends StatefulWidget {
  const UserList({
    super.key,
  });

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  void initState() {
    addColToUserList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: null,
            onPressed: () {
              final route = MaterialPageRoute(
                builder: (context) => const UserInput(),
              );
              Navigator.push(context, route);
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: null,
            onPressed: () {
              setState(() {});
            },
            child: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder(
        future: getColl(),
        builder: (context, snapshot) {
          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return const Center(child: CircularProgressIndicator());
          // }
          if (snapshot.hasData) {
            final length = userList.length;

            return SingleChildScrollView(
              child: Column(
                children: [
                  ...List.generate(
                    length,
                    (index) {
                      final data = userList[index];
                      // final data = snapshot.data![index];
                      final id = data.id;
                      return Card(
                        child: ListTile(
                          title: Text(data.nama),
                          selected: selectedId == id,
                          tileColor: Colors.transparent,
                          selectedTileColor: Colors.pink,
                          subtitle: Text(data.createdAt),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () async {
                                  final updateUser = UserX(
                                    id: id,
                                    umur: Random().nextInt(99),
                                    createdAt: data.createdAt,
                                    nama: WordPair.random().toString(),
                                  );
                                  await updateDoc(updateUser);
                                  setState(() {});
                                },
                                icon: const Icon(Icons.loop),
                              ),
                              IconButton(
                                onPressed: () async {
                                  await deleteDoc(id);
                                  setState(() {});
                                },
                                icon: const Icon(Icons.delete),
                              ),
                            ],
                          ),
                          onTap: () {
                            setState(() {
                              selectedId = id;
                            });
                            final route = MaterialPageRoute(
                              builder: (context) => UserDetail(
                                id: id,
                              ),
                            );
                            Navigator.push(context, route);
                          },
                        ),
                      );
                    },
                  ),
                  isEnd
                      ? const Text('end of list')
                      : snapshot.connectionState == ConnectionState.waiting
                          ? const CircularProgressIndicator()
                          : OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  addColToUserList();
                                });
                              },
                              child: const Text('loadmore'),
                            ),
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
