import 'package:e_commerce/models/products.dart';
import 'package:e_commerce/provider/product_viewed_provider.dart';
import 'package:e_commerce/screens/Detail/widget/addto_cart.dart';
import 'package:e_commerce/screens/Detail/widget/description.dart';
import 'package:e_commerce/screens/Detail/widget/detail_appbar.dart';
import 'package:e_commerce/screens/Detail/widget/image_slider.dart';
import 'package:e_commerce/screens/Detail/widget/itemdetails.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

  class DetailScreen extends StatefulWidget {
    final Product product;
    const DetailScreen({super.key, required this.product});

    @override
    State<DetailScreen> createState() => _DetailScreenState();
  }

class _DetailScreenState extends State<DetailScreen> {
  int currentimage = 0;
  int currentColor = 1;
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

      //for add to Cart ,icon and quantity
      floatingActionButton: AddToCart(product: widget.product),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              // for back button share and favorite,
               DetailAppBar(product: widget.product,),
              //for detai·image slider .
              MyImageSlider(
                  onChange: (index) {
                    setState(() {
                      currentimage = index;
                    });
                  },
                  image: widget.product.image),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                  (index) => AnimatedContainer(
                    duration: const Duration(microseconds: 300),
                    width: currentimage == index ? 15 : 8,
                    height: 8,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: currentimage == index
                          ? Colors.black
                          : Colors.transparent,
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // for product detail
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      topLeft: Radius.circular(40),
                    )),
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 20,
                  bottom: 100,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //fir product name ,price ,rating ,and seller
                    ItemDetails(product: widget.product),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Colors",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
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
                            duration: const Duration(
                              milliseconds: 300,
                            ),
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: currentColor == index
                                    ? Colors.white
                                    : widget.product.colors[index],
                                border: currentColor == index
                                    ? Border.all(
                                        color: widget.product.colors[index],
                                      )
                                    : null),
                            padding: currentColor == index
                                ? const EdgeInsets.all(2)
                                : null,
                            margin: const EdgeInsets.only(right: 10),
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: widget.product.colors[index],
                                  shape: BoxShape.circle),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // for description
                    Description(description: widget.product.description)
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
