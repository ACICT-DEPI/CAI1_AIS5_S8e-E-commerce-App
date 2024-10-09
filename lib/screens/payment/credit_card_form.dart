import 'package:e_commerce/screens/constans.dart';
import 'package:e_commerce/screens/payment/payment_success.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart'; // Import the Lottie package
// Make sure to import Lottie for animations

class CreditCardForm extends StatefulWidget {
  const CreditCardForm({super.key});

  @override
  _CreditCardFormState createState() => _CreditCardFormState();
}

class _CreditCardFormState extends State<CreditCardForm> {
  final _formKey = GlobalKey<FormState>();
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      print('Processing Credit Card Payment');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const PaymentSuccessScreen();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Credit Card'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Lottie.asset(
              'images/animation/pay.json',
              width: double.infinity,
              height: 300,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildTextField(
                    label: 'Card Number',
                    keyboardType: TextInputType.number,
                    onChanged: (value) => cardNumber = value,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your card number';
                      }

                      if (value.length > 16) {
                        return 'Card number cannot exceed 16 digits';
                      }

                      if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                        return 'Card number must only contain digits';
                      }

                      return null;
                    },
                  ),
                  _buildTextField(
                    label: 'Expiry Date (MM/YY)',
                    keyboardType: TextInputType.datetime,
                    onChanged: (value) => expiryDate = value,
                    validator: (value) {
                      if (value!.isEmpty) return 'Please enter expiry date';
                      return null;
                    },
                  ),
                  _buildTextField(
                    label: 'Card Holder Name',
                    onChanged: (value) => cardHolderName = value,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter card holder name';
                      }
                      return null;
                    },
                  ),
                  _buildTextField(
                    label: 'CVV',
                    keyboardType: TextInputType.number,
                    onChanged: (value) => cvvCode = value,
                    validator: (value) {
                      if (value!.isEmpty) return 'Please enter CVV';
                      if (value.length > 3) {
                        return 'CVV must be 3 digits';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      maximumSize: Size(size.width, 60),
                      backgroundColor: kprimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding:
                          const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    ),
                    child: const Text(
                      'Proceed to Payment',
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required Function(String) onChanged,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator, // Add validator parameter
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: kprimaryColor,
            ),
          ),
          labelText: label,
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        ),
        keyboardType: keyboardType,
        validator: validator, // Use the provided validator
        onChanged: onChanged,
      ),
    );
  }
}
