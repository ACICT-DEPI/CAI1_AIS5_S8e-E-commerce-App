import 'package:e_commerce/provider/product_viewed_provider.dart';
import 'package:e_commerce/screens/Detail/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


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
                      leading: Image.asset(
                        product.image,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
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