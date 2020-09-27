import 'package:flutter_web_screen/models/tv_response.dart';
import 'package:flutter_web_screen/repository/movie_repository.dart';
import 'package:rxdart/rxdart.dart';

class TVBloc {
  final MovieRepository repository = MovieRepository();
  BehaviorSubject<TVResponse> _subject = BehaviorSubject<TVResponse>();

  getTv() async{
    final tvs = await repository.getTv();
    _subject.add(tvs);
  }

  BehaviorSubject<TVResponse> get subject => _subject;

  void dispose(){
    _subject.close();
  }
}
final tvBloc = TVBloc();
