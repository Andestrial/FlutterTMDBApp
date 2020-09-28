import 'package:flutter_web_screen/models/actor_response.dart';
import 'package:flutter_web_screen/models/movie_response.dart';
import 'package:flutter_web_screen/models/tv_response.dart';

abstract class ApiClient {
  Future<MovieResponse> getMovie();
  Future<TVResponse> getTv();
  Future<ActorResponse> getCredits(int id, String type);
  }
