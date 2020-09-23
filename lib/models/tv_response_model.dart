import 'package:flutter_web_screen/models/discover_movie_model.dart';
import 'package:flutter_web_screen/models/discover_tv_model.dart';

class TVResponse {
  List<TVModel> result;
  String error;


  TVResponse(this.result, this.error);

  TVResponse.fromJson(Map<String , dynamic>json)
      : result = (json['results'] as List).map((e) => TVModel.fromJson(e)).toList(),
        error = "";


  TVResponse.withError(String error)
      : result = new List(),
        error = error;
}
