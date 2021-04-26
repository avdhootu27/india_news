import 'package:flutter/material.dart';
import 'package:india_news/helper/news.dart';
import 'package:india_news/models/articleModel.dart';

import 'article.dart';

class Category extends StatefulWidget {

  final String category;
  Category({this.category});

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {

  List<ArticleModel> articles = new List();
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async {
    CategoryNews newsClass = CategoryNews();
    await newsClass.getNews(widget.category);
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('India'),
            Text('News',style: TextStyle(
              color: Colors.blue,
            ),),
          ],
        ),
        actions: [
          Opacity(
            opacity: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.save),
            ),
          ),
        ],
        elevation: 0.0,
      ),
      body: _loading ? Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      ) : SingleChildScrollView(
        padding: EdgeInsets.only(top: 12),
        child: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                child: ListView.builder(
                    itemCount: articles.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index){
                      return BlogTile(
                        imageUrl: articles[index].urlToImage,
                        title: articles[index].title,
                        description: articles[index].description,
                        url: articles[index].url,
                      );
                    }
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl, title, description, url;
  BlogTile({@required this.imageUrl, @required this.title, @required this.description, @required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => Article(
              BlogUrl: url,
            )
        ));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 15),
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(imageUrl)
            ),
            SizedBox(height: 5,),
            Text(title, style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),),
            SizedBox(height: 5,),
            Text(description, style: TextStyle(
              // fontSize: 14,
              color: Colors.grey,
            ),),
          ],
        ),
      ),
    );
  }
}