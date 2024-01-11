import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;


final List<String> _carts = [];
const String _baseURL = 'bongminminbong.000webhostapp.com';
class ShowFav extends StatefulWidget {
  const ShowFav({super.key});

  @override
  State<ShowFav> createState() => _ShowFavState();
}

class _ShowFavState extends State<ShowFav> {
  bool _load = false;
  void update(bool success){
    setState(() {
      _load = true;
      if(!success){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('failed to load data')));

      }
    });
  }
  @override
  void initState(){
    updateFav(update);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Favorite',),
          backgroundColor:  Color.fromARGB(255, 50, 54, 55),
          centerTitle: true,
        ),
        body: _load ? const ListCart() : const Center(
            child: SizedBox(width: 100, height: 100, child: CircularProgressIndicator())
        )
    );
  }
}


class ListCart extends StatelessWidget {
  const ListCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemCount: _carts.length,
      itemBuilder: (context, index) => Column(children: [
        const SizedBox(height: 10,),
        Row(mainAxisAlignment:  MainAxisAlignment.center, children: [
          Flexible(child: Text(_carts[index], style: TextStyle(fontSize: 18, color: Colors.white
          ),)),

        ],)
      ],),
    );
  }
}
void updateFav(Function(bool success) update) async{
  try{
    final url = Uri.https(_baseURL, 'getFavInfo.php');
    final response = await http.get(url)
        .timeout(const Duration(seconds: 5)); // max timeout 5 seconds
    _carts.clear(); // clear old products
    if (response.statusCode == 200) { // if successful call
      final jsonResponse = convert.jsonDecode(response.body); // create dart json object from json array
      for (var row in jsonResponse) { // iterate over all rows in the json array
        _carts.add('name: ${row['name']} ');
      }
      update(true);
    }}
  catch(e){
    update(false);
  }
}