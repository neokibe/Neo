import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import './views/addMember.dart';
import './views/memberDetails.dart';
import './views/homeView.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/' :
        return  MaterialPageRoute(
          builder: (_)=> HomeView()
        );
      case '/addProduct' :
        return MaterialPageRoute(
          builder: (_)=> AddProduct()
        ) ;
      case '/productDetails' :
        return MaterialPageRoute(
            builder: (_)=> ProductDetails()
        ) ;
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            ));
    }
  }
}