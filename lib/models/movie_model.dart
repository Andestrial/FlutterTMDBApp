class MovieModel {
  int id;
  String name;
  double votes;
  String overview;
  String poster;

  MovieModel(this.id, this.name, this.overview, this.poster, this.votes);

    MovieModel.fromJson(Map<String , dynamic>json)
      : id = json['id'],
        name = json['title'],
        votes = double.parse(json['vote_average'].toString()),
        overview = json['overview'],
        poster = 'https://image.tmdb.org/t/p/w500/' + json['poster_path'];

}