class ActorModel {
  int id;
  String name;
  String image;
  String role;

  ActorModel(this.id, this.name, this.image, this.role);

  ActorModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        image = ('https://image.tmdb.org/t/p/w185/' +
                json['profile_path'].toString()),
        role = json['character'];
}
