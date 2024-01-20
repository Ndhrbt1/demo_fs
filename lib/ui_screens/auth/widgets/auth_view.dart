import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auth View'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) => Column(
                      children: [
                        snapshot.hasData
                            ? Column(
                                children: [
                                  Text('id: ${snapshot.data!.uid}'),
                                  const SizedBox(height: 10),
                                  Text(snapshot.data!.isAnonymous ? 'anonymous' : 'email: ${snapshot.data!.email}'),
                                ],
                              )
                            : const Text('You\'re not login'),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: snapshot.data == null
                              ? () async {
                                  final provider =
                                      GoogleAuthProvider().setCustomParameters({'prompt': 'select_account'});

                                  await FirebaseAuth.instance.signInWithPopup(provider);
                                }
                              : null,
                          child: const Text(
                            "signIn Google",
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: snapshot.data == null
                              ? () async {
                                  final authAnon = await FirebaseAuth.instance.signInAnonymously();
                                  debugPrint(authAnon.user.toString());
                                  debugPrint(authAnon.user?.uid.toString());
                                  debugPrint(authAnon.user?.refreshToken.toString());
                                }
                              : null,
                          child: const Text(
                            "signIn Anon",
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: snapshot.data == null
                              ? null
                              : () async {
                                  await FirebaseAuth.instance.signOut();
                                },
                          child: const Text(
                            "signOut ",
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: snapshot.data == null
                              ? null
                              : () async {
                                  await FirebaseAuth.instance.currentUser!.delete();
                                },
                          child: const Text(
                            "deleteAccount",
                          ),
                        ),
                      ],
                    )
                // : const Text('Anjeun teu acan login'),
                ),
            // const SizedBox(height: 10),
            // StreamBuilder(
            //   stream: FirebaseAuth.instance.authStateChanges(),
            //   builder: (context, snapshot) {
            //     return Column(
            //       children: [
            //         // ElevatedButton(
            //         //   onPressed: snapshot.data == null
            //         //       ? () async {
            //         //           final provider = GoogleAuthProvider().setCustomParameters({'prompt': 'select_account'});

            //         //           await FirebaseAuth.instance.signInWithPopup(provider);
            //         //         }
            //         //       : null,
            //         //   child: const Text(
            //         //     "signIn Google",
            //         //   ),
            //         // ),
            //         // const SizedBox(height: 10),
            //         // ElevatedButton(
            //         //   onPressed: snapshot.data == null
            //         //       ? () async {
            //         //           final authAnon = await FirebaseAuth.instance.signInAnonymously();
            //         //           debugPrint(authAnon.user.toString());
            //         //           debugPrint(authAnon.user?.uid.toString());
            //         //           debugPrint(authAnon.user?.refreshToken.toString());
            //         //         }
            //         //       : null,
            //         //   child: const Text(
            //         //     "signIn Anon",
            //         //   ),
            //         // ),
            //         // const SizedBox(height: 10),
            //         // ElevatedButton(
            //         //   onPressed: snapshot.data == null
            //         //       ? null
            //         //       : () async {
            //         //           await FirebaseAuth.instance.signOut();
            //         //         },
            //         //   child: const Text(
            //         //     "signOut ",
            //         //   ),
            //         // ),
            //       ],
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
