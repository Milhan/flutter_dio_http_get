import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dio_http_get/service/post_comments.dart';
import 'package:flutter_dio_http_get/service/post_model.dart';

class ServicesLearnGet extends StatefulWidget {
  const ServicesLearnGet({Key? key}) : super(key: key);

  @override
  State<ServicesLearnGet> createState() => _ServicesLearnGetState();
}

class _ServicesLearnGetState extends State<ServicesLearnGet> {
  List<PostComments>? _itemsComments;
  List<PostModel>? _itemsModels;
  String name = 'APİ İle Veri Get';
  //late final Dio _dio;

  @override
  void initState() {
    super.initState();
    fectPost();
  }

  Future<void> fectPostComments() async {
    final response = await Dio()
        .get('https://jsonplaceholder.typicode.com/posts/1/comments');
    if (response.statusCode == HttpStatus.ok) {
      final datas = response.data;
      if (datas is List) {
        setState(() {
          _itemsComments = datas.map((e) => PostComments.fromJson(e)).toList();
        });
      }
    }
  }

  Future<void> fectPost() async {
    final response =
        await Dio().get('https://jsonplaceholder.typicode.com/posts');
    if (response.statusCode == HttpStatus.ok) {
      final datas = response.data;
      if (datas is List) {
        setState(() {
          _itemsModels = datas.map((e) => PostModel.fromJson(e)).toList();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: _itemsModels?.length ?? 0,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.red,
              child: Column(
                children: [
                  Text(
                    _itemsModels?[index].title ?? '',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _itemsModels?[index].body ?? '',
                    style: Theme.of(context).textTheme.headline6,
                  )
                ],
              ),
            );
          }),
    );
  }
}
