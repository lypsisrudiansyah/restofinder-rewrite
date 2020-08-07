import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:resto_rw/core/models/collection_model.dart';
import 'package:resto_rw/core/viewmodels/restaurant_provider.dart';
import 'package:resto_rw/ui/screens/widgets/restaurant_item.dart';

class RestaurantByCollectionScreen extends StatelessWidget {
  CollectionModel collection;
  RestaurantByCollectionScreen({
    this.collection
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    // print(collection.);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // test : apa bedanya dengan brightness yang lain
        brightness: Brightness.light,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          collection.title,
          style: TextStyle(fontWeight: FontWeight.w700),
        ),       
      ),
      body: RestaurantByCollectionBody(collection: collection),
    );
  }
}

class RestaurantByCollectionBody extends StatelessWidget {
  CollectionModel collection;
  RestaurantByCollectionBody({
    @required this.collection
  });
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10),
            _restaurantList(),
          ],
        )
      ),
    );
  }

  Widget _restaurantList() {
    return Builder(
      builder: (context) {
        return Consumer<RestaurantProvider>(
          builder: (context, restaurantProv, _) {

            //* If collection data null than fetch
            if (restaurantProv.restaurantByCollectionList == null) {
              restaurantProv.getAllByCollection(collection.id.toString(), context);
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            //* If collection is not found
            if (restaurantProv.restaurantByCollectionList.length == 0) {
              return Center(
                child: Text(
                  "Restoran tidak ditemukan"
                ),
              );
            }

            return ListView.builder(
              //* test: apa ini shrinkWrap
              shrinkWrap: true,
              itemCount: restaurantProv.restaurantByCollectionList.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                var restaurant = restaurantProv.restaurantByCollectionList[index];
                return RestaurantItem(
                  restaurant: restaurant
                );
              },
            );
          },
        );
      },
    );
  }
}