import 'package:flutter_web_screen/models/actor_model.dart';

class ActorResponse {
  List<ActorModel> casts;
  String error;

  ActorResponse(this.casts, this.error);

  ActorResponse.fromJson(Map<String, dynamic> json)
      : casts =
            (json['cast'] as List).map((e) => ActorModel.fromJson(e)).toList(),
        error = '';

  ActorResponse.withError(String error)
      : casts = new List(),
        error = error;
}
