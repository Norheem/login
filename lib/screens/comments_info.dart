import 'package:flutter/material.dart';
import 'package:login/models/comment_model.dart';
import 'package:login/screens/login.dart';

class CommentInfo extends StatelessWidget {
  final CommentModel comment;

  const CommentInfo({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          comment.name!,
          style: const TextStyle(
            color: Colors.amber,
            fontWeight: FontWeight.bold,
          ),
        )),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.logout_rounded,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Center(
                  child: Text(
                    comment.email!,
                    style: TextStyle(
                      color: Colors.green[400],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                    child: Text(
                  comment.body!,
                  style: TextStyle(
                    color: Colors.blue.shade500,
                    fontWeight: FontWeight.bold,
                  ),
                ))
              ],
            ),
          ),
        ],
      )),
    );
  }
}
