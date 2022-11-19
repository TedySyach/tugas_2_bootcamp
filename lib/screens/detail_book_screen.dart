import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BookListScreen extends StatefulWidget {
  const BookListScreen({super.key});

  @override
  State<BookListScreen> createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  //Fungsi untuk mengambil data dari API
  fetchBookApi() async {
    var url = Uri.parse('https://api.itbook.store/1.0/books/9781617294136');
    var response = await http.get(
      url,
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    // print(await http.read(Uri.https('example.com', 'foobar.txt')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Daftar Buku",
        ),
      ),
    );
  }
}