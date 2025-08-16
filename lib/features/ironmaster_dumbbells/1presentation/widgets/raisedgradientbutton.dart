// import 'package:flutter/material.dart';

// import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/utils/text_sized.dart';

// ///
// /// Gradient Button with Square Sides.
// ///
// /// Primarily used by the Wendler Deloads View for selecting Deload Options.
// ///
// class RaisedGradientSquareButton extends StatelessWidget {
//   final String text;
//   final Widget infoWidget;
//   final double defaultFontSize;
//   final FontWeight fontWeight;
//   final Gradient gradient;
//   final double width;
//   final double height;
//   final bool isEnabled;
//   final bool drawBoxDecoration;
//   final Function onPressed;
//   final borderRadius = BorderRadius.circular(3.0);

//   RaisedGradientSquareButton({
//     super.key,
//     // @required this.child,
//     @required this.text,
//     this.infoWidget,
//     this.defaultFontSize = 20,
//     this.fontWeight = FontWeight.bold,
//     required this.gradient,
//     this.width = double.infinity,
//     this.height = 50.0,
//     this.isEnabled = true,
//     this.drawBoxDecoration = false,
//     this.onPressed,
//   }) {
//     // ///
//     // /// Initialzie fontsize
//     // ///
//     // double fontSize = defaultFontSize;

//     // ///
//     // /// Ensure the given text can fit inside the button using fontSize.
//     // ///
//     // Size size = textSize(text, TextStyle(fontSize: fontSize));
//     // double leftRightSpacing = 30;

//     // ///
//     // /// Reduce the fontSize if the given texts width is greater than
//     // /// the width of the Button.
//     // ///
//     // while (size.width > (width - leftRightSpacing)) {
//     //   fontSize -= 2;
//     //   size = textSize(text, TextStyle(fontSize: fontSize));
//     // }
//   }

//   @override
//   Widget build(BuildContext context) {
//     //
//     // Flutter 2.0
//     //
//     final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
//       onPrimary: Colors.transparent, // background color
//       primary: Colors.transparent, // textColor
//       minimumSize: Size(88, 36),
//       shape: RoundedRectangleBorder(
//         borderRadius: borderRadius,
//       ),
//       padding: EdgeInsets.zero,
//     );

//     ///
//     /// Initialzie fontsize
//     ///
//     double fontSize = defaultFontSize;

//     ///
//     /// Ensure the given text can fit inside the button using fontSize.
//     ///
//     Size size = textSize(text, TextStyle(fontSize: fontSize));
//     double leftRightSpacing = 30;

//     ///
//     /// Reduce the fontSize if the given texts width is greater than
//     /// the width of the Button.
//     ///
//     while (size.width > (width - leftRightSpacing)) {
//       fontSize -= 2;
//       size = textSize(text, TextStyle(fontSize: fontSize));
//     }

//     return Stack(
//       children: [
//         // Positioned.fill(
//         //   child: ClipRRect(
//         //     borderRadius: borderRadius,
//         //     child: Container(
//         //       // width: width,
//         //       // height: height,
//         //       decoration: BoxDecoration(
//         //         gradient: (isEnabled == true)
//         //             ? gradient
//         //             : LinearGradient(
//         //                 colors: [
//         //                   Colors.black54,
//         //                   Colors.black54,
//         //                 ],
//         //                 begin: FractionalOffset.centerLeft,
//         //                 end: FractionalOffset.centerRight,
//         //               ),
//         //       ),
//         //     ),
//         //   ),
//         // ),
//         Container(
//           width: width,
//           height: height,
//           decoration: (drawBoxDecoration == true)
//               ? BoxDecoration(
//                   border: Border.all(color: Colors.blueAccent),
//                   gradient: (isEnabled == true)
//                       ? gradient
//                       : LinearGradient(
//                           colors: [
//                             Colors.black54,
//                             Colors.black54,
//                           ],
//                           begin: FractionalOffset.centerLeft,
//                           end: FractionalOffset.centerRight,
//                         ),
//                 )
//               : BoxDecoration(border: Border.all(color: Colors.transparent)),
//           child:

