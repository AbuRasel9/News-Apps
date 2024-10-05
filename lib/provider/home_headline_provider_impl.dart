part of 'home_headline_provider.dart';
class HomeHeadlineProviderImpl extends HomeHeadlineProvider{
  @override
  Future<HomeHeadlineModel> getListHomeHeadlineArticle() async {
    final HomeHeadlineModel result=await ApiClient().getHomeHeadline();
    _homeHeadlineArticleList=result.articles ?? [];
    notifyListeners();
    return result;
    


  }

  @override
  void setLoading({required bool loading}) {
    _isLoading=loading;
    notifyListeners();
  }

}