class MovieModel {
  int id;
  String title;
  double votes;
  String overview;
  String poster;

  MovieModel(this.id, this.title, this.overview, this.poster, this.votes);

    MovieModel.fromJson(Map<String , dynamic>json)
      : id = json['id'],
        title = json['title'],
        votes = double.parse(json['vote_average'].toString()),
        overview = json['overview'],
        poster = json['poster_path'];

}