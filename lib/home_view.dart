import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF59AC44),
        title: const Text('Trello'),
      ),
      body: Center(
        child: Text('Home'),
      ),
    );
  }
}
