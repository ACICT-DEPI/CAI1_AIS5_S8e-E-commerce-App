

import 'package:e_commerce/models/products.dart';
import 'package:e_commerce/screens/Detail/detail_screen.dart';
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
                showSearch(context: context, delegate: ProductSearchDelegate());
                print(query);
              },
              decoration: const InputDecoration(
                  hintText: "Search....", border: InputBorder.none),
            ),
          ),
         
        ],
      ),
    );
  }
}
class ProductSearchDelegate extends SearchDelegate<Product?> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final Set<Product> results = {
      ...all.where((product) =>
          product.title.toLowerCase().contains(query.toLowerCase())),
      ...shoes.where((product) =>
          product.title.toLowerCase().contains(query.toLowerCase())),
      ...beauty.where((product) =>
          product.title.toLowerCase().contains(query.toLowerCase())),
      ...womenFashion.where((product) =>
          product.title.toLowerCase().contains(query.toLowerCase())),
      ...jewelry.where((product) =>
          product.title.toLowerCase().contains(query.toLowerCase())),
      ...menFashion.where((product) =>
          product.title.toLowerCase().contains(query.toLowerCase())),
    };

    // Debugging logs
    print('Query: $query');
    print('Results: ${results.length}');
    for (var product in results) {
      print('Found Product: ${product.title}');
    }

    return results.isNotEmpty
        ? ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final product = results.elementAt(
            index); // Access the product using elementAt
        return ListTile(
          title: Text(product.title),
          subtitle: Text(product.seller),
          onTap: () {
            // Navigate to product details
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScreen(product: product),
              ),
            );
          },
        );
      },
    )
        : const Center(child: Text('No products found'));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final Set<Product> suggestions = {
      ...all.where((product) =>
          product.title.toLowerCase().contains(query.toLowerCase())),
      ...shoes.where((product) =>
          product.title.toLowerCase().contains(query.toLowerCase())),
      ...beauty.where((product) =>
          product.title.toLowerCase().contains(query.toLowerCase())),
      ...womenFashion.where((product) =>
          product.title.toLowerCase().contains(query.toLowerCase())),
      ...jewelry.where((product) =>
          product.title.toLowerCase().contains(query.toLowerCase())),
      ...menFashion.where((product) =>
          product.title.toLowerCase().contains(query.toLowerCase())),
    };

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final product = suggestions.elementAt(
            index); // Access the product using elementAt
        return ListTile(
          title: Text(product.title),
          onTap: () {
            query = product.title;
            showResults(context);
          },
        );
      },
    );
  }
}
