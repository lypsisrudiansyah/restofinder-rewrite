import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:resto_rw/core/models/collection_model.dart';
import 'package:resto_rw/core/services/collection/collection_services.dart';
import 'package:resto_rw/core/viewmodels/location_provider.dart';
import 'package:resto_rw/core/viewmodels/restaurant_provider.dart';
import 'package:resto_rw/injector.dart';
import 'package:resto_rw/ui/router/router.dart';

class CollectionProvider extends ChangeNotifier {
  //* ------------------------------
  //* This is side of property data
  //* ------------------------------

  //* Collection lit variable
  List<CollectionModel> _collectionList;
  List<CollectionModel> get collectionList => _collectionList;

  //* Depedency Injection
  CollectionServices collectionServices = locator<CollectionServices>();

  //* ------------------
  //* Function Field
  //* ------------------

  /// Function to get all collection in jakarta
  void getAll(BuildContext context) async {
    final locationProv = Provider.of<LocationProvider>(context, listen: false);
    _collectionList = await collectionServices.getAll(
      locationProv.latitude.toString(), locationProv.longitude.toString(),
      context
    );
    notifyListeners();
  }

  /// Function to navigate to restaurant by collection
  void goToRestaurantList(CollectionModel collection, BuildContext context) async {
    //* test: kenapa listennya false, coba cari pengimplementasian yang true
    await Provider.of<RestaurantProvider>(context, listen: false).clearRestaurantByCollection();
    Navigator.pushNamed(context, RouterGenerator.routeRestaurantByCollection, arguments: collection);
  }
}