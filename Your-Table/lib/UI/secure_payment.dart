// ignore_for_file: constant_identifier_names, camel_case_types, override_on_non_overriding_member, avoid_unnecessary_containers, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:restuarant/confirmed.dart';
import '../main.dart';
import './card_type.dart';
import './card_utilis.dart';
import 'input_formatters.dart';

class SecurePayment extends StatefulWidget {
  const SecurePayment({super.key, required String? userId});

  @override
  State<StatefulWidget> createState() {
    return SecurePaymentState();
  }
}

enum visabilityRadio { CashVal, CreditVal }

class SecurePaymentState extends State<SecurePayment> {
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  TextEditingController carddNumberController = TextEditingController();
  TextEditingController nameeController = TextEditingController();
  TextEditingController cvvvController = TextEditingController();
  TextEditingController dateeController = TextEditingController();

  CardType cardType = CardType.Invalid;

  void getCardTypeFrmNum() {
    //with in first 6 digits we can identify the type so
    if (cardNumberController.text.length <= 6) {
      String cardNum = CardUtils.getCleanedNumber(cardNumberController.text);
      CardType type = CardUtils.getCardTypeFrmNumber(cardNum);
      if (type != cardType) {
        setState(() {
          cardType = type;
        });
      }
    }
  }

  num totalPrice = 0;
  bool calculated = false; // Track if totalPrice has been calculated

  void calculateTotalPrice(snapshot) {
    if (snapshot.hasData && !calculated) {
      int arrlen = snapshot.data?['Basket'].length;
      int currentRes = snapshot.data?['Res'];

      for (int i = 0; i < arrlen; i++) {
        totalPrice += snapshot.data?['Basket'][i]['price'];
      }

      calculated =
          true; // Set calculated to true to prevent further calculations
    }
  }

  @override
  void initState() {
    cardNumberController.addListener(() {
      getCardTypeFrmNum();
    });
    super.initState();
  }

  visabilityRadio? _vall = visabilityRadio.CashVal;

