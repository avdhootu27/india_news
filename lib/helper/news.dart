import 'dart:convert' as convert;

import 'package:http/http.dart';
import 'package:india_news/models/articleModel.dart';
import 'package:http/http.dart' as http;

class News {

  List<ArticleModel> news = [];

  Future<void> getNews() async {
    var url = Uri.parse("http://newsapi.org/v2/top-headlines?country=in&excludeDomains=stackoverflow.com&sortBy=publishedAt&language=en&apiKey=9bd00bf8610745e9ae52cddd55eaa5d5");
    Response response = await http.get(url);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var jsondata = convert.jsonDecode(response.body);
      if (jsondata['status'] == "ok") {
        jsondata['articles'].forEach((element) {
          if (element['urlToImage'] != null && element['description'] != null) {
            ArticleModel articleModel = ArticleModel(
              title: element['title'],
              author: element['author'],
              description: element['description'],
              url: element['url'],
              urlToImage: element['urlToImage'],
              // publishedAt: element['publishedAt'],
              content: element['content'],
            );
            news.add(articleModel);
          }
        });
      }
    }
    else{
      print("nonono");
    }
    return news;

  }



}

class CategoryNews {

  List<ArticleModel> news = [];

  Future<void> getNews(String category) async {
    var url = Uri.parse("http://newsapi.org/v2/top-headlines?country=in&category=$category&excludeDomains=stackoverflow.com&sortBy=publishedAt&language=en&apiKey=9bd00bf8610745e9ae52cddd55eaa5d5");
    Response response = await http.get(url);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var jsondata = convert.jsonDecode(response.body);
      if (jsondata['status'] == "ok") {
        jsondata['articles'].forEach((element) {
          if (element['urlToImage'] != null && element['description'] != null) {
            ArticleModel articleModel = ArticleModel(
              title: element['title'],
              author: element['author'],
              description: element['description'],
              url: element['url'],
              urlToImage: element['urlToImage'],
              // publishedAt: element['publishedAt'],
              content: element['content'],
            );
            news.add(articleModel);
          }
        });
      }
    }
    else{
      print("nonono");
    }
    return news;

  }



}