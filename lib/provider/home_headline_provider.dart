import 'package:flutter/material.dart';
import 'package:news_app/api_client/api_client.dart';
import 'package:news_app/model/home_headline_model.dart';

part 'home_headline_provider_impl.dart';

abstract class HomeHeadlineProvider with ChangeNotifier{
  /// variable
  bool _isLoading=false;
  List<Article>?_homeHeadlineArticleList;



  //get value
  bool get isLoading=>_isLoading;
  List<Article>?get homeHeadlineArticleList=>_homeHeadlineArticleList;

  //set value

  //get list of article
  Future<HomeHeadlineModel>getListHomeHeadlineArticle();
  //set loading
  void setLoading({required bool loading});

}