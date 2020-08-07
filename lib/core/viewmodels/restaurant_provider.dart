import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_rw/core/models/restaurant_model.dart';
import 'package:resto_rw/core/models/review_model.dart';
import 'package:resto_rw/core/services/restaurant/restaurant_services.dart';
import 'package:resto_rw/core/services/review/review_services.dart';
import 'package:resto_rw/core/viewmodels/location_provider.dart';
import 'package:resto_rw/ui/router/router.dart';

import '../../injector.dart';

// test: ada 3 tipe change notifier coba cari tahu apa bedanya yang dari material dan foundation
class RestaurantProvider extends ChangeNotifier {
  //* ----------------------------
  //* This is side for property data
  //* ----------------------------

  //* Restaurant list variable
  List<RestaurantModel> _restaurantList;
  List<RestaurantModel> get restaurantList => _restaurantList;

  //* Restaurant list by specific collection
  List<RestaurantModel> _restaurantByCollectionList;
  List<RestaurantModel> get restaurantByCollectionList =>
      _restaurantByCollectionList;

  //* Restaurant list by specific keyword
  List<RestaurantModel> _restaurantByKeywordList;
  List<RestaurantModel> get restaurantByKeywordList => _restaurantByKeywordList;

  //* Review list by restaurant
  List<ReviewModel> _reviewList;
  List<ReviewModel> get reviewList => _reviewList;

  //* To handle event search
  bool _onSearch = false;
  bool get onSearch => _onSearch;

  //* Depedency Injection
  RestaurantServices restaurantServices = locator<RestaurantServices>();
  ReviewServices reviewServices = locator<ReviewServices>();

  //* ------------------
  //* Function Field
  //* ------------------

  /// Function to get all restaurant by coordinate
  void getAll(BuildContext context) async {
    final locationProv = Provider.of<LocationProvider>(context, listen: false);
    _restaurantList = await restaurantServices.getAll(
        locationProv.latitude.toString(), locationProv.longitude.toString(),
        context);
    notifyListeners();
  }

  /// Function to search location
  void getAllByKeyword(String keyword, BuildContext context) async {
    
    //* Set search state to active
    setOnSearch(true);

    //* Clear previous history
    await clearRestaurantSearch();

    //* Then fetch new keyword
    final locationProv = Provider.of<LocationProvider>(context, listen: false);
    _restaurantByKeywordList = await restaurantServices.getAllByKeyword(
        keyword, locationProv.latitude.toString(),
        locationProv.longitude.toString(), context);

    //* Set search state to deactive
    setOnSearch(false);
    notifyListeners();
  }

  //* Function to get restaurant list by collection
  void getAllByCollection(String collectionID, BuildContext context) async {
    _restaurantByCollectionList =
        await restaurantServices.getAllByCollection(collectionID, context);
    notifyListeners();
  }

  //* Function to get review list by restaurant
  void getReviewsByRestaurant(String restaurantID, BuildContext context) async {
    _reviewList = await reviewServices.getAll(restaurantID, context);
    notifyListeners();
  }

  //* Function to handle onSearch state
  void setOnSearch(bool status) {
    _onSearch = status;
    notifyListeners();
  }

  //* Function to clear review
  void clearReview() {
    _reviewList = null;
    notifyListeners();
  }

  //* Function to clear restaurant list by collection
  void clearRestaurantByCollection() {
    _restaurantByCollectionList = null;
    notifyListeners();
  }

  //* Function to clear restaurant list by keyword / search
  void clearRestaurantSearch() {
    _restaurantByKeywordList = null;
    notifyListeners();
  }

  /// Function to navigate to search restaurant
  void goToSearchRestaurant(BuildContext context) async {
    await clearRestaurantSearch();
    Navigator.pushNamed(context, RouterGenerator.routeRestaurantSearch);
  }
}
