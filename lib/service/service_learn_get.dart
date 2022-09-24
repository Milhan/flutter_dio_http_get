import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dio_http_get/service/post_model.dart';

class ServicesLearnGet extends StatefulWidget {
  const ServicesLearnGet({Key? key}) : super(key: key);

  @override
  State<ServicesLearnGet> createState() => _ServicesLearnGetState();
}

class _ServicesLearnGetState extends State<ServicesLearnGet> {
  List<PostModel>? _items;
  String name = 'APİ İle Veri Get';
  //late final Dio _dio;

  @override
  void initState() {
    super.initState();
    fectPostItems();
  }

  Future<void> fectPostItems() async {
    final response =
        await Dio().get('https://jsonplaceholder.typicode.com/posts');
    if (response.statusCode == HttpStatus.ok) {
      final datas = response.data;
      if (datas is List) {
        setState(() {
          _items = datas.map((e) => PostModel.fromJson(e)).toList();
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
        body: Center(
            child: _items == null
                ? const CircularProgressIndicator.adaptive(
                    backgroundColor: Colors.red,
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    itemCount: _items?.length ?? 0,
                    itemBuilder: (context, index) {
                      return _PostCard(model: _items?[index]);
                    })));
  }
}

class _PostCard extends StatelessWidget {
  const _PostCard({
    Key? key,
    required PostModel? model,
  })  : _model = model,
        super(key: key);

  final PostModel? _model;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {},
        title: Text(
          _model?.title ?? 'Ali',
          style: TextStyle(color: Colors.red),
        ),
        subtitle: Text(_model?.body ?? 'Ali Açıklama'),
        leading: Text(_model?.id.toString() ?? '1'),
        //dense: true,
      ),
    );
  }
}
