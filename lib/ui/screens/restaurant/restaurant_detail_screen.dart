import 'package:flutter/material.dart';
import 'package:resto_rw/core/models/restaurant_model.dart';
import 'package:resto_rw/ui/screens/widgets/custom_rating.dart';

class RestaurantDetailScreen extends StatelessWidget {
  RestaurantModel restaurant;
  RestaurantDetailScreen({
    this.restaurant
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RestaurantDetailBody(
        restaurant: restaurant
      ),
    );
  }
}

class RestaurantDetailBody extends StatefulWidget {
  RestaurantModel restaurant;
  RestaurantDetailBody({
    @required this.restaurant
  });
  @override
  _RestaurantDetailBodyState createState() => _RestaurantDetailBodyState();
}

class _RestaurantDetailBodyState extends State<RestaurantDetailBody> {
  Color iconBackColor = Colors.white;
  Color textColor = Colors.white;
  Color backgroundColor = Colors.transparent;

  ScrollController scrollController;
  _scrollListener() {
    if (scrollController.offset >= 100) {
      setState(() {
        iconBackColor = Colors.black87;
        textColor = Colors.black87;
        backgroundColor = Colors.white;
      });
    } else {
      setState(() {
        iconBackColor = Colors.white;
        textColor = Colors.white;
        backgroundColor = Colors.transparent;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController = new ScrollController();
    scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          controller: scrollController,
          child: _content(),
        ),
        _appBar(),
      ],
    );
  }

  Widget _appBar() {
    return Builder(
      builder: (context) {
        return Column(
          children: <Widget>[
            Container(
              height: 24,
              color: backgroundColor,
            ),
            Container(
              height: 50,
              color: backgroundColor,
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: iconBackColor),
                    onPressed: () => Navigator.pop(context),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      widget.restaurant.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 16
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        );
      },
    );
  }

  Widget _content() {
    return Container(
      child: Column(
        children: <Widget>[
          _imageCover(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 5),
                CustomRating(
                  rating: widget.restaurant.ratingStar,
                  review: widget.restaurant.review,
                ),
                _title(),
                SizedBox(height: 5),
               /*  _cuisines(),
                SizedBox(height: 5),
                _address(),
                SizedBox(height: 5),
                _price(), */
                
                Divider(color: Colors.black12)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _title() {
    return Text(
      widget.restaurant.name,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
        fontSize: 18
      ),
    );
  }

  Widget _imageCover() {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        color: Colors.grey,
        image: DecorationImage(
          image: NetworkImage(widget.restaurant.imageURL),
          fit: BoxFit.cover
        )
      ),
    );
  }
}