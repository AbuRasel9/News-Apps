import 'dart:math';

import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:news_app/model/home_headline_model.dart';
import 'package:news_app/utils/static_value/source_id.dart';

class ApiClient {
  Future<HomeHeadlineModel> getHomeHeadline() async {
    try {
      //random source id generate hobe ja home screen refresh dile alada alada source id diye api call hobe
      final _random =  Random();

      var sourceID = SourceId.sourcesId[_random.nextInt(
        SourceId.sourcesId.length,
      )];

      Response response = await get(
        Uri.parse(
          "https://newsapi.org/v2/top-headlines?sources=$sourceID&apiKey=caea254bf2f94f869e831ec24284ece1",
        ),
      );
      Logger().i(
        "Url \n https://newsapi.org/v2/top-headlines?sources=$sourceID&apiKey=caea254bf2f94f869e831ec24284ece1}",
      );
      Logger().i(
        "Body \n${response.body}",
      );

      if (response.statusCode == 200) {
        return homeHeadlineModelFromJson(
          response.body,
        );
      } else {
        throw Exception(
          "Error ${response.body}",
        );
      }
    } catch (e) {
      Logger().e(
        "error \n$e",
      );
      throw Exception(
        "Api called Failed ${e.toString()}",
      );
    }
  }
}
