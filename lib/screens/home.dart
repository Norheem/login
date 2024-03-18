import 'package:flutter/material.dart';
import 'package:login/auth/auth_view_model.dart';
import 'package:login/models/register_provider.dart';
import 'package:login/screens/comments_info.dart';
import 'package:login/screens/login.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    context.read<AuthViewModel>().getComments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'All Comments',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Consumer<RegisterProvider>(
              builder: (context, registerProvider, child) {
            final email = registerProvider.email;
            //final username = registerProvider.username;
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text(
                      'Hello ',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      email.isNotEmpty ? email : 'Guest',
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
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
            );
          }),
          Expanded(
            child: Consumer<AuthViewModel>(
              builder: (context, authViewModel, child) {
                final comments = authViewModel.allComment;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: comments.length,
                  itemBuilder: (BuildContext context, int index) {
                    final comment = comments[index];
                    return Column(
                      children: [
                        ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CommentInfo(
                                  comment: comment,
                                ),
                              ),
                            );
                          },
                          leading: Text(
                            '${index + 1}',
                            style: TextStyle(
                              color: Colors.red.shade600,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          title: Text(comment.name ?? ''),
                        ),
                        const Divider(
                          color: Colors.grey,
                          thickness: 0.5,
                          indent: 16,
                          endIndent: 16,
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
