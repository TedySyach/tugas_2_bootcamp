import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:tugas_2_bootcamp/controllers/book_controller.dart';
import 'package:tugas_2_bootcamp/models/book_list_respone.dart';
import 'package:tugas_2_bootcamp/screens/detail_book_screen.dart';

class BookListScreen extends StatefulWidget {
  const BookListScreen({super.key});

  @override
  State<BookListScreen> createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  BookController? bookController;

  //Melakukan Pemanggilan Function fectBookApi
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bookController = Provider.of<BookController>(context, listen: false);
    bookController!.fetchBookApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Daftar Buku",
        ),
      ),
      body: Consumer<BookController>(
        builder: (context, value, child) => Container(
          child: (bookController!.booklist == null)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: bookController!.booklist!.books!.length,
                  itemBuilder: ((context, index) {
                    final currentBook = bookController!.booklist!.books![index];
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
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 16.0, left: 16.0, right: 16.0),
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.network(currentBook.image!),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16.0,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          currentBook.title!,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          currentBook.title!,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Text(
                                  currentBook.price!,
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ));
                  })),
        ),
      ),
    );
  }
}
