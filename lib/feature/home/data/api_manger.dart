import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../core/api key/api_keys.dart';
import 'models/news_response.dart';

class ApiManger{

  static Future<List<Source>> getSources(String category)async{

    try{
      List<Source> sources=[];
      var uri =Uri.https("newsapi.org","v2/top-headlines/sources",{
        "apiKey":ApiKey.apiKey,
        "category":category,
      });
      var response=await http.get(uri);
      if (response.statusCode==200){
        var data =jsonDecode(response.body);
        var sourceData=data["sources"];
        for(var e in sourceData){
          sources.add(Source.fromJson(e));
        }
        return sources;
      }else{
        return [];
      }
    }catch(e,s){
      print(s);
      rethrow;
    }

  }
  static Future<List<Articles>> getNews(String sourceId)async{

    try{
      List<Source> sources=[];
      var uri =Uri.https("newsapi.org","v2/everything",{
        "apiKey":ApiKey.apiKey,
        "sources":sourceId,
      });
      var response=await http.get(uri);
      if (response.statusCode==200){
        var data =jsonDecode(response.body);
        NewsResponse newsResponse=NewsResponse.fromJson(data);
        return newsResponse.articles??[];
      }else{
        return [];
      }
    }catch(e,s){
      print(s);
      rethrow;
    }

  }

}




// class Source {
//   String? id;
//   String? name;
//
//   Source({this.id, this.name});
//
//   Source.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     return data;
//   }
// }
