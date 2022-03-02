import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/news_model/news_api_model.dart';
import 'package:news_app/services/api_manager.dart';

import 'home_page.dart';

class InnerPage extends StatefulWidget {
  const InnerPage({Key? key}) : super(key: key);

  @override
  _InnerPageState createState() => _InnerPageState();
}

class _InnerPageState extends State<InnerPage> {
  late Future<NewsSite> _newsModel;

  @override
  void initState(){
    _newsModel = ApiManager().getNews();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.white,
        title: Text('News App', style: TextStyle(color: Colors.black,fontSize: 30),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.black,),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
          },
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder<NewsSite>(
         future: _newsModel,
         builder: (context,snapshot){
           if(snapshot.hasData){
             return  ListView.separated(
               separatorBuilder: (context, _)=>SizedBox(height: 10),
               itemCount: snapshot.data!.articles!.length,
               itemBuilder: (context, index){
               var article = snapshot.data!.articles![index];
               return Container(
                 margin: EdgeInsets.all(10),
                child: Column(
                children: [
                   Container(
                     height: 300,
                     width: MediaQuery.of(context).size.width,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(24),
                       image: DecorationImage(
                         image: NetworkImage(article.urlToImage),
                         fit: BoxFit.cover
                       )
                     ),
                   ),
                   Text(article.title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                  Text(article.description)
                    ],

                  ),
              );
            },
        );
       }else {
             return Center(
              child:CircularProgressIndicator());
           }

           }
       ));
          }
     }
