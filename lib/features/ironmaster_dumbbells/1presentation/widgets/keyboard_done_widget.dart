// import 'dart:io';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// ///
// /// Purpose:  This class implements the "Done" button on top of the
// ///           keyboard using an OverlayEntry() class.
// ///
// /// Parameters:
// /// (I) onDonePressed - Callback function when the "Done" button is pressed.
// /// (I) textEditController - The text controller assigned to the TextField() object.
// ///
// class InputDoneView extends StatelessWidget {
//   final Function(String) onDonePressed;
//   final TextEditingController textEditController;

//   const InputDoneView(
//       {super.key,
//       @required this.onDonePressed,
//       required this.textEditController});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       color: Color(0xFF777777),
//       child: Align(
//         alignment: Alignment.topRight,
//         child: Padding(
//           padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
//           child: Platform.isIOS
//               ? CupertinoButton(
//                   padding: EdgeInsets.only(right: 24.0, top: 8.0, bottom: 8.0),
//                   onPressed: () {
//                     onDonePressed(textEditController.text);
//                     FocusScope.of(context).requestFocus(new FocusNode());
//                   },
//                   child: Text("Done",
//                       style: TextStyle(
//                           color: Color(0xff999999),
//                           fontWeight: FontWeight.bold)),
//                 )
//               : FlatButton(
//                   padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
//                   onPressed: () {
//                     onDonePressed(textEditController.text);
//                     FocusScope.of(context).requestFocus(new FocusNode());
//                   },
//                   child: Text("Done",
//                       style: TextStyle(
//                           color: Color(0xff999999),
//                           fontWeight: FontWeight.bold)),
//                 ),
//         ),
//       ),
//     );
//   }
// }
