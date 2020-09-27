class TVModel {
  int id;
  String name;
  double votes;
  String overview;
  String poster;

  TVModel(this.id, this.name, this.overview, this.poster, this.votes);

  TVModel.fromJson(Map<String , dynamic>json)
      : id = json['id'],
        name = json['name'],
        votes = double.parse(json['vote_average'].toString()),
        overview = json['overview'],
        poster = 'https://image.tmdb.org/t/p/w500/'+ json['poster_path'];

}