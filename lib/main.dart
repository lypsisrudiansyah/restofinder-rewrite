import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_rw/core/viewmodels/collection_provider.dart';
import 'package:resto_rw/core/viewmodels/location_provider.dart';
import 'package:resto_rw/core/viewmodels/restaurant_provider.dart';
import 'package:resto_rw/injector.dart';
import 'package:resto_rw/ui/constant/constant.dart';
import 'package:resto_rw/ui/router/router.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => CollectionProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => RestaurantProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => LocationProvider(),
          ),
        ],
          child: MaterialApp(
        title: 'Resto Rewrite',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.orange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primaryColor: primaryColor,
          accentColor: primaryColor,
          cursorColor: primaryColor,
          fontFamily: 'NunitoSans',
          scaffoldBackgroundColor: Colors.white,
          pageTransitionsTheme: PageTransitionsTheme(
            builders: {
              TargetPlatform.android: SharedAxisPageTransitionsBuilder(
                transitionType: SharedAxisTransitionType.horizontal,
              ),
              TargetPlatform.iOS: SharedAxisPageTransitionsBuilder(
                transitionType: SharedAxisTransitionType.horizontal,
              ),
            }
          )
        ),
        initialRoute: RouterGenerator.routeHome,
        onGenerateRoute: RouterGenerator.generateRoute,
      ),
    );
  }
}
