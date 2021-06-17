import 'dart:convert';

import 'package:e_news/models/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  late List<ArticleModel> news = [];

  Future<void> getNews() async {
    var response =
        await http.get(Uri.https('testapi.io', 'api/charanvinay/news'));

    var jsonData = jsonDecode(response.body);

    jsonData.forEach((element) {
      ArticleModel articleModel = ArticleModel(
        headline: element['headline'],
        date: element["date"],
        content: element["content"],
        image: element["image"],
      );

      news.add(articleModel);
    });
  }
}
