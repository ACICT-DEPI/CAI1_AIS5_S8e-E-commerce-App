import 'package:e_commerce/provider/product_viewed_provider.dart';
import 'package:e_commerce/screens/Detail/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dart:convert'; // Ensure to import for base64 decoding
import 'dart:io'; // Import for File handling

class ViewedProductsScreen extends StatelessWidget {
  const ViewedProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Viewed Products'),
      ),
      body: Consumer<ViewedProductsProvider>(
        builder: (ctx, viewedProductsProvider, _) {
          final viewedProducts = viewedProductsProvider.viewedProducts;

          return viewedProducts.isEmpty
              ? const Center(child: Text('No products viewed yet.'))
              : ListView.builder(
                  itemCount: viewedProducts.length,
                  itemBuilder: (ctx, index) {
                    final product = viewedProducts[index];

                    return ListTile(
                      leading: (() {
                        // Logic to load images dynamically
                        try {
                          final decodedImage = base64Decode(product.image);
                          return Image.memory(
                            decodedImage,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          );
                        } catch (e) {
                          // If base64 decoding fails, try to load as a file or asset
                          if (File(product.image).existsSync()) {
                            return Image.file(
                              File(product.image),
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            );
                          } else {
                            return Image.asset(
                              product.image,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.error); // Display an error icon or placeholder
                              },
                            );
                          }
                        }
                      })(),
                      title: Text(product.title),
                      subtitle: Text('Price: \$${product.price}'),
                      onTap: () {
                        // Navigate to the ProductDetailScreen when tapped
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(product: product),
                          ),
                        );
                      },
                    );
                  },
                );
        },
      ),
    );
  }
}
