class ReviewModel {
  int id;
  int text;
  int time;
  double ratingStar;
  UserModel user;

  ReviewModel({
    this.id, this.text,
    this.time, this.ratingStar,
    this.user
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: int.parse(json["id"].toString()) ?? 0,
      text: json["review_text"] ?? "",
      time: json["review_time_friendly"] ?? "",
      ratingStar: double.parse(json["rating"].toString()) ?? 0,
      user: UserModel.fromJson(json["user"])
    );
  }
}

class UserModel {
  String name;
  String imageURL;

  UserModel({
    this.name, this.imageURL
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json["name"] ?? "",
      imageURL: json["profile_image"] ?? ""
    );
  }
}