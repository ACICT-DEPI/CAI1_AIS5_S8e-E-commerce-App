import 'package:e_commerce/screens/constans.dart';
import 'package:e_commerce/screens/payment/shipping_address.dart';
import 'package:flutter/material.dart';

class PaymentSelectionScreen extends StatefulWidget {
  const PaymentSelectionScreen({super.key});

  @override
  State<PaymentSelectionScreen> createState() => _PaymentSelectionScreenState();
}

class _PaymentSelectionScreenState extends State<PaymentSelectionScreen> {
  int _type = 1;
  void _handleRadio(Object? e) => setState(() {
        _type = e as int;
      });
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Payment Method'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Container(
                  width: size.width,
                  height: 55,
                  decoration: BoxDecoration(
                    border: _type == 4
                        ? Border.all(width: 1, color: kprimaryColor)
                        : Border.all(width: 0.3, color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.transparent,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Radio(
                                value: 4,
                                groupValue: _type,
                                onChanged: _handleRadio,
                                activeColor: kprimaryColor,
                              ),
                              Text(
                                "Amazon Pay",
                                style: _type == 4
                                    ? const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      )
                                    : const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                              ),
                            ],
                          ),
                          Image.asset(
                            "images/payment/amazon-pay.png",
                            height: 70,
                            width: 70,
                            fit: BoxFit.cover,
                            color: kprimaryColor,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  width: size.width,
                  height: 55,
                  decoration: BoxDecoration(
                    border: _type == 1
                        ? Border.all(width: 1, color: kprimaryColor)
                        : Border.all(width: 0.3, color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.transparent,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Radio(
                                value: 1,
                                groupValue: _type,
                                onChanged: _handleRadio,
                                activeColor: kprimaryColor,
                              ),
                              Text(
                                "Google Pay",
                                style: _type == 1
                                    ? const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      )
                                    : const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                              ),
                            ],
                          ),
                          Image.asset(
                            "images/payment/google-pay.png",
                            height: 70,
                            width: 70,
                            fit: BoxFit.cover,
                            color: kprimaryColor,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  width: size.width,
                  height: 55,
                  decoration: BoxDecoration(
                    border: _type == 2
                        ? Border.all(width: 1, color: kprimaryColor)
                        : Border.all(width: 0.3, color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.transparent,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Radio(
                                value: 2,
                                groupValue: _type,
                                onChanged: _handleRadio,
                                activeColor: kprimaryColor,
                              ),
                              Text(
                                "Credit card",
                                style: _type == 2
                                    ? const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      )
                                    : const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Image.asset(
                            "images/payment/visa.png",
                            width: 40,
                            fit: BoxFit.cover,
                            color: kprimaryColor,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Image.asset(
                            "images/payment/mastercard.png",
                            width: 40,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  width: size.width,
                  height: 55,
                  decoration: BoxDecoration(
                    border: _type == 3
                        ? Border.all(width: 1, color: kprimaryColor)
                        : Border.all(width: 0.3, color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.transparent,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Radio(
                                value: 3,
                                groupValue: _type,
                                onChanged: _handleRadio,
                                activeColor: kprimaryColor,
                              ),
                              Text(
                                "PayPal",
                                style: _type == 3
                                    ? const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      )
                                    : const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                              ),
                            ],
                          ),
                          Image.asset(
                            "images/payment/paypal.png",
                            height: 70,
                            width: 70,
                            fit: BoxFit.cover,
                            color: kprimaryColor,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 180,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    maximumSize: Size(size.width, 60),
                    backgroundColor: kprimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const ShippingAddressForm();
                      },
                    ));
                  },
                  child: const Text(
                    "Complete Payment",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
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
}