//               //
//               // Flutter 2.0
//               //
//               ElevatedButton(
//             style: raisedButtonStyle,
//             child: Center(
//               child: (infoWidget != null)
//                   ? infoWidget
//                   : Text(
//                       text,
//                       style: TextStyle(

//                           ///
//                           /// Make the text a white color if drawBoxDecoration is true.
//                           ///
//                           color: (isEnabled == true)
//                               ? (drawBoxDecoration == true)
//                                   ? Colors.white
//                                   : Colors.black54
//                               : Colors.black26,
//                           fontSize: fontSize,
//                           fontWeight: fontWeight),
//                     ),
//             ),
//             onPressed: (isEnabled == true) ? onPressed : null,
//           ),

//           // RaisedButton(
//           //   shape: RoundedRectangleBorder(
//           //     borderRadius: borderRadius,
//           //   ),
//           //   padding: EdgeInsets.zero,
//           //   child: Center(
//           //     child: (infoWidget != null)
//           //         ? infoWidget
//           //         : Text(
//           //             text,
//           //             style: TextStyle(

//           //                 ///
//           //                 /// Make the text a white color if drawBoxDecoration is true.
//           //                 ///
//           //                 color: (isEnabled == true)
//           //                     ? (drawBoxDecoration == true)
//           //                         ? Colors.white
//           //                         : Colors.black54
//           //                     : Colors.black26,
//           //                 fontSize: fontSize,
//           //                 fontWeight: fontWeight),
//           //           ),
//           //   ),
//           //   onPressed: (isEnabled == true) ? onPressed : null,
//           //   color: Colors.transparent,
//           // ),
//         ),
//       ],
//     );
//   }
// }

// ///
// /// Gradient Button with Rounded Sides.
// ///
// class RaisedGradientButton extends StatelessWidget {
//   // final Widget child;
//   final String text;
//   final double fontSize;
//   final FontWeight fontWeight;
//   final Gradient gradient;
//   final double width;
//   final double height;
//   final bool isEnabled;
//   final Function onPressed;
//   final borderRadius = BorderRadius.circular(30.0);

//   RaisedGradientButton({
//     super.key,
//     // @required this.child,
//     required this.text,
//     this.fontSize = 20,
//     this.fontWeight = FontWeight.bold,
//     required this.gradient,
//     this.width = double.infinity,
//     this.height = 50.0,
//     this.isEnabled = true,
//     required this.onPressed,
//   }) {
//     // ///
//     // /// Ensure the given text can fit inside the button using fontSize.
//     // ///
//     // Size size = textSize(text, TextStyle(fontSize: fontSize));
//     // double leftRightSpacing = 30;

//     // ///
//     // /// Reduce the fontSize if the given texts width is greater than
//     // /// the width of the Button.
//     // ///
//     // while (size.width > (width - leftRightSpacing)) {
//     //   fontSize -= 2;
//     //   size = textSize(text, TextStyle(fontSize: fontSize));
//     // }
//   }

//   @override
//   Widget build(BuildContext context) {
//     //
//     // Flutter 2.0
//     //
//     final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
//       onPrimary: Colors.transparent, // background color
//       primary: Colors.transparent, // textColor
//       minimumSize: Size(88, 36),
//       shape: RoundedRectangleBorder(
//         borderRadius: borderRadius,
//       ),
//       padding: EdgeInsets.zero,
//     );

//     ///
//     /// Ensure the given text can fit inside the button using fontSize.
//     ///
//     double adjustedFontSize = fontSize;
//     Size size = textSize(text, TextStyle(fontSize: adjustedFontSize));
//     double leftRightSpacing = 30;

//     ///
//     /// Reduce the fontSize if the given texts width is greater than
//     /// the width of the Button.
//     ///
//     while (size.width > (width - leftRightSpacing)) {
//       adjustedFontSize -= 2;
//       size = textSize(text, TextStyle(fontSize: adjustedFontSize));
//     }

