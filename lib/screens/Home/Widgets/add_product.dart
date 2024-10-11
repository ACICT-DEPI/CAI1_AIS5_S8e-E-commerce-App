import 'dart:convert';
import 'dart:io';
import 'package:e_commerce/models/products.dart';
import 'package:e_commerce/screens/constans.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();

  String? _title;
  String? _description;
  File? _imageFile; // File to hold the selected image for mobile
  Uint8List? _imageBytes; // To hold the selected image bytes for web
  String? _review;
  String? _seller;
  double? _price;
  double? _rate;
  int? _quantity;
  final List<Color> _colors = [];
  String? _category;

  String? _selectedList; // Dropdown selection for list
  final List<String> _lists = ['all', 'shoes', 'beauty', 'womenFashion', 'jewelry', 'menFashion'];
  final List<String> _categories = ['Clothing', 'Shoes', 'Beauty', 'Electronics', 'Jewelry', 'Others'];

  void _addProduct() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Check if an image is selected
      if (_imageFile == null && _imageBytes == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select an image before adding the product.')),
        );
        return; // Exit the method if no image is selected
      }

      // Ensure all necessary fields are not null
      if (_title == null || _description == null || _review == null ||
          _seller == null || _price == null || _rate == null ||
          _quantity == null || _category == null || _selectedList == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill all required fields.')),
        );
         print('Image file path: ${_imageFile?.path}');
  print('Image bytes length: ${_imageBytes?.length}');
        return; // Exit if any required fields are null
      }

      // Create a new product
      Product newProduct = Product(
        title: _title!,
        description: _description!,
        image: _imageFile?.path ?? '', // Handle image path for mobile
        imageBytes: _imageBytes != null ? base64Encode(_imageBytes!) : '', // Handle image bytes for web
        review: _review!,
        seller: _seller!,
        price: _price!,
        colors: _colors,
        category: _category!,
        rate: _rate!,
        quantity: _quantity!,
      );

      // Add to the selected list
      setState(() {
        if (_selectedList == 'all') {
          all.add(newProduct);
        } else if (_selectedList == 'shoes') {
          shoes.add(newProduct);
        } else if (_selectedList == 'beauty') {
          beauty.add(newProduct);
        } else if (_selectedList == 'womenFashion') {
          womenFashion.add(newProduct);
        } else if (_selectedList == 'jewelry') {
          jewelry.add(newProduct);
        } else if (_selectedList == 'menFashion') {
          menFashion.add(newProduct);
        }

        // Reset the form after submission
        _formKey.currentState!.reset();
        _title = null;
        _description = null;
        _imageFile = null;
        _imageBytes = null;
        _review = null;
        _seller = null;
        _price = null;
        _rate = null;
        _quantity = null;
        _colors.clear();
        _category = null;
        _selectedList = null;
      });

      // Display confirmation or navigate back
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Product Added to $_selectedList')),
      );
    }
  }

  void _pickImage() async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        if (kIsWeb) {
          // For web, read bytes
          final bytes = await pickedFile.readAsBytes();
          setState(() {
            _imageBytes = bytes;
            _imageFile = null; // Reset file for web
          });
        } else {
          // For mobile
          setState(() {
            _imageFile = File(pickedFile.path);
            _imageBytes = null; // Reset bytes for mobile
          });
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No image selected')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  void _pickColors() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pick Colors'),
        content: SingleChildScrollView(
          child: BlockPicker(
            pickerColor: Colors.blue,
            onColorChanged: (color) {
              setState(() {
                _colors.add(color);
              });
            },
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('Done'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Title'),
                onSaved: (value) => _title = value,
                validator: (value) {
                  if (value!.isEmpty) return 'Please enter a title';
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                onSaved: (value) => _description = value,
                validator: (value) {
                  if (value!.isEmpty) return 'Please enter a description';
                  return null;
                },
              ),
              // Image Picker
              Row(
                children: [
                  // Check if it's web or mobile and render accordingly
                  _imageBytes != null // Check for web
                      ? Image.memory(_imageBytes!, height: 100, width: 100) // For web
                      : _imageFile != null // Check for mobile
                      ? Image.file(_imageFile!, height: 100, width: 100) // For mobile
                      : Container(height: 100, width: 100, color: Colors.grey), // Placeholder
                  const SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kprimaryColor, // Use backgroundColor instead of backgroundBuilder
                    ),
                    onPressed: _pickImage,
                    child: const Text('Pick Image',style: TextStyle(color: Colors.white,fontSize: 20),),
                  ),
                ],
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Seller'),
                onSaved: (value) => _seller = value,
                validator: (value) {
                  if (value!.isEmpty) return 'Please enter a seller name';
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Review'),
                onSaved: (value) => _review = value,
                validator: (value) {
                  if (value!.isEmpty) return 'Please enter a review';
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _price = double.tryParse(value!), // Use tryParse to avoid exceptions
                validator: (value) {
                  if (value!.isEmpty || double.tryParse(value) == null || double.parse(value) <= 0) {
                    return 'Please enter a valid price';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Rate'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _rate = double.tryParse(value!), // Use tryParse to avoid exceptions
                validator: (value) {
                  if (value!.isEmpty || double.tryParse(value) == null || double.parse(value) < 0 || double.parse(value) > 5) {
                    return 'Please enter a valid rating (0-5)';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _quantity = int.tryParse(value!), // Use tryParse to avoid exceptions
                validator: (value) {
                  if (value!.isEmpty || int.tryParse(value) == null || int.parse(value) <= 0) {
                    return 'Please enter a valid quantity';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Select Category'),
                value: _category,
                items: _categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _category = value;
                  });
                },
                validator: (value) {
                  if (value == null) return 'Please select a category';
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Select List'),
                value: _selectedList,
                items: _lists.map((String list) {
                  return DropdownMenuItem<String>(
                    value: list,
                    child: Text(list),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedList = value;
                  });
                },
                validator: (value) {
                  if (value == null) return 'Please select a list';
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Color Picker Section
              Wrap(
                spacing: 8.0,
                children: _colors.map((color) {
                  return Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: kprimaryColor),
                onPressed: _pickColors,
                child: const Text('Pick Colors',style: TextStyle(color: Colors.white,fontSize: 20),),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                                style: ElevatedButton.styleFrom(backgroundColor: kprimaryColor),

                onPressed: _addProduct,
                child: const Text('Add Product',style: TextStyle(color: Colors.white,fontSize: 20),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
