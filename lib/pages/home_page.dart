import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/api_constants/api_constanst.dart';
import 'package:news_app/news_model/news_api_model.dart';
import 'package:news_app/services/api_manager.dart';

import 'inner_page.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<NewsSite> _newsModel;
  @override
  void initState(){
    _newsModel = ApiManager().getNews();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('News App', style: TextStyle(color: Colors.black,fontSize: 18),),
          centerTitle: true,
          elevation: 0,
        ),
        body: FutureBuilder<NewsSite>(
          future: _newsModel,
          builder: (context,snapshot){
            if(snapshot.hasData){
              return  ListView.builder(
                itemCount: snapshot.data!.articles!.length,
                itemBuilder: (context, index){
                  var article = snapshot.data!.articles![index];
                  return Container(
                    margin: EdgeInsets.all(10),
                    height: 100,
                    //color: Colors.red,
                    child: Row(
                      children: [
                        Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24)
                          ),
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Image.network(article.urlToImage,fit: BoxFit.cover,),
                          ),
                        ),
                        SizedBox(width: 12,),
                        Expanded(
                            child:InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>InnerPage()));

                              },
                                child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Text(article.title,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                  Text(article.description,overflow: TextOverflow.ellipsis,maxLines: 3,)
                          ],
                        )
                        )
                        )
                      ],
                    ),
                  );
                },
              );
            }else
              return Center(child:CircularProgressIndicator());

          }
        )
    );
  }

}