//     return Stack(
//       children: [
//         Positioned.fill(
//           child: ClipRRect(
//             borderRadius: borderRadius,
//             child: Container(
//               width: width,
//               height: height,
//               decoration: BoxDecoration(
//                 gradient: (isEnabled == true)
//                     ? gradient
//                     : LinearGradient(
//                         colors: [
//                           Colors.black54,
//                           Colors.black54,
//                         ],
//                         begin: FractionalOffset.centerLeft,
//                         end: FractionalOffset.centerRight,
//                       ),
//               ),
//             ),
//           ),
//         ),
//         Container(
//           // width: text.length.toDouble() * 25,
//           width: width,
//           height: height,
//           child:
//               //
//               // Flutter 2.0
//               //
//               ElevatedButton(
//             style: raisedButtonStyle,
//             child: Center(
//               child: Text(
//                 text,
//                 style: TextStyle(
//                     color: (isEnabled == true) ? Colors.white : Colors.black26,
//                     fontSize: adjustedFontSize,
//                     fontWeight: fontWeight),
//               ),
//             ),
//             onPressed: (isEnabled == true) ? onPressed : null,
//           ),

//           // RaisedButton(
//           //   shape: RoundedRectangleBorder(
//           //     borderRadius: borderRadius,
//           //   ),
//           //   padding: EdgeInsets.zero,
//           //   child: Center(
//           //     child: Text(
//           //       text,
//           //       style: TextStyle(
//           //           color: (isEnabled == true) ? Colors.white : Colors.black26,
//           //           fontSize: adjustedFontSize,
//           //           fontWeight: fontWeight),
//           //     ),
//           //   ),
//           //   onPressed: (isEnabled == true) ? onPressed : null,
//           //   color: Colors.transparent,
//           // ),
//         ),
//       ],
//     );
//   }
// }

// ///
// /// Square Gradient Button with slightly rounded edges
// ///
// class GradientButton extends StatelessWidget {
//   final Widget child;

//   final Gradient gradient;
//   final double width;
//   final double height;
//   final bool isEnabled;
//   final Function onPressed;

//   GradientButton({
//     Key key,
//     @required this.child,
//     Gradient gradient,
//     this.isEnabled = true,
//     this.width,
//     this.height,
//     this.onPressed,
//   })  : this.gradient = gradient ??
//             LinearGradient(
//               colors: [
//                 Colors.blue,
//                 Colors.red,
//               ],
//               begin: FractionalOffset.centerLeft,
//               end: FractionalOffset.centerRight,
//             ),
//         super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Color _statusColor;
//     if (isEnabled != null) {
//       // Show gradient color by making material widget transparent
//       if (isEnabled == true) {
//         _statusColor = Colors.transparent;
//       } else {
//         // Show grey color if isEnabled is false
//         _statusColor = Colors.grey;
//       }
//     } else {
//       // Show grey color if isEnabled is null
//       _statusColor = Colors.transparent;
//     }

//     return Container(
//       width: width,
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8), gradient: gradient

//           // LinearGradient(
//           //   colors: [
//           //     Color(0xFF3186E3),
//           //     Color(0xFF1D36C4),
//           //   ],
//           //   begin: FractionalOffset.centerLeft,
//           //   end: FractionalOffset.centerRight,
//           // ),
//           ),
//       child: Material(
//           shape: RoundedRectangleBorder(
//               borderRadius: new BorderRadius.circular(4)),
//           color: _statusColor,
//           child: InkWell(
//               borderRadius: BorderRadius.circular(32),
//               onTap: onPressed,
//               child: Padding(
//                 padding: EdgeInsets.fromLTRB(24, 16, 24, 16),
//                 child: Center(
//                   child: child,
//                 ),
//               ))),
//     );
//   }
// }

// // import 'package:flutter/material.dart';

// // import 'text_sized.dart';

// // ///
// // /// Gradient Button with Square Sides.
// // ///
// // /// Primarily used by the Wendler Deloads View for selecting Deload Options.
// // ///
// // class RaisedGradientSquareButton extends StatelessWidget {
// //   final String text;
// //   final Widget infoWidget;
// //   final double defaultFontSize;
// //   final FontWeight fontWeight;
// //   final Gradient gradient;
// //   final double width;
// //   final double height;
// //   final bool isEnabled;
// //   final bool drawBoxDecoration;
// //   final Function onPressed;
// //   final borderRadius = BorderRadius.circular(3.0);

