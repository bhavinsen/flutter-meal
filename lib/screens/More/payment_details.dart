// ignore_for_file: deprecated_member_use

import 'package:flutter_credit_card_brazilian/credit_card_form.dart';
import 'package:flutter_credit_card_brazilian/credit_card_model.dart';
import 'package:flutter_credit_card_brazilian/credit_card_widget.dart';
import 'package:meals/Network/export.dart';

class PaymentDetails extends StatefulWidget {
  const PaymentDetails({Key? key}) : super(key: key);

  @override
  State<PaymentDetails> createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetails> {
  final _paymentItems = [
    const PaymentItem(
      label: 'Total',
      amount: '0',
      status: PaymentItemStatus.final_price,
    )
  ];

  void onApplePayResult(paymentResult) {}

  void onGooglePayResult(paymentResult) {}

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    paymentDetails,
                    style: const TextStyle(
                        color: black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  const Icon(
                    icCart,
                    color: black,
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                customPaymentMethod,
                style: const TextStyle(
                    color: black, fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 15,
              ),
              const Divider(
                color: grey,
                thickness: 0.4,
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: GooglePayButton(
                  width: 350,
                  paymentConfigurationAsset: 'gpay.json',
                  paymentItems: _paymentItems,
                  type: GooglePayButtonType.order,
                  onPaymentResult: onGooglePayResult,
                  loadingIndicator: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
              Center(
                child: ApplePayButton(
                  width: 350,
                  paymentConfigurationAsset: 'apple.json',
                  paymentItems: _paymentItems,
                  style: ApplePayButtonStyle.white,
                  onPaymentResult: onApplePayResult,
                  loadingIndicator: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: MaterialButton(
                  height: 45,
                  color: orange,
                  minWidth: 150,
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: orange),
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Column(
                          children: [
                            CreditCardWidget(
                              cardName: (String value) {
                                // ignore: avoid_print
                                print(value);
                              },
                              cardNumber: cardNumber,
                              expiryDate: expiryDate,
                              cardHolderName: cardHolderName,
                              cvvCode: cvvCode,
                              showBackView: isCvvFocused,
                              obscureCardNumber: true,
                              obscureCardCvv: true,
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: <Widget>[
                                    // ignore: sized_box_for_whitespace
                                    Container(
                                      height: 500,
                                      child: Column(
                                        children: [
                                          CreditCardForm(
                                            formKey: formKey,
                                            obscureCvv: true,
                                            obscureNumber: true,
                                            cardNumber: cardNumber,
                                            cvvCode: cvvCode,
                                            cardHolderName: cardHolderName,
                                            expiryDate: expiryDate,
                                            themeColor: blue,
                                            cardNumberDecoration:
                                                const InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: 'card holder',
                                              hintText: 'XXXX XXXX XXXX XXXX',
                                            ),
                                            expiryDateDecoration:
                                                const InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: 'Validade',
                                              hintText: 'XX/XX',
                                            ),
                                            cvvCodeDecoration:
                                                const InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: 'CVV',
                                              hintText: 'XXX',
                                            ),
                                            cardHolderDecoration:
                                                const InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: 'card holder',
                                            ),
                                            onCreditCardModelChange:
                                                onCreditCardModelChange,
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              primary:navyBlue,
                                            ),
                                            child: Container(
                                              margin: const EdgeInsets.all(8),
                                              child: const Text(
                                                'Validate',
                                                style: TextStyle(
                                                  color: white,
                                                  fontFamily: 'halter',
                                                  fontSize: 14,
                                                  package:
                                                      'flutter_credit_card',
                                                ),
                                              ),
                                            ),
                                            onPressed: () {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                // ignore: avoid_print
                                                print('valid!');
                                              } else {
                                                // ignore: avoid_print
                                                print('invalid!');
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    );
                  },
                  child: const Text(
                    '+  Add Another Credit/Debit Card',
                    style: TextStyle(
                        fontSize: 20,
                        color: white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
