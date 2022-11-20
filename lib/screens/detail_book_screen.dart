import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tugas_2_bootcamp/models/book_detail_response.dart';
import 'package:tugas_2_bootcamp/models/book_list_respone.dart';

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
      fetchSimilarBookApi(detailBook!.title!);
    }
  }

  BookListRespone? similarBook;
  fetchSimilarBookApi(String tittle) async {
    var url = Uri.parse('https://api.itbook.store/1.0/search/$tittle');
    var response = await http.get(
      url,
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonDetail = jsonDecode(response.body);
      similarBook = BookListRespone.fromJson(jsonDetail);
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
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Part 1
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Column(
                        children: [
                          DetailBookCard(detailBook: detailBook),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),

                    //Part 2
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: MoreDetailCard(detailBook: detailBook),
                    ),
                    //Part 3

                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "Similar",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: SizedBox(
                        child: similarBook == null
                            ? const CircularProgressIndicator()
                            : ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: similarBook!.books!.length,
                                itemBuilder: (((context, index) {
                                  final current = similarBook!.books![index];
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: Container(
                                      width: 140,
                                      decoration: BoxDecoration(
                                        color: Colors.blueAccent,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        children: [
                                          Image.network(
                                            current.image!,
                                            height: 120,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 5,
                                            ),
                                            child: Text(
                                              current.title!,
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }))),
                      ),
                    )
                  ],
                ),
              ));
  }
}

class MoreDetailCard extends StatelessWidget {
  const MoreDetailCard({
    Key? key,
    required this.detailBook,
  }) : super(key: key);

  final BookDetailResponse? detailBook;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blue,
          ),
          child: const Center(
            child: Text(
              "Buy",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          detailBook!.desc!,
          textAlign: TextAlign.justify,
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            const Text(
              "Publisher : ",
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              detailBook!.publisher!,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            const Text(
              "Language : ",
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              detailBook!.language!,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            const Text(
              "Year : ",
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              detailBook!.year!,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          detailBook!.isbn13!,
          textAlign: TextAlign.justify,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            5,
            (index) => Icon(
              Icons.star,
              size: 32,
              color: index > int.parse(detailBook!.rating!)
                  ? Colors.amber
                  : Colors.grey,
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}

class DetailBookCard extends StatelessWidget {
  const DetailBookCard({
    Key? key,
    required this.detailBook,
  }) : super(key: key);

  final BookDetailResponse? detailBook;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.network(
          detailBook!.image!,
          height: 120,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 25,
                ),
                Text(
                  detailBook!.title!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  detailBook!.authors!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  detailBook!.subtitle!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.grey),
                ),
                Text(
                  detailBook!.price!,
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                    fontSize: 28,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
