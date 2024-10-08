import 'package:e_commerce/screens/constans.dart';
import 'package:flutter/material.dart';
import 'credit_card_form.dart'; // Import your CreditCardForm here
import 'package:flutter/material.dart';
import 'credit_card_form.dart'; // Import your CreditCardForm here

class ShippingAddressForm extends StatefulWidget {
  const ShippingAddressForm({Key? key}) : super(key: key);

  @override
  _ShippingAddressFormState createState() => _ShippingAddressFormState();
}

class _ShippingAddressFormState extends State<ShippingAddressForm> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String address = '';
  String city = '';
  String state = '';
  String postalCode = '';
  String country = 'Egypt'; // Default value
  List<String> countries = [
    'United States',
    'Egypt',
    'Saudi Arabia',
    'Australia',
    'Germany',
    'France',
    'Qatar',
    // Add more countries as needed
  ];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Here you could save the shipping address if needed
      print('Shipping Address Submitted:');
      print('Name: $name');
      print('Address: $address');
      print('City: $city');
      print('State: $state');
      print('Postal Code: $postalCode');
      print('Country: $country');

      // Navigate to the Credit Card Payment Form
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                CreditCardForm()), // Navigate to CreditCardForm
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Shipping Address'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildTextField(
                  label: 'Name',
                  onChanged: (value) => name = value,
                ),
                SizedBox(
                  height: 20,
                ),
                _buildTextField(
                  label: 'Address',
                  onChanged: (value) => address = value,
                ),
                SizedBox(
                  height: 20,
                ),

                _buildTextField(
                  label: 'City',
                  onChanged: (value) => city = value,
                ),
                SizedBox(
                  height: 20,
                ),

                _buildTextField(
                  label: 'State',
                  onChanged: (value) => state = value,
                ),
                SizedBox(
                  height: 20,
                ),

                _buildTextField(
                  label: 'Postal Code',
                  keyboardType: TextInputType.number,
                  onChanged: (value) => postalCode = value,
                ),
                SizedBox(
                  height: 20,
                ),

                _buildCountryDropdown(),
                SizedBox(height: 100,), // Add the country dropdown here
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                    maximumSize: Size(size.width, 60),
                    backgroundColor: kprimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  ),
                  
                 
                  onPressed: _submitForm,
                  child: Text(
                    'Submit Address',
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required Function(String) onChanged,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      decoration: InputDecoration(
         focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
            color: kprimaryColor,
          ),
          ),
        labelText: label,
        border: OutlineInputBorder(),
      ),
      keyboardType: keyboardType,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your $label';
        }
        return null;
      },
      onChanged: onChanged,
    );
  }

  Widget _buildCountryDropdown() {
    return DropdownButtonFormField<String>(
      value: country,
      decoration: InputDecoration(
         focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
            color: kprimaryColor,
          ),
          ),
        labelText: 'Country',
        border: OutlineInputBorder(),
      ),
      items: countries.map((String country) {
        return DropdownMenuItem<String>(
          value: country,
          child: Text(country),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          country = newValue!;
        });
      },
      validator: (value) {
        if (value == 'Select Country') {
          return 'Please select a country';
        }
        return null;
      },
    );
  }
}
