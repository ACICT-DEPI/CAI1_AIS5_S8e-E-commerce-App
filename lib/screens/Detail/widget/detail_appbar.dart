import 'package:e_commerce/models/products.dart';
import 'package:flutter/material.dart';

import '../../../provider/favorite_provider.dart';

class DetailAppBar extends StatelessWidget {
  final Product product;
  const DetailAppBar({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final provider = FavoriteProvider.of(context);

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          IconButton(
            style: IconButton.styleFrom(
              padding: const EdgeInsets.all(15),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            iconSize: 23,
            icon: const Icon(Icons.arrow_back_ios),
          ),
          const Spacer(),
          // IconButton(
          //   style: IconButton.styleFrom(
          //     padding: const EdgeInsets.all(15),
          //   ),
          //   onPressed: () {},
          //   iconSize: 23,
          //   icon: const Icon(Icons.share_outlined),
          // ),
          // const SizedBox(
          //   width: 10,
          // ),
          IconButton(
            style: IconButton.styleFrom(
              padding: const EdgeInsets.all(15),
            ),
            onPressed: () {
              provider.tooglefavorites(product);
            },
            iconSize: 23,
            
            icon:  Icon(
              
              provider.isExist(product)?
              Icons.favorite :Icons.favorite_border,size: 25,),
          ),
        ],
      ),
    );
  }
}
