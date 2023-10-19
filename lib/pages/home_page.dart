import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_app/components/my_drawer.dart';
import 'package:social_app/components/my_post_button.dart';
import 'package:social_app/components/my_textfield.dart';
import 'package:social_app/database/firestore.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final FireStoreDatabase database = FireStoreDatabase();

  final TextEditingController newPostController = TextEditingController();

  void postMessage() {
    if (newPostController.text.isNotEmpty) {
      String message = newPostController.text;
      database.addPost(message);
    }

    newPostController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("W A L L"),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        elevation: 0,
      ),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(25),
            child: Row(
              children: [
                Expanded(
                  child: MyTextField(
                    hintText: "Say something nice", 
                    obscureText: false, 
                    controller: newPostController
                  ),
                ),

                PostButton(
                  onTap: postMessage
                )
              ],
            ),
          ),

          StreamBuilder(
            stream: database.getPostsStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              final posts = snapshot.data!.docs;

              if (snapshot.data == null || posts.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(25),
                    child: Text("No Posts..Post something!")
                  ),
                );
              } 

              return Expanded(
                child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];

                    String message = post['PostMessage'];
                    String userEmail = post['UserEmail'];

                    return Padding(
                      padding: const EdgeInsets.all(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20, 
                          vertical: 15
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(12)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              message,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              userEmail,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.inversePrimary
                              )
                            )
                          ],
                        )
                      ),
                    );
                  }
                ),
              );
            }
          )
        ],
      )
    );
  }
}