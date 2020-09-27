import 'package:flutter_web_screen/models/actor_response.dart';
import 'package:flutter_web_screen/repository/movie_repository.dart';
import 'package:rxdart/rxdart.dart';

class ActorsBloc {
  final MovieRepository repository = MovieRepository();
  BehaviorSubject<ActorResponse> _subject = BehaviorSubject<ActorResponse>();

  getCredits(int id , String type)async{
    try {
      final actors = await repository.getCredits(id, type);
      print(actors);
      _subject.sink.add(actors);
    }
    catch(e)
    {
      print('$e');
    }
  }

  BehaviorSubject<ActorResponse> get subject => _subject;

  dispose(){
    _subject.close();
  }

}
final actorsBloc = ActorsBloc();