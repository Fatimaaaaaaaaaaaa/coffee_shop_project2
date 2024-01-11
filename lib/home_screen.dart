import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'home_bottom_bar.dart';
import 'items_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // String selectedCategory = ''; // Declare selectedCategory

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 15),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Icon(
                        Icons.sort_rounded,
                        color: Colors.white.withOpacity(0.5),
                        size: 35,
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Icon(
                        Icons.notifications,
                        color: Colors.white.withOpacity(0.5),
                        size: 35,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "It's a Great Day for Coffee",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              // TabBar(controller: _tabController,
              //     labelColor: Color(0xFFE57734),
              //     unselectedLabelColor: Colors.white.withOpacity(0.5),
              //     isScrollable: true,
              //     indicator: UnderlineTabIndicator(
              //       borderSide: BorderSide(
              //         width: 3,
              //         color:  Color(0xFFE57734),
              //       ),
              //       insets: EdgeInsets.symmetric(horizontal: 10),
              //     ),
              //     labelStyle:  TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              //     labelPadding: EdgeInsets.symmetric(horizontal: 10),
              //     tabs: const [
              //   Tab(text: "Hot Coffee",),
              //   Tab(text: "Cold Coffee",),
              //   Tab(text: "Cappuiccino",),
              //   Tab(text: "Americano",),
              // ], onTap: (index) {
              //     // Pass the selected category to the ItemsWidget
              //     setState(() {
              //       // selectedCategory = category[index];
              //     });
              //   },),
              SizedBox(
                height: 5,
              ),
              // Pass selected category to ItemsWidget
              ItemsWidget(),
              SizedBox(
                height: 5,
              ),
              // Center(
              //   child: [
              //     ItemsWidget(),
              //     ItemsWidget(),
              //     ItemsWidget(),
              //     ItemsWidget(),
              //
              //   ][_tabController.index],
              // ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: HomeBottomBar(),
    );
  }
}

// void searchItemByName(Function(String text) update, String name) async {
//   try {
//     final url = Uri.https('https://bongminminbong.000webhostapp.com', 'search.php', {'Name':'$name'});
//     final response = await http.get(url)
//         .timeout(const Duration(seconds: 5));
//     _items.clear();
//     if (response.statusCode == 200) {
//       final jsonResponse = convert.jsonDecode(response.body);
//       var row = jsonResponse[0];
//       ItemsWidget item = ItemsWidget(
//
//           row['name'],
//           int.parse(row['quantity']),
//           double.parse(row['price']),
//           row['category']);
//       _items.add(item);
//       update(item.toString());
//     }
//   }
//   catch(e) {
//     update("can't load data");
//   }
// }
