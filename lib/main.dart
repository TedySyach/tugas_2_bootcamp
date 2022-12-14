import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas_2_bootcamp/controllers/book_controller.dart';
import 'package:tugas_2_bootcamp/screens/book_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: ((context) => BookController()),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const BookListScreen(),
      ),
    );
  }
}
