import 'package:e_commerce/models/products.dart';
import 'package:e_commerce/screens/constans.dart';
import 'package:flutter/material.dart';

class ItemDetails extends StatelessWidget {
  final Product product;
  const ItemDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.title,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "\$ ${product.price}",
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                //for rating
                Row(children: [
                  Container(
                    height: 25,
                    width: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: kprimaryColor,
                    ),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.white,
                          size: 14,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          product.rate.toString(),
                          style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    product.review,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  )
                ]),
              ],
            ),
            const Spacer(),
            Text.rich(
              TextSpan(children: [
                const TextSpan(
                  text: "Seller:",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                TextSpan(
                  text: product.seller,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ]),
            ),
          ],
        ),
      ],
    );
  }
}