// //   RaisedGradientSquareButton({
// //     Key key,
// //     // @required this.child,
// //     @required this.text,
// //     this.infoWidget,
// //     this.defaultFontSize = 20,
// //     this.fontWeight = FontWeight.bold,
// //     Gradient gradient,
// //     this.width = double.infinity,
// //     this.height = 50.0,
// //     this.isEnabled = true,
// //     this.drawBoxDecoration = false,
// //     this.onPressed,
// //   })  : this.gradient = gradient ??
// //             LinearGradient(colors: <Color>[
// //               Colors.grey,
// //               Colors.grey[300],
// //               Colors.black54,
// //             ]),
// //         super(key: key) {
// //     // ///
// //     // /// Initialzie fontsize
// //     // ///
// //     // double fontSize = defaultFontSize;

// //     // ///
// //     // /// Ensure the given text can fit inside the button using fontSize.
// //     // ///
// //     // Size size = textSize(text, TextStyle(fontSize: fontSize));
// //     // double leftRightSpacing = 30;

// //     // ///
// //     // /// Reduce the fontSize if the given texts width is greater than
// //     // /// the width of the Button.
// //     // ///
// //     // while (size.width > (width - leftRightSpacing)) {
// //     //   fontSize -= 2;
// //     //   size = textSize(text, TextStyle(fontSize: fontSize));
// //     // }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     //
// //     // Flutter 2.0
// //     //
// //     final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
// //       onPrimary: Colors.transparent, // background color
// //       primary: Colors.transparent, // textColor
// //       minimumSize: Size(88, 36),
// //       shape: RoundedRectangleBorder(
// //         borderRadius: borderRadius,
// //       ),
// //       padding: EdgeInsets.zero,
// //     );

// //     ///
// //     /// Initialzie fontsize
// //     ///
// //     double fontSize = defaultFontSize;

// //     ///
// //     /// Ensure the given text can fit inside the button using fontSize.
// //     ///
// //     Size size = textSize(text, TextStyle(fontSize: fontSize));
// //     double leftRightSpacing = 30;

// //     ///
// //     /// Reduce the fontSize if the given texts width is greater than
// //     /// the width of the Button.
// //     ///
// //     while (size.width > (width - leftRightSpacing)) {
// //       fontSize -= 2;
// //       size = textSize(text, TextStyle(fontSize: fontSize));
// //     }

// //     return Stack(
// //       children: [
// //         Positioned.fill(
// //           child: ClipRRect(
// //             borderRadius: borderRadius,
// //             child: Container(
// //               width: width,
// //               height: height,
// //               decoration: BoxDecoration(
// //                 gradient: (isEnabled == true)
// //                     ? gradient
// //                     : LinearGradient(
// //                         colors: [
// //                           Colors.black54,
// //                           Colors.black54,
// //                         ],
// //                         begin: FractionalOffset.centerLeft,
// //                         end: FractionalOffset.centerRight,
// //                       ),
// //               ),
// //             ),
// //           ),
// //         ),
// //         Container(
// //           width: width,
// //           height: height,
// //           decoration: (drawBoxDecoration == true)
// //               ? BoxDecoration(border: Border.all(color: Colors.blueAccent))
// //               : BoxDecoration(border: Border.all(color: Colors.transparent)),
// //           child:

// //               //
// //               // Flutter 2.0
// //               //
// //               ElevatedButton(
// //             style: raisedButtonStyle,
// //             child: Center(
// //               child: (infoWidget != null)
// //                   ? infoWidget
// //                   : Text(
// //                       text,
// //                       style: TextStyle(

