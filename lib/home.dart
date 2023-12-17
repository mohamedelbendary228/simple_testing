import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:testing/user_model.dart';
import 'package:testing/user_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<User> getUsers = UserRepository(Client()).getUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Test http request",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: FutureBuilder<User>(
        future: getUsers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: Text(
                '${snapshot.data?.name}',
                style: Theme.of(context).textTheme.displaySmall,
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