  @override
  bool aboutCashVal = false;
  bool visabilityCreditVal = false;
  String? radioState;
  @override
  Widget build(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser;
    DocumentReference snp =
        FirebaseFirestore.instance.collection('User').doc(currentUser?.uid);
    num price = 0;
    String? userId = Provider.of<UserData>(context).userId;

    GlobalKey<FormState> check = GlobalKey<FormState>();
    GlobalKey<FormState> check1 = GlobalKey<FormState>();

    void Confirm() {
      var checkfeild = check.currentState;
      var checkfeild1 = check1.currentState;

      if (checkfeild?.validate() == true || checkfeild1?.validate() == true) {
        if (checkfeild?.validate() == true) {
          checkfeild?.save();
          Payment(
            cardNumberController.text,
            nameController.text,
            cvvController.text,
            dateController.text,
          );
          if (aboutCashVal) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ConfirmedPage(userId: userId),
              ),
            );
          }
        } else if (checkfeild1?.validate() == true) {
          checkfeild1?.save();
          Payment(
            carddNumberController.text,
            nameeController.text,
            cvvvController.text,
            dateeController.text,
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ConfirmedPage(userId: userId),
            ),
          );
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: const Color(0xFF2babc4),
        title: const Text(
          'Secure Payment',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.black,
      body: FutureBuilder(
          future: snp.get(),
          builder: (context, snapshot) {
            calculateTotalPrice(snapshot);
            return Container(
              child: ListView(
                children: <Widget>[
                  //Element #1
                  const Padding(
                    padding:
                        EdgeInsets.only(top: 30.0, left: 15.0, bottom: 15.0),
                    child: Text('Payment Methods',
                        style: TextStyle(
                            fontSize: 19.0,
                            color: Color.fromARGB(255, 255, 255, 255))),
                  ),

                  //Element #2
                  Container(height: 10.0),

                  //Element #3
                  Row(
                    children: <Widget>[
                      Radio<visabilityRadio>(
                          fillColor: MaterialStateColor.resolveWith(
                              (states) => const Color(0xFF2babc4)),
                          value: visabilityRadio.CashVal,
                          groupValue: _vall,
                          onChanged: (visabilityRadio? val) {
                            setState(() {
                              _vall = val;
                            });
                          }),
                      const Text("Cash",
                          style:
                              TextStyle(fontSize: 15.0, color: Colors.white)),
                    ],
                  ),
                  _vall == visabilityRadio.CashVal
                      ? Padding(
                          padding: const EdgeInsets.only(left: 7.0, right: 7.0),
                          child: Container(
                            width: 20.0,
                            height: 360.0,
                            color: Colors.white,
                            //color: const Color(0xFFD3D3D0),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Checkbox(
                                      side: MaterialStateBorderSide.resolveWith(
                                          (states) => const BorderSide(
                                              width: 2.0,
                                              color: Color(0xFF2babc4))),
                                      activeColor: const Color(0xFF2babc4),
                                      value: aboutCashVal,
                                      onChanged: (val) {
                                        setState(() {
                                          aboutCashVal = val!;
                                        });
                                      },
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 32.0),
                                      child: Text(
                                          "when you choose Cash option you must enter your\n card information,In case you don't come on time\n and you are late for a maximum of 10 minutes \$5\n will be deducted from your account"),
                                    ),
                                  ],
                                ),
                                Form(
                                  key: check,
                                  child: Column(
                                    children: <Widget>[
                                      //#1
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10.0, left: 15.0, right: 15.0),
                                        child: TextFormField(
                                          controller: cardNumberController,
                                          validator: (text) {
                                            if (text!.isEmpty) {
                                              return "Please enter card number";
                                            } else {
                                              return null;
                                            }
                                          },
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            LengthLimitingTextInputFormatter(
                                                16),
                                            CardNumberInputFormatter(),
                                          ],
                                          decoration: InputDecoration(
                                              border:
                                                  const OutlineInputBorder(),
                                              hintText: "Card Number",
                                              //want to show the card type logo
                                              suffixIcon: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: CardUtils.getCardIcon(
                                                    cardType),
                                              ),
                                              prefixIcon: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Image.asset(
                                                    'assets/images/card.png',
                                                    width: 5,
                                                    height: 5),
                                              )),
                                        ),
                                      ),

                                      //#2
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10.0, left: 15.0, right: 15.0),
                                        child: TextFormField(
                                          controller: nameController,
                                          validator: (text) {
                                            if (text!.isEmpty) {
                                              return "Please enter name";
                                            } else {
                                              return null;
                                            }
                                          },
                                          decoration: InputDecoration(
                                              border:
                                                  const OutlineInputBorder(),
                                              hintText: "Full Name",
                                              prefixIcon: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Image.asset(
                                                    'assets/images/user.png',
                                                    width: 5,
                                                    height: 5),
                                              )),
                                        ),
                                      ),

                                      //#3
                                      Row(children: <Widget>[
                                        //1
                                        Expanded(
                                            child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10.0,
                                              left: 15.0,
                                              right: 5.0),
                                          child: TextFormField(
                                            controller: cvvController,
                                            validator: (text) {
                                              if (text!.isEmpty) {
                                                return "Please enter cvv number";
                                              } else {
                                                return null;
                                              }
                                            },
                                            keyboardType: TextInputType.number,
                                            //Limit the input
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                              LengthLimitingTextInputFormatter(
                                                  3)
                                            ],
                                            decoration: InputDecoration(
                                                border:
                                                    const OutlineInputBorder(),
                                                hintText: "CVV",
                                                prefixIcon: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 10.0),
                                                  child: Image.asset(
                                                      'assets/images/cvv.png',
                                                      width: 5,
                                                      height: 5),
                                                )),
                                          ),
                                        )),

                                        //2
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0,
                                                left: 5.0,
                                                right: 15.0),
                                            child: TextFormField(
                                              controller: dateController,
                                              validator: (text) {
                                                if (text!.isEmpty) {
                                                  return "Please enter date";
                                                } else {
                                                  return null;
                                                }
                                              },
                                              keyboardType:
                                                  TextInputType.number,
                                              //Limit the input
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                                LengthLimitingTextInputFormatter(
                                                    5),
                                                CardMonthInputFormatter()
                                              ],
                                              decoration: InputDecoration(
                                                  border:
                                                      const OutlineInputBorder(),
                                                  hintText: "MM/YY",
                                                  prefixIcon: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Image.asset(
                                                        'assets/images/calenderr.png',
                                                        width: 5,
                                                        height: 5),
                                                  )),
                                            ),
                                          ),
                                        ),
                                      ])
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container(),

                  //Element #4
                  Row(
                    children: <Widget>[
                      Radio<visabilityRadio>(
                          fillColor: MaterialStateColor.resolveWith(
                              (states) => const Color(0xFF2babc4)),
                          value: visabilityRadio.CreditVal,
                          groupValue: _vall,
                          onChanged: (visabilityRadio? val) {
                            setState(() {
                              _vall = val;
                            });
                          }),
                      const Text("Credit / Debit Card",
                          style:
                              TextStyle(fontSize: 15.0, color: Colors.white)),
                    ],
                  ),
                  _vall == visabilityRadio.CreditVal
                      ? Padding(
                          padding: const EdgeInsets.only(left: 7.0, right: 7.0),
                          child: Container(
                            width: 20.0,
                            height: 260.0,
                            color: Colors.white,
                            child: Column(
                              children: <Widget>[
                                Form(
                                  key: check1,
                                  child: Column(
                                    children: <Widget>[
                                      //#1
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10.0, left: 15.0, right: 15.0),
                                        child: TextFormField(
                                          controller: carddNumberController,
                                          validator: (text) {
                                            if (text!.isEmpty) {
                                              return "Please enter card number";
                                            } else {
                                              return null;
                                            }
                                          },
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            LengthLimitingTextInputFormatter(
                                                16),
                                            CardNumberInputFormatter(),
                                          ],
                                          decoration: InputDecoration(
                                              border:
                                                  const OutlineInputBorder(),
                                              hintText: "Card Number",
                                              //want to show the card type logo
                                              suffixIcon: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: CardUtils.getCardIcon(
                                                    cardType),
                                              ),
                                              prefixIcon: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Image.asset(
                                                    'assets/images/card.png',
                                                    width: 5,
                                                    height: 5),
                                              )),
                                        ),
                                      ),

                                      //#2
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10.0, left: 15.0, right: 15.0),
                                        child: TextFormField(
                                          controller: nameeController,
                                          validator: (text) {
                                            if (text!.isEmpty) {
                                              return "Please enter name";
                                            } else {
                                              return null;
                                            }
                                          },
                                          decoration: InputDecoration(
                                              border:
                                                  const OutlineInputBorder(),
                                              hintText: "Full Name",
                                              prefixIcon: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Image.asset(
                                                    'assets/images/user.png',
                                                    width: 5,
                                                    height: 5),
                                              )),
                                        ),
                                      ),

                                      //#3
                                      Row(children: <Widget>[
                                        //1
                                        Expanded(
                                            child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10.0,
                                              left: 15.0,
                                              right: 5.0),
                                          child: TextFormField(
                                            controller: cvvvController,
                                            validator: (text) {
                                              if (text!.isEmpty) {
                                                return "Please enter cvv number";
                                              } else {
                                                return null;
                                              }
                                            },
                                            keyboardType: TextInputType.number,
                                            //Limit the input
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                              LengthLimitingTextInputFormatter(
                                                  3)
                                            ],
                                            decoration: InputDecoration(
                                                border:
                                                    const OutlineInputBorder(),
                                                hintText: "CVV",
                                                prefixIcon: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 10.0),
                                                  child: Image.asset(
                                                      'assets/images/cvv.png',
                                                      width: 5,
                                                      height: 5),
                                                )),
                                          ),
                                        )),

                                        //2
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0,
                                                left: 5.0,
                                                right: 15.0),
                                            child: TextFormField(
                                              controller: dateeController,
                                              validator: (text) {
                                                if (text!.isEmpty) {
                                                  return "Please enter date";
                                                } else {
                                                  return null;
                                                }
                                              },
                                              keyboardType:
                                                  TextInputType.number,
                                              //Limit the input
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                                LengthLimitingTextInputFormatter(
                                                    5),
                                                CardMonthInputFormatter()
                                              ],
                                              decoration: InputDecoration(
                                                  border:
                                                      const OutlineInputBorder(),
                                                  hintText: "MM/YY",
                                                  prefixIcon: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Image.asset(
                                                        'assets/images/calenderr.png',
                                                        width: 5,
                                                        height: 5),
                                                  )),
                                            ),
                                          ),
                                        ),
                                      ])
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container(),

                  //Element#5
                  Row(
                    children: <Widget>[
                      //#1
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 30.0, left: 15.0),
                            child: Text(
                              'TOTAL:',
                              style: TextStyle(
                                  fontSize: 18.0,
                                  color: Color.fromARGB(255, 255, 255, 255)),
                            ),
                          ),

                          //2
                          Padding(
                            padding: EdgeInsets.only(top: 10.0, left: 15.0),
                            child: Text("${totalPrice} JOD",
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 18)),
                          ),
                        ],
                      ),

                      //#2
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 40.0, left: 180.0, right: 30.0, bottom: 15.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              // ignore: deprecated_member_use
                              primary: const Color(0xFF2babc4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                          child: const Text('Confirm',
                              style: TextStyle(
                                  fontSize: 17.0, color: Colors.black)),
                          onPressed: () {
                            Confirm();
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          }),
    );
  }
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    String inputDate = newValue.text;
    StringBuffer buffer = StringBuffer();

    for (var i = 0; i < inputDate.length; i++) {
      buffer.write(inputDate[i]);
      int index = i + 1;

      if (index % 4 == 0 && inputDate.length != index) {
        buffer.write(" ");
      }
    }
    return TextEditingValue(
        text: buffer.toString(),
        selection: TextSelection.collapsed(
          offset: buffer.toString().length,
        ));
  }
}

void Payment(String cardNumber, String name, String cvv, String date) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var userId;
  User? currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser != null) {
    String userId = currentUser.uid;

    QuerySnapshot querySnapshot = await firestore
        .collection('User')
        .where('userid', isEqualTo: userId)
        .get();

    DocumentReference documentRef = querySnapshot.docs[0].reference;
    Map<String, dynamic> CardInfo = {
      'CardInfo': {
        'CardNumber': cardNumber,
        'FullName': name,
        'CVV': cvv,
        'Date': date,
      },
    };
    documentRef.update(CardInfo);
  } else {
    print('No user logged in.');
  }

  // Query the 'Table' collection to check if the entered tableNum exists

  // Create a new document in the "TableReservation" collection
}