// //                           ///
// //                           /// Make the text a white color if drawBoxDecoration is true.
// //                           ///
// //                           color: (isEnabled == true)
// //                               ? (drawBoxDecoration == true)
// //                                   ? Colors.white
// //                                   : Colors.black54
// //                               : Colors.black26,
// //                           fontSize: fontSize,
// //                           fontWeight: fontWeight),
// //                     ),
// //             ),
// //             onPressed: (isEnabled == true) ? onPressed : null,
// //           ),

// //           // RaisedButton(
// //           //   shape: RoundedRectangleBorder(
// //           //     borderRadius: borderRadius,
// //           //   ),
// //           //   padding: EdgeInsets.zero,
// //           //   child: Center(
// //           //     child: (infoWidget != null)
// //           //         ? infoWidget
// //           //         : Text(
// //           //             text,
// //           //             style: TextStyle(

// //           //                 ///
// //           //                 /// Make the text a white color if drawBoxDecoration is true.
// //           //                 ///
// //           //                 color: (isEnabled == true)
// //           //                     ? (drawBoxDecoration == true)
// //           //                         ? Colors.white
// //           //                         : Colors.black54
// //           //                     : Colors.black26,
// //           //                 fontSize: fontSize,
// //           //                 fontWeight: fontWeight),
// //           //           ),
// //           //   ),
// //           //   onPressed: (isEnabled == true) ? onPressed : null,
// //           //   color: Colors.transparent,
// //           // ),
// //         ),
// //       ],
// //     );
// //   }
// // }

// // ///
// // /// Gradient Button with Rounded Sides.
// // ///
// // class RaisedGradientButton extends StatelessWidget {
// //   // final Widget child;
// //   final String text;
// //   final double fontSize;
// //   final FontWeight fontWeight;
// //   final Gradient gradient;
// //   final double width;
// //   final double height;
// //   final bool isEnabled;
// //   final Function onPressed;
// //   final borderRadius = BorderRadius.circular(30.0);

// //   RaisedGradientButton({
// //     Key key,
// //     // @required this.child,
// //     @required this.text,
// //     this.fontSize = 20,
// //     this.fontWeight = FontWeight.bold,
// //     Gradient gradient,
// //     this.width = double.infinity,
// //     this.height = 50.0,
// //     this.isEnabled = true,
// //     this.onPressed,
// //   })  : this.gradient = gradient ??
// //             LinearGradient(
// //               colors: [
// //                 Colors.blue,
// //                 Colors.red,
// //               ],
// //               begin: FractionalOffset.centerLeft,
// //               end: FractionalOffset.centerRight,
// //             ),
// //         super(key: key) {
// //     // ///
// //     // /// Ensure the given text can fit inside the button using fontSize.
// //     // ///
// //     // Size size = textSize(text, TextStyle(fontSize: fontSize));
// //     // double leftRightSpacing = 30;

// //     // ///
// //     // /// Reduce the fontSize if the given texts width is greater than
// //     // /// the width of the Button.
// //     // ///
// //     // while (size.width > (width - leftRightSpacing)) {
// //     //   fontSize -= 2;
// //     //   size = textSize(text, TextStyle(fontSize: fontSize));
// //     // }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     //
// //     // Flutter 2.0
// //     //
// //     final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
// //       onPrimary: Colors.transparent, // background color
// //       primary: Colors.transparent, // textColor
// //       minimumSize: Size(88, 36),
// //       shape: RoundedRectangleBorder(
// //         borderRadius: borderRadius,
// //       ),
// //       padding: EdgeInsets.zero,
// //     );

// //     ///
// //     /// Ensure the given text can fit inside the button using fontSize.
// //     ///
// //     double adjustedFontSize = fontSize;
// //     Size size = textSize(text, TextStyle(fontSize: adjustedFontSize));
// //     double leftRightSpacing = 30;

// //     ///
// //     /// Reduce the fontSize if the given texts width is greater than
// //     /// the width of the Button.
// //     ///
// //     while (size.width > (width - leftRightSpacing)) {
// //       adjustedFontSize -= 2;
// //       size = textSize(text, TextStyle(fontSize: adjustedFontSize));
// //     }

