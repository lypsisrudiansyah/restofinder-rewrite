
class RestaurantModel {
  int id;
  String name;
  String imageURL;
  String cuisines;
  double ratingStar;
  int review;
  int priceForTwo;
  String address;
  String addressFull;
  String openTime;
  String currency;
  List<String> highlights;

  RestaurantModel({
    this.id, this.name,
    this.imageURL, this.cuisines,
    this.ratingStar, this.review,
    this.priceForTwo, this.address,
    this.addressFull, this.openTime,
    this.highlights, this.currency,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    
    //* Initialize highlight list value
    var _highlights = new List<String>();
    json["highlights"].forEach((val) {
      _highlights.add(val);
    });
    
    return RestaurantModel(
      id: int.parse(json["id"].toString()) ?? 0,
      name: json["name"] ?? "",
      imageURL: json["featured_image"] ?? "",
      cuisines: json["cuisines"] ?? "",
      ratingStar: double.parse(json["user_rating"]["aggregate_rating"].toString()) ?? 0,
      review: int.parse(json["user_rating"]["votes"].toString()) ?? 0,
      priceForTwo: int.parse(json["average_cost_for_two"].toString()) ?? 0,
      address: json["location"]["locality_verbose"] ?? "",
      addressFull: json["location"]["address"] ?? "",
      openTime: json["timings"] ?? "",
      highlights: _highlights,
      currency: json["currency"] ?? "",
    );
  }
}