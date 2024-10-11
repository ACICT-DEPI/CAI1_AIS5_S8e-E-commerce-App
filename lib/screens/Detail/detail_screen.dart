
import 'package:e_commerce/models/products.dart';
import 'package:e_commerce/provider/product_viewed_provider.dart';
import 'package:e_commerce/screens/Detail/widget/addto_cart.dart';
import 'package:e_commerce/screens/Detail/widget/description.dart';
import 'package:e_commerce/screens/Detail/widget/detail_appbar.dart';
import 'package:e_commerce/screens/Detail/widget/image_slider.dart';
import 'package:e_commerce/screens/Detail/widget/itemdetails.dart';
import 'package:e_commerce/screens/constans.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class DetailScreen extends StatefulWidget {
  final Product product;
  const DetailScreen({super.key, required this.product});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int currentImage = 0;
  int currentColor = 0; // Default to the first color
 @override
  void initState() {
    super.initState();

    // Add the product to the viewed products list in initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ViewedProductsProvider>(context, listen: false)
          .addProduct(widget.product);
    });
  }
  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AddToCart(product: widget.product),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              DetailAppBar(product: widget.product),
              // Use MyImageSlider to display the product image
              MyImageSlider(
                onChange: (index) {
                  setState(() {
                    currentImage = index;
                  });
                },
                image: widget.product.image,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5, // Only one image, so just create one dot
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: currentImage == index ? 15 : 8,
                    height: 8,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: currentImage == index ? kprimaryColor: Colors.transparent,
                      border: Border.all(color: kprimaryColor),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40),
                  ),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Display product details like name, price, rating, and seller
                    ItemDetails(product: widget.product),
                    const SizedBox(height: 20),
                    const Text(
                      "Colors",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: List.generate(
                        widget.product.colors.length,
                        (index) => GestureDetector(
                          onTap: () {
                            setState(() {
                              currentColor = index;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currentColor == index ? Colors.white : widget.product.colors[index],
                              border: currentColor == index ? Border.all(color: widget.product.colors[index]) : null,
                            ),
                            margin: const EdgeInsets.only(right: 10),
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: widget.product.colors[index],
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Display product description
                    Description(description: widget.product.description),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
