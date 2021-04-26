import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:india_news/helper/data.dart';
import 'package:india_news/helper/news.dart';
import 'package:india_news/models/articleModel.dart';
import 'package:india_news/models/categoryModel.dart';
import 'package:india_news/views/article.dart';

import 'category.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<CategoryModel> categories = new List<CategoryModel>();
  List<ArticleModel> articles = new List<ArticleModel>();
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategories();
    getNews();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
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
        elevation: 0.0,
      ),
      body: _loading ? Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      ) : SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                height: 70,
                child: ListView.builder(
                  itemCount: categories.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index){
                    return CategoryTitle(
                      imageUrl: categories[index].imageUrl,
                      categoryName: categories[index].categoryName,
                    );
                  },
                ),
              ),
              SizedBox(height: 8,),
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
    );
  }
}

class CategoryTitle extends StatelessWidget {

  final imageUrl,categoryName;
  CategoryTitle({this.imageUrl,this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => Category(
              category: categoryName.toLowerCase(),
            )
        ));
      },
      child: Container(
        margin: EdgeInsets.only(right: 5, left: 5, ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(7),
                child: CachedNetworkImage(
                    imageUrl: imageUrl, width: 110, height: 100, fit: BoxFit.cover
                )),
            Container(
              alignment: Alignment.center,
              width: 110, height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Colors.black26,
              ),
              child: Text(
                categoryName,style: TextStyle(
                  color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              ),
            ),
          ],
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













