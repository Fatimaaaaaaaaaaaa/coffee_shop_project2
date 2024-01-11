import 'dart:convert';
import 'package:coffee_shop/single_item_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
class ItemsWidget extends StatefulWidget {
  @override
  _ItemsWidgetState createState() => _ItemsWidgetState();
}

class _ItemsWidgetState extends State<ItemsWidget> {
  List<Map<String, dynamic>> items = [];

  @override
  void initState() {
    super.initState();
    _fetchItems();
  }

  void search(String query) {
    setState(() {
      items = items
          .where((item) => item['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }



  Future<void> _fetchItems() async {
    final response = await http.get(Uri.parse('https://bongminminbong.000webhostapp.com/selectItems.php'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      setState(() {
        items = List<Map<String, dynamic>>.from(jsonResponse);
      });
    } else {
      // Handle errors
      print('Failed to fetch items: ${response.statusCode}');
    }
  }
  TextEditingController _searchController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          width: MediaQuery.of(context).size.width,
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 50, 54, 56),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextFormField(
            controller: _searchController,
            onChanged: (value) {
              if(value==''||value.isEmpty){
                items.clear();
                _fetchItems();
              }
              else{

                search(value);
              }
            },
            decoration: InputDecoration(
              hintText: "Find your coffee",
              hintStyle: TextStyle(
                color: Colors.white.withOpacity(0.5),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.search,
                  size: 30,
                  color: Colors.white.withOpacity(0.5),
                ),
                onPressed: () {
                  // Perform search when IconButton is pressed
                },
              ),
            ),
          ),
        ),

        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 150 / 195,
          ),
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 13),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xFF212325),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    spreadRadius: 1,
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Column(
                children: [
                  InkWell(
                  onTap: () {
                         Navigator.push(
                          context,
                           MaterialPageRoute(
                           builder: (context) => SingleScreenItem( item: items [index] ),
                       ),
                         );
                   },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Image.asset(
                        "assets/images/Latte.png",
                        width: 120,
                        height: 120,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            items[index]['name'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            items[index]['category'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\$${items[index]['price']}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Color(0xFFE57734),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            CupertinoIcons.add,
                            size: 15,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
