import 'package:coffee_shop/favorite_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'cart.dart';
// import 'package:flutter/favorite_page.dart';


class SingleScreenItem extends StatefulWidget {

  final Map<String, dynamic> item;
  const SingleScreenItem({required this.item});

  @override
  State<SingleScreenItem> createState() => _SingleScreenItemState();
}

class _SingleScreenItemState extends State<SingleScreenItem> {
  bool _load = false;

  void update(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
    setState(() {
      _load = false;
    });
  }

  int quantityCount = 1;
  double itemPrice = 30.20;

  void decrementQuantity() {
    setState(() {
      if (quantityCount > 1) {
        quantityCount--;
        updatePrice();
      }
    });
  }

  void incrementQuantity() {
    setState(() {
      quantityCount++;
      updatePrice();
    });
  }

  void updatePrice() {
    itemPrice = 30.20 * quantityCount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 25),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
              ),
              SizedBox(height: 50,),
              Center(
                child: Image.asset(
                  "assets/images/Latte.png",
                  width: MediaQuery.of(context).size.width / 1.2,
                ),
              ),
              SizedBox(height: 50,),
              Padding(
                padding: EdgeInsets.only(left: 25, right: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Best Coffee',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.4),
                        letterSpacing: 3,
                      ),
                    ),
                    SizedBox(height: 10,),
                    SizedBox(height: 20,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(0),
                            width: 160,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white.withOpacity(0.2),
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    CupertinoIcons.minus,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                  onPressed: decrementQuantity,
                                ),
                                SizedBox(width: 10,),
                                Text(
                                  '$quantityCount',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 15,),
                                IconButton(
                                  icon: Icon(
                                    CupertinoIcons.plus,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                  onPressed: incrementQuantity,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '\$$itemPrice',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text(
                      'Coffee is a major source of antioxidants in the diet. It has many health benefits',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withOpacity(0.4),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        Text(
                          'Volume: ',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 10,),
                        Text(
                          '60ml ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 60,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 50, 54, 56),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: TextButton(
                              onPressed: () {

                                saveCart(
                                  context,
                                  update,
                                  int.parse(widget.item['item_id']),
                                  widget.item['name'],
                                  itemPrice,
                                );
                              },
                              child: Text(
                                "Add to Cart",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Color(0xFFE57734),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.favorite_outline,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                saveFav(
                                  context,
                                  update,
                                  int.parse(widget.item['item_id']),
                                  widget.item['name'],

                                );
                                // Call the function to add to favorites
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void saveCart(BuildContext context, Function(String) update, int item_id, String name, double price) async {
  try {
    final response = await http.post(
      Uri.parse('https://bongminminbong.000webhostapp.com/cartt.php'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: convert.jsonEncode(<String, dynamic>{
        'item_id': '$item_id',
        'name': '$name',
        'price': '$price',
        'quantity': '1', // Assuming quantity is fixed or you can choose it dynamically
      }),
    ).timeout(const Duration(seconds: 5));
    if (response.statusCode == 200) {
      update(response.body);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ShowCart()),
      );

    }
  } catch (e) {
    update(e.toString());
  }
}
void saveFav(BuildContext context, Function(String) update, int item_id, String name) async {
  try {
    final response = await http.post(
      Uri.parse('https://bongminminbong.000webhostapp.com/favorite.php'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: convert.jsonEncode(<String, dynamic>{
        'item_id': '$item_id',
        'name': '$name',

      }),
    ).timeout(const Duration(seconds: 5));
    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ShowFav()),
      );

    }
  } catch (e) {
    update(e.toString());
  }
}
