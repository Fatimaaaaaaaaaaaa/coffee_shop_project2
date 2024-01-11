import 'package:coffee_shop/cart.dart';
import 'package:flutter/material.dart';
import 'admin_login.dart';
import 'favorite_page.dart'; // Import your FavoritePage file
// import 'cart_page.dart'; // Import your CartPage file

class HomeBottomBar extends StatelessWidget {
  const HomeBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      height: 80,
      decoration: BoxDecoration(
        color: Color(0xFF212325),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              // Navigate to the home page or do nothing since you're already there
            },
            icon: Icon(
              Icons.home,
              color: Color(0xFFE57734),
              size: 35,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ShowFav()),
              );
            },
            icon: Icon(
              Icons.favorite_outline,
              color: Color(0xFFE57734),
              size: 35,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                MaterialPageRoute(builder: (context) => ShowCart()),
              );
            },
            icon: Icon(
              Icons.notifications,
              color: Color(0xFFE57734),
              size: 35,
            ),
          ),
          IconButton(
             onPressed: () {

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
            },
            icon: Icon(
              Icons.person,
              color: Color(0xFFE57734),
              size: 35,
            ),
          ),
        ],
      ),
    );
  }
}