// //     return Stack(
// //       children: [
// //         Positioned.fill(
// //           child: ClipRRect(
// //             borderRadius: borderRadius,
// //             child: Container(
// //               width: width,
// //               height: height,
// //               decoration: BoxDecoration(
// //                 gradient: (isEnabled == true)
// //                     ? gradient
// //                     : LinearGradient(
// //                         colors: [
// //                           Colors.black54,
// //                           Colors.black54,
// //                         ],
// //                         begin: FractionalOffset.centerLeft,
// //                         end: FractionalOffset.centerRight,
// //                       ),
// //               ),
// //             ),
// //           ),
// //         ),
// //         Container(
// //           // width: text.length.toDouble() * 25,
// //           width: width,
// //           height: height,
// //           child:
// //               //
// //               // Flutter 2.0
// //               //
// //               ElevatedButton(
// //             style: raisedButtonStyle,
// //             child: Center(
// //               child: Text(
// //                 text,
// //                 style: TextStyle(
// //                     color: (isEnabled == true) ? Colors.white : Colors.black26,
// //                     fontSize: adjustedFontSize,
// //                     fontWeight: fontWeight),
// //               ),
// //             ),
// //             onPressed: (isEnabled == true) ? onPressed : null,
// //           ),

// //           // RaisedButton(
// //           //   shape: RoundedRectangleBorder(
// //           //     borderRadius: borderRadius,
// //           //   ),
// //           //   padding: EdgeInsets.zero,
// //           //   child: Center(
// //           //     child: Text(
// //           //       text,
// //           //       style: TextStyle(
// //           //           color: (isEnabled == true) ? Colors.white : Colors.black26,
// //           //           fontSize: adjustedFontSize,
// //           //           fontWeight: fontWeight),
// //           //     ),
// //           //   ),
// //           //   onPressed: (isEnabled == true) ? onPressed : null,
// //           //   color: Colors.transparent,
// //           // ),
// //         ),
// //       ],
// //     );
// //   }
// // }

// // ///
// // /// Square Gradient Button with slightly rounded edges
// // ///
// // class GradientButton extends StatelessWidget {
// //   final Widget child;

// //   final Gradient gradient;
// //   final double width;
// //   final double height;
// //   final bool isEnabled;
// //   final Function onPressed;

// //   GradientButton({
// //     Key key,
// //     @required this.child,
// //     Gradient gradient,
// //     this.isEnabled = true,
// //     this.width,
// //     this.height,
// //     this.onPressed,
// //   })  : this.gradient = gradient ??
// //             LinearGradient(
// //               colors: [
// //                 Colors.blue,
// //                 Colors.red,
// //               ],
// //               begin: FractionalOffset.centerLeft,
// //               end: FractionalOffset.centerRight,
// //             ),
// //         super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     Color _statusColor;
// //     if (isEnabled != null) {
// //       // Show gradient color by making material widget transparent
// //       if (isEnabled == true) {
// //         _statusColor = Colors.transparent;
// //       } else {
// //         // Show grey color if isEnabled is false
// //         _statusColor = Colors.grey;
// //       }
// //     } else {
// //       // Show grey color if isEnabled is null
// //       _statusColor = Colors.transparent;
// //     }

// //     return Container(
// //       width: width,
// //       decoration: BoxDecoration(
// //           borderRadius: BorderRadius.circular(8), gradient: gradient

// //           // LinearGradient(
// //           //   colors: [
// //           //     Color(0xFF3186E3),
// //           //     Color(0xFF1D36C4),
// //           //   ],
// //           //   begin: FractionalOffset.centerLeft,
// //           //   end: FractionalOffset.centerRight,
// //           // ),
// //           ),
// //       child: Material(
// //           shape: RoundedRectangleBorder(
// //               borderRadius: new BorderRadius.circular(4)),
// //           color: _statusColor,
// //           child: InkWell(
// //               borderRadius: BorderRadius.circular(32),
// //               onTap: onPressed,
// //               child: Padding(
// //                 padding: EdgeInsets.fromLTRB(24, 16, 24, 16),
// //                 child: Center(
// //                   child: child,
// //                 ),
// //               ))),
// //     );
// //   }
// // }
