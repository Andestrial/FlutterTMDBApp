import 'package:dio/dio.dart';
import 'package:flutter_web_screen/models/actor_response.dart';
import 'package:flutter_web_screen/models/movie_response.dart';
import 'package:flutter_web_screen/models/tv_response.dart';

class MovieRepository{
  final String apiKey = '10d39203e458fc0a8dec50a358c99540';
  static String baseUrl = 'https://api.themoviedb.org/3';
  final Dio dio = Dio();

  String getMovieUrl = '$baseUrl/discover/movie';
  String getTvUrl = '$baseUrl/discover/tv';
  String getCreditsUrl = '$baseUrl';

  Future<MovieResponse> getMovie() async{
    var params = {
      'api_key' : apiKey,
      'language' : 'en-US',
      'page' : 1,
      'sort_by' : 'popularity.desc',
    };
    try{
      Response response = await dio.get(getMovieUrl, queryParameters: params);
        return MovieResponse.fromJson(response.data);
    }
    catch(e){
      print(e);
      return MovieResponse.withError('$e');
    }
  }
  Future<TVResponse> getTv() async{
    var params = {
      'api_key' : apiKey,
      'language' : 'en-US',
      'page' : 1,
    };
    try{
      Response response = await dio.get(getTvUrl, queryParameters: params);
      return TVResponse.fromJson(response.data);
    }
    catch(e){
      print(e);
      return TVResponse.withError('$e');
    }
  }
  Future<ActorResponse> getCredits (int id, String type)async{
    var params = {
      'api_key' : apiKey,
    };
    try{
      Response response = await dio.get("$getCreditsUrl/$type/$id/credits", queryParameters: params);
      print(response.data['cast']);
      return ActorResponse.fromJson(response.data);
    }
    catch(e){
      return ActorResponse.withError(e.toString());
    }
  }
}