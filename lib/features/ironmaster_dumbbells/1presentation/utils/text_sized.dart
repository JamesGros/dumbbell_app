import 'package:flutter/material.dart';

// class TextSized extends StatelessWidget {
//   const TextSized({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final String text = "Text in one line";
//     final TextStyle textStyle = TextStyle(
//       fontSize: 30,
//       color: Colors.white,
//     );
//     final Size txtSize = _textSize(text, textStyle);

//     // This kind of use - meaningless. It's just an example.
//     return Container(
//       color: Colors.blueGrey,
//       width: txtSize.width,
//       height: txtSize.height,
//       child: Text(
//         text,
//         style: textStyle,
//         softWrap: false,
//         overflow: TextOverflow.clip,
//         maxLines: 1,
//       ),
//     );
//   }

//   // Here it is!
//   Size _textSize(String text, TextStyle style) {
//     final TextPainter textPainter = TextPainter(
//         text: TextSpan(text: text, style: style),
//         maxLines: 1,
//         textDirection: TextDirection.ltr)
//       ..layout(minWidth: 0, maxWidth: double.infinity);
//     return textPainter.size;
//   }
// }

// Here it is!
///
/// Returns a Size object, given the text string and its TextStyle
/// parameter.  Useful when centering text on screen.
///
Size textSize(String text, TextStyle style) {
  final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr)
    ..layout(minWidth: 0, maxWidth: double.infinity);
  return textPainter.size;
}
