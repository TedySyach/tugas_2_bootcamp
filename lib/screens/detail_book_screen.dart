import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tugas_2_bootcamp/models/book_detail_response.dart';

class DetailBookScreen extends StatefulWidget {
  const DetailBookScreen({super.key, required this.isbn});
  final String isbn;

  @override
  State<DetailBookScreen> createState() => _DetailBookScreenState();
}

class _DetailBookScreenState extends State<DetailBookScreen> {
  //variable public
  BookDetailResponse? detailBook;
  //Fungsi untuk mengambil data dari API
  fetchBookApi() async {
    print("ISBN : ${widget.isbn}");
    var url = Uri.parse('https://api.itbook.store/1.0/books/${widget.isbn}');
    var response = await http.get(
      url,
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonDetail = jsonDecode(response.body);
      detailBook = BookDetailResponse.fromJson(jsonDetail);
      setState(() {});
    }
  }

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
            "Detail Buku",
          ),
        ),
        body: detailBook == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [],
              ));
  }
}
