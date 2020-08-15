class Api {
  //* Creating intance contructor
  static Api instance = Api();
  //* Base API url
  static const baseURL = "https://developers.zomato.com/api/v2.1";

  //* ---------------
  //* ENDPOINT FIELD
  //* ---------------

  //* Collection Endpoint
  //* Please replace %latitude% and %longitude%
  //* with your location coordinate
  String getCollections = "$baseURL/collections?lat=%latitude%&lon=%longitude%&city_id=74";
  
  //* Retaurant Endpoint
  //* Please replace %latitude% and %longitude%
  //* with your location coordinate
  //* radius = 20000m = 20km
  String getRestaurant = "$baseURL/search?lat=%latitude%&lon=%longitude%&radius=20000";

  //* Search Restaurant Endpoint
  //* q = keyword to search and please replace your %keyword%
  //* with your keyword
  //* Please replace %latitude% and %longitude%
  //* with your location coordinate
  //* radius = 20000m = 20km
  String searchRestaurantByKeyword = "$baseURL/search?q=%keyword%&lat=%latitude%&lon=%longitude%&radius=20000";
  
  //* Find Restaurant by collection id Endpoint
  //* Please replace %collection_id%
  //* with your collection
  String getRestauranByCollection = "$baseURL/search?collection_id=%collection_id%";
  
  //* Review Endpoint
  //* Please replace %res_id% with your restaurant_id
  //* Count = 20 adalah jumlah maksimal data untuk diambil
  String getReview = "$baseURL/reviews?res_id=%res_id%&start=0&count=20";

  
}