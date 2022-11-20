import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tugas_2_bootcamp/models/book_list_respone.dart';
import 'package:tugas_2_bootcamp/screens/detail_book_screen.dart';

class BookListScreen extends StatefulWidget {
  const BookListScreen({super.key});

  @override
  State<BookListScreen> createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  // variable public
  BookListRespone? booklist;

  //Fungsi untuk mengambil data dari API
  fetchBookApi() async {
    var url = Uri.parse('https://api.itbook.store/1.0/new');
    var response = await http.get(
      url,
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    //Mengubah respone dari body yang berupa string kedalam Json
    if (response.statusCode == 200) {
      final jsonBookList = jsonDecode(response.body);
      booklist = BookListRespone.fromJson(jsonBookList);
      setState(() {});
    }
  }

  //Melakukan Pemanggilan Function fectBookApi
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchBookApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Daftar Buku",
        ),
      ),
      body: Container(
        child: (booklist == null)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: booklist!.books!.length,
                itemBuilder: ((context, index) {
                  final currentBook = booklist!.books![index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: ((context) => DetailBookScreen(
                                isbn: currentBook.isbn13!,
                              )),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Image.network(
                          currentBook.image!,
                          height: 100,
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(currentBook.title!),
                                Text(currentBook.subtitle!),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    currentBook.price!,
                                    style: const TextStyle(
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                })),
      ),
    );
  }
}
