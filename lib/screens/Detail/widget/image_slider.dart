
import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:io';

class MyImageSlider extends StatelessWidget {
  final Function(int) onChange;
  final String image; // Expecting a single image

  const MyImageSlider({super.key, required this.onChange, required this.image});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: PageView.builder(
        onPageChanged: onChange,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Hero(
            tag: image,
            child: (() {
              // Check if the image can be loaded from memory
              try {
                final decodedImage = base64Decode(image); // Assuming the image string might be base64
                return Image.memory(
                  decodedImage,
                  fit: BoxFit.cover,
                );
              } catch (e) {
                // If base64 decoding fails, try to load as an asset or file
                if (File(image).existsSync()) {
                  return Image.file(
                    File(image),
                    fit: BoxFit.cover,
                  );
                } else {
                  return Image.asset(
                    image,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.error); // Display an error icon or placeholder
                    },
                  );
                }
              }
            })(),
          );
        },
      ),
    );
  }
}

