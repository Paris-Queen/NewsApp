import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/api_constants/api_constanst.dart';
import 'package:news_app/news_model/news_api_model.dart';
 class ApiManager {
  Future<NewsSite> getNews() async{
   var client = http.Client();
   var newsModel = null;
  try {
   var respond = await client.get(Uri.parse(ApiConstant.news_url));
   if (respond.statusCode == 200) {
    var jsonString = respond.body;
    var jsonMap = json.decode(jsonString);
    newsModel = NewsSite.fromJson(jsonMap);
   }
  }catch(Exception){
   return newsModel;
  }
   return newsModel;
  }

 }