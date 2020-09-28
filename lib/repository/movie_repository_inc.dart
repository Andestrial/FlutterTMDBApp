import 'package:dio/dio.dart';
import 'package:flutter_web_screen/models/actor_response.dart';
import 'package:flutter_web_screen/models/movie_response.dart';
import 'package:flutter_web_screen/models/tv_response.dart';
import 'package:flutter_web_screen/sources/api_client.dart';
import 'package:flutter_web_screen/sources/api_client_impl.dart';

import 'movie_repository.dart';

class MovieRepositoryInc extends MovieRepository{
   ApiClient apiClient = ApiClientImp();
  @override
  Future<MovieResponse> getMovie(){
return apiClient.getMovie();
  }
  @override
  Future<TVResponse> getTv(){
    return apiClient.getTv();
  }
  @override
  Future<ActorResponse> getCredits(int id, String type){
    return apiClient.getCredits(id, type);
  }
  }
