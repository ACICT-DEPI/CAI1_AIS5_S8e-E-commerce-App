import 'package:e_commerce/screens/constans.dart';
import 'package:flutter/material.dart';

class MySearchBar extends StatelessWidget {
  const MySearchBar({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 55,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), ),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: Row(
        children: [
          const Icon(
            Icons.search,
            color: kprimaryColor,
            size: 30,
          ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            flex: 4,
            child: TextField(
              onChanged: (query) {
                showSearch(context: context, delegate: CustomerSearch());
                print(query);
              },
              decoration: const InputDecoration(
                  hintText: "Search....", border: InputBorder.none),
            ),
          ),
          const SizedBox(
            height: 25,
            width: 1.5,
            
          ),
          
        ],
      ),
    );
  
  }
}
class CustomerSearch extends SearchDelegate{


  List username= [
    "Air Jordan",
    "Vans Old Skool",
    "Women-Shoes",
    "Sports Shoes",
    "White Sneaker",
    "Face Care Product",
    "Super Perfume",
    "Skin-Care Product",
    "Women Kurta",
    "T-shirt",
    "Pants",
    "Earrings",
    "Jewelry-Box",
    "Wedding Ring",
    "Necklace-Jewellery",
    "Man Jacket",
    "Men Pants",
    "Men Shirt",
    "T-Shirt",
    "Watch",
    "Smart Watch",
    "Mens Jacket",
    "Wireless Headphones",
    "Woman Sweater",
  ];

  List? filterList;



  @override
  List<Widget>? buildActions(BuildContext context) {
    return[
      IconButton(onPressed: () {
        query="";
      }, icon: const Icon(Icons.close))

    ];

  }

  @override
  Widget? buildLeading(BuildContext context) {
    return
      IconButton(onPressed: () {
        close(context, null);
      }, icon: const Icon(Icons.arrow_back));



  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text("");

  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if(query=="") {
      return ListView.builder(
          itemCount: username.length,
          itemBuilder: (context,i){

            return Card(child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text("${username[i]}" , style: const TextStyle(fontSize: 16), ),
            ));
          });

    }else{
      filterList=username.where((element)=> element.contains(query)).toList();
      return ListView.builder(
        itemCount: filterList!.length,
        itemBuilder: (context,i){

          return Card(child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text("${filterList![i]}" , style: const TextStyle(fontSize: 16), ),
          ));
        });
    }

  }

}
