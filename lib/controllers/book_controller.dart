import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/book_detail_response.dart';
import '../models/book_list_respone.dart';

class BookController extends ChangeNotifier {
  // variable public
  BookListRespone? booklist;

  //Fungsi untuk mengambil data dari API
  fetchBookApi() async {
    var url = Uri.parse('https://api.itbook.store/1.0/new');
    var response = await http.get(
      url,
    );

    //Mengubah respone dari body yang berupa string kedalam Json
    if (response.statusCode == 200) {
      final jsonBookList = jsonDecode(response.body);
      booklist = BookListRespone.fromJson(jsonBookList);
      notifyListeners();
    }
  }

  //variable public
  BookDetailResponse? detailBook;
  //Fungsi untuk mengambil data dari API
  fetchBookDetailApi(isbn) async {
    // print("ISBN : ${widget.isbn}");
    var url = Uri.parse('https://api.itbook.store/1.0/books/$isbn');
    var response = await http.get(
      url,
    );

    if (response.statusCode == 200) {
      final jsonDetail = jsonDecode(response.body);
      detailBook = BookDetailResponse.fromJson(jsonDetail);
      // setState(() {});
      notifyListeners();
      fetchSimilarBookApi(detailBook!.title!);
    }
  }

  BookListRespone? similarBook;
  fetchSimilarBookApi(String tittle) async {
    var url = Uri.parse('https://api.itbook.store/1.0/search/$tittle');
    var response = await http.get(
      url,
    );

    if (response.statusCode == 200) {
      final jsonDetail = jsonDecode(response.body);
      similarBook = BookListRespone.fromJson(jsonDetail);
      // setState(() {});
      notifyListeners();
    }
  }
}
