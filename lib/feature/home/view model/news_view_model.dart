import 'package:flutter/material.dart';
import 'package:news/feature/home/data/api_manger.dart';
import 'package:news/feature/home/data/models/news_response.dart';

class NewsViewModel extends ChangeNotifier{
  int selectedTap=0;
  List<Source> sources=[];
  List<Articles> article=[];

  bool isLoading=false;

  Future<void> getNews(String sourceId)async{
    isLoading=true;
    notifyListeners();
    article=await ApiManger.getNews(sourceId);
    isLoading=false;
    notifyListeners();
  }
  Future<void> getSource(String catogery)async{
    isLoading=true;
    notifyListeners();
    sources=await ApiManger.getSources(catogery);
    getNews(sources[0].id??'');
    isLoading=false;
    notifyListeners();
  }

  void onTapChange(int index){
    selectedTap=index;
    getNews(sources[index].id??'');
    notifyListeners();
  }
}