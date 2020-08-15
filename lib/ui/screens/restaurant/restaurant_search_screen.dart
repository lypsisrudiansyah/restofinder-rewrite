import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:resto_rw/core/viewmodels/restaurant_provider.dart';
import 'package:resto_rw/ui/constant/constant.dart';
import 'package:resto_rw/ui/screens/widgets/restaurant_mini_item.dart';
import 'package:resto_rw/ui/screens/widgets/search_item.dart';

class RestaurantSearchScreen extends StatefulWidget {
  @override
  _RestaurantSearchScreenState createState() => _RestaurantSearchScreenState();
}

class _RestaurantSearchScreenState extends State<RestaurantSearchScreen> {
  var searchController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent
    ));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black54),
          onPressed: () => Navigator.pop(context),
        ),
        title: _appBar(),
      ),
      body: RestaurantSearchBody(),
    );
  }

  Widget _appBar() {
    return Builder(
      builder: (context) {
        return Consumer<RestaurantProvider>(
          builder: (context, restaurantProv, _) {
            return SearchItem(
              controller: searchController,
              autoFocus: true,
              onSubmit: (value) => restaurantProv.getAllByKeyword(value, context),
            );
          },
        );
      },
    );
  }
}

class RestaurantSearchBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _restaurantCount(),
            _restaurantList()
          ],
        ),
      ),
    );
  }

  Widget _restaurantCount() {
    return Builder(
      builder: (context) {
        return Consumer<RestaurantProvider>(
          builder: (context, restaurantProv, _) {
            
            //* If restaurantsByKeywordList is null than return SizedBox
            if (restaurantProv.restaurantByKeywordList == null) {
              return SizedBox();
            }

            return Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.location_on, color: primaryColor),
                    SizedBox(width: 10),
                    Text(
                      "${restaurantProv.restaurantByKeywordList.length.toString()} restoran ditemukan",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 15
                      ),
                    )
                  ],
                ),

                Divider(color: Colors.black12)
              ],
            );
          },
        );
      },
    );
  }

  Widget _restaurantList() {
    return Builder(
      builder: (context) {
        return Consumer<RestaurantProvider>(
          builder: (context, restaurantProv, _) {
            
            //* If restaurants data null and onSearch status == false than fetch
            if (restaurantProv.restaurantByKeywordList == null && restaurantProv.onSearch == false) {
              return Center(
                child: Text(
                  "Mau cari restauran apa ?"
                ),
              );
            }
            // checkpoint

            //* If restaurant onSearch status == true
            if (restaurantProv.onSearch) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            //* If restaurants data is not found
            if (restaurantProv.restaurantByKeywordList.length == 0) {
              return Center(
                child: Text(
                  "Restoran tidak ditemukan"
                ),
              );
            }

            //* Return list of search restaurant results
            return ListView.builder(
              shrinkWrap: true,
              itemCount: restaurantProv.restaurantByKeywordList.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                var restaurant = restaurantProv.restaurantByKeywordList[index];
                return RestaurantMiniItem(restaurant: restaurant);
              },
            );
          },
        );
      },
    );
  }
}