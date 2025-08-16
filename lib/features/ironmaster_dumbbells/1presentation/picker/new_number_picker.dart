// import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/picker/Picker.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/material.dart' as Dialog;
// import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/widgets/custom_dialog.dart';
// import 'dart:async';

// const bool __printDebug = false;

// /// Picker selected callback.
// typedef PickerSelectedCallback = void Function(
//     NewNumberPicker picker, int index, List<int> selecteds);

// /// Picker confirm callback.
// typedef PickerConfirmCallback = void Function(
//     NewNumberPicker picker, List<int> selecteds);

// /// Picker value format callback.
// typedef PickerValueFormat<T> = String Function(T value);

// /// Picker
// class NewNumberPicker {
//   static const double DefaultTextSize = 20.0;

//   /// Index of currently selected items
//   List<int> selecteds;

//   /// Picker adapter, Used to provide data and generate widgets
//   // PickerAdapter adapter;
//   // final PickerAdapter adapter;
//   NewNumberPickerAdapter adapter;

//   ///
//   /// JG Added for Weight Rack View
//   ///
//   int initialWholeValue;
//   int initialFactionValue;

//   /// insert separator before picker columns
//   final List<PickerDelimiter> delimiter;

//   final VoidCallback onCancel;
//   final PickerSelectedCallback onSelect;
//   final PickerConfirmCallback onConfirm;

//   /// When the previous level selection changes, scroll the child to the first item.
//   final changeToFirst;

//   /// Specify flex for each column
//   final List<int> columnFlex;

//   final Widget title;
//   final Widget cancel;
//   final Widget confirm;
//   final String cancelText;
//   final String confirmText;

//   final double height;

//   /// Height of list item
//   final double itemExtent;

//   final TextStyle textStyle,
//       cancelTextStyle,
//       confirmTextStyle,
//       selectedTextStyle;
//   final TextAlign textAlign;

//   /// Text scaling factor
//   final double textScaleFactor;

//   final EdgeInsetsGeometry columnPadding;
//   final Color backgroundColor, headercolor, containerColor;

//   /// Hide head
//   final bool hideHeader;

//   /// List item loop
//   final bool looping;

//   final Widget footer;

//   final Decoration headerDecoration;

//   Widget _widget;
//   PickerWidgetState _state;

//   // get pickerstate => _state;

//   NewNumberPicker(
//       {this.adapter,
//       this.initialWholeValue = 0,
//       this.initialFactionValue = 0,
//       this.delimiter,
//       this.selecteds,
//       this.height = 150.0,
//       this.itemExtent = 28.0,
//       this.columnPadding,
//       this.textStyle,
//       this.cancelTextStyle,
//       this.confirmTextStyle,
//       this.selectedTextStyle,
//       this.textAlign = TextAlign.start,
//       this.textScaleFactor,
//       this.title,
//       this.cancel,
//       this.confirm,
//       this.cancelText,
//       this.confirmText,
//       this.backgroundColor = Colors.white,
//       this.containerColor,
//       this.headercolor,
//       this.changeToFirst = false,
//       this.hideHeader = false,
//       this.looping = false,
//       this.headerDecoration,
//       this.columnFlex,
//       this.footer,
//       this.onCancel,
//       this.onSelect,
//       this.onConfirm})
//       : assert(adapter != null);

//   Widget get widget => _widget;
//   PickerWidgetState get state => _state;
//   int _maxLevel = 1;

//   ///
//   /// Build picker control
//   ///
//   Widget makePicker([ThemeData? themeData, bool isModal = false]) {
//     _maxLevel = adapter.maxLevel;
//     adapter.picker = this;
//     adapter.initSelects();
//     _widget =
//         _PickerWidget(picker: this, themeData: themeData, isModal: isModal);
//     return _widget;
//   }

//   /// show picker
//   void show(ScaffoldState state, [ThemeData? themeData]) {
//     state.showBottomSheet((BuildContext context) {
//       return makePicker(themeData);
//     });
//   }

//   /// Display modal picker
//   Future<T> showModal<T>(BuildContext context, [ThemeData themeData]) async {
//     return await showModalBottomSheet<T>(
//         context: context, //state.context,
//         builder: (BuildContext context) {
//           return makePicker(themeData, true);
//         });
//   }

//   /// show dialog picker
//   void showDialog(BuildContext context) {
//     // final mediaQuery = MediaQuery.of(context);
//     Dialog.showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return CustomAlertDialog(
//             content: makePicker(),
//             description: "",
//             secondaryButtonText: "Cancel",
//             secondaryButtonRoute: "",
//             secondaryCallbackFunction: () {
//               Navigator.pop(context);
//             },
//             primaryButtonText: "Select",
//             primaryButtonRoute: "",
//             // WeightRackView.routeName,
//             primaryCallbackFunction: () async {
//               Navigator.pop(context);
//               if (onConfirm != null) onConfirm(this, selecteds);
//             },
//           );
//         });
//   }

//   ///
//   /// Get the value of the current selection
//   ///
//   List getSelectedValues() {
//     return adapter.getSelectedValues();
//   }

//   /// 取消
//   void doCancel(BuildContext context) {
//     if (onCancel != null) onCancel();
//     Navigator.of(context).pop();
//     _widget = null;
//   }

//   /// 确定
//   void doConfirm(BuildContext context) {
//     if (onConfirm != null) onConfirm(this, selecteds);
//     Navigator.of(context).pop();
//     _widget = null;
//   }
// }

// ///
// ///  NewNumberPickerAdapter
// ///
// abstract class NewNumberPickerAdapter<T> {
//   NewNumberPicker picker;

//   int getLength();
//   int getMaxLevel();
//   void setColumn(int index);
//   void initSelects();
//   Widget buildItem(BuildContext context, int index);

//   Widget makeText(Widget child, String text, bool isSel) {
//     return new Container(
//         alignment: Alignment.center,
//         child: DefaultTextStyle(
//             overflow: TextOverflow.ellipsis,
//             maxLines: 1,
//             textAlign: picker.textAlign,
//             style: picker.textStyle ??
//                 new TextStyle(
//                     color: Colors.black87,
//                     fontSize: NewNumberPicker.DefaultTextSize),
//             child: child ??
//                 new Text(text,
//                     textScaleFactor: picker.textScaleFactor,
//                     style: (isSel ? picker.selectedTextStyle : null))));
//   }

//   Widget makeTextEx(
//       Widget child, String text, Widget postfix, Widget suffix, bool isSel) {
//     List<Widget> items = [];
//     if (postfix != null) items.add(postfix);
//     items.add(child ??
//         new Text(text, style: (isSel ? picker.selectedTextStyle : null)));
//     if (suffix != null) items.add(suffix);

//     var _txtColor = Colors.black87;
//     var _txtSize = NewNumberPicker.DefaultTextSize;
//     if (isSel && picker.selectedTextStyle != null) {
//       if (picker.selectedTextStyle.color != null)
//         _txtColor = picker.selectedTextStyle.color;
//       if (picker.selectedTextStyle.fontSize != null)
//         _txtSize = picker.selectedTextStyle.fontSize;
//     }

//     return new Container(
//         alignment: Alignment.center,
//         child: DefaultTextStyle(
//             overflow: TextOverflow.ellipsis,
//             maxLines: 1,
//             textAlign: picker.textAlign,
//             style: picker.textStyle ??
//                 new TextStyle(color: _txtColor, fontSize: _txtSize),
//             child: Wrap(
//               children: items,
//             )));
//   }

//   String getText() {
//     return getSelectedValues().toString();
//   }

//   List<T> getSelectedValues() {
//     return [];
//   }

//   void doShow() {}
//   void doSelect(int column, int index) {}

//   int getColumnFlex(int column) {
//     if (picker.columnFlex != null && column < picker.columnFlex.length)
//       return picker.columnFlex[column];
//     return 1;
//   }

//   int get maxLevel => getMaxLevel();

//   /// Content length of current column
//   int get length => getLength();

//   String get text => getText();

//   ///
//   /// isLinkage
//   ///
//   bool get isLinkage => getIsLinkage();

//   @override
//   String toString() {
//     return getText();
//   }

//   bool getIsLinkage() {
//     return true;
//   }

//   ///
//   /// notifyDataChanged
//   ///
//   void notifyDataChanged() {
//     if (picker != null && picker.state != null) {
//       picker.adapter.doShow();
//       picker.adapter.initSelects();
//       for (int j = 0; j < picker.selecteds.length; j++)
//         picker.state.scrollController[j].jumpToItem(picker.selecteds[j]);
//     }
//   }
// }

// class _PickerWidget<T> extends StatefulWidget {
//   final NewNumberPicker picker;
//   final ThemeData themeData;
//   final bool isModal;
//   _PickerWidget(
//       {Key key, @required this.picker, @required this.themeData, this.isModal})
//       : super(key: key);

//   @override
//   PickerWidgetState createState() =>
//       PickerWidgetState<T>(picker: this.picker, themeData: this.themeData);
// }

// class PickerWidgetState<T> extends State<_PickerWidget> {
//   final NewNumberPicker picker;
//   final ThemeData themeData;
//   PickerWidgetState({Key key, @required this.picker, @required this.themeData});

//   // get internalPicker => picker;

//   ThemeData theme;
//   final List<FixedExtentScrollController> scrollController = [];

//   @override
//   void initState() {
//     super.initState();
//     theme = themeData;
//     picker._state = this;
//     picker.adapter.doShow();

//     if (scrollController.length == 0) {
//       for (int i = 0; i < picker._maxLevel; i++) {
//         scrollController.add(FixedExtentScrollController(

//             ///
//             /// JG Added for Weight Rack View, set the initial
//             /// value as the same value currently selected.
//             ///
//             initialItem: (i == 0)
//                 ? picker.initialWholeValue
//                 : picker.initialFactionValue)); // picker.selecteds[i]));

//         ///
//         /// JG Added for Weight Rack View, returns the initial
//         /// value as the same value currently selected if nothing
//         /// changed
//         ///
//         picker.selecteds[i] =
//             (i == 0) ? picker.initialWholeValue : picker.initialFactionValue;
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     ///
//     /// JG - Initialize the internal picker member data reference.
//     ///
//     picker.adapter.picker = picker;

//     var v = Column(
//       mainAxisSize: MainAxisSize.min,
//       children: <Widget>[
//         (picker.hideHeader)
//             ? SizedBox()
//             : Container(
//                 ///
//                 /// JG DEBUG - Set the Container color to transpartent
//                 /// to make App look consistent.
//                 ///
//                 color: Colors.transparent,
//                 child: Row(
//                   children: _buildHeaderViews(),
//                 ),

//                 ///
//                 /// JG DEBUG - Remove the decorattion, set the Container color
//                 /// to transpartent to make App look consistent.
//                 ///
//                 // decoration: picker.headerDecoration ??
//                 //     BoxDecoration(
//                 //       border: Border(
//                 //         top: BorderSide(color: theme.dividerColor, width: 0.5),
//                 //         bottom:
//                 //             BorderSide(color: theme.dividerColor, width: 0.5),
//                 //       ),
//                 //       color: picker.headercolor == null
//                 //           ? theme.bottomAppBarColor
//                 //           : picker.headercolor,
//                 //     ),
//               ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: _buildViews(),
//         ),
//         picker.footer ?? SizedBox(width: 0.0, height: 0.0),
//       ],
//     );
//     if (widget.isModal == null || widget.isModal == false) return v;
//     return GestureDetector(
//       onTap: () {},
//       child: v,
//     );
//   }

//   List<Widget> _buildHeaderViews() {
//     if (theme == null) theme = Theme.of(context);
//     List<Widget> items = [];

//     ///
//     /// JG DEBUG - Remove the Confirm text and handler, reimplemented at high
//     /// level to make App look consistent.
//     ///
//     // if (picker.cancel != null) {
//     //   items.add(DefaultTextStyle(
//     //       style: picker.cancelTextStyle ??
//     //           TextStyle(
//     //               color: theme.accentColor,
//     //               fontSize: NewNumberPicker.DefaultTextSize),
//     //       child: picker.cancel));
//     // } else {
//     //   String _cancelText =
//     //       picker.cancelText ?? PickerLocalizations.of(context).cancelText;
//     //   if (_cancelText != null || _cancelText != "") {
//     //     items.add(
//     //       TextButton(
//     //         onPressed: () {
//     //           picker.doCancel(context);
//     //         },
//     //         child: Text(
//     //           _cancelText,
//     //           overflow: TextOverflow.ellipsis,
//     //           style: picker.cancelTextStyle ??
//     //               TextStyle(
//     //                   color: theme.accentColor,
//     //                   fontSize: NewNumberPicker.DefaultTextSize),
//     //         ),
//     //       ),
//     //     );
//     //   }
//     // }

//     items.add(Expanded(
//         child: Container(
//       // color: Colors.transparent,
//       alignment: Alignment.center,
//       child: picker.title == null
//           ? picker.title
//           : DefaultTextStyle(
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                   fontSize: NewNumberPicker.DefaultTextSize,
//                   color: theme.textTheme.headline6.color),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: picker.title,
//               )),
//     )));

//     ///
//     /// JG DEBUG - Remove the Confirm text and handler, reimplemented at high
//     /// level to make App look consistent.
//     ///
//     // if (picker.confirm != null) {
//     //   items.add(DefaultTextStyle(
//     //       style: picker.confirmTextStyle ??
//     //           TextStyle(
//     //               color: theme.accentColor,
//     //               fontSize: NewNumberPicker.DefaultTextSize),
//     //       child: picker.confirm));
//     // } else {
//     //   String _confirmText =
//     //       picker.confirmText ?? PickerLocalizations.of(context).confirmText;
//     //   if (_confirmText != null || _confirmText != "") {
//     //     items.add(
//     //       TextButton(
//     //         onPressed: () {
//     //           picker.doConfirm(context);
//     //         },
//     //         child: Text(
//     //           _confirmText,
//     //           overflow: TextOverflow.ellipsis,
//     //           style: picker.confirmTextStyle ??
//     //               TextStyle(
//     //                   color: theme.accentColor,
//     //                   fontSize: NewNumberPicker.DefaultTextSize),
//     //         ),
//     //       ),
//     //     );
//     //   }
//     // }

//     return items;
//   }

//   bool _changeing = false;
//   final Map<int, int> lastData = {};

//   List<Widget> _buildViews() {
//     if (__printDebug) print("_buildViews");
//     if (theme == null) theme = Theme.of(context);

//     List<Widget> items = [];

//     NewNumberPickerAdapter adapter = picker.adapter;
//     if (adapter != null) adapter.setColumn(-1);

//     if (adapter != null && adapter.length > 0) {
//       for (int i = 0; i < picker._maxLevel; i++) {
//         final int _length = adapter.length;

//         Widget view = new Expanded(
//           flex: adapter.getColumnFlex(i),
//           child: Container(
//             padding: picker.columnPadding,
//             height: picker.height,
//             decoration: BoxDecoration(
//               color: picker.containerColor == null
//                   ? theme.dialogBackgroundColor
//                   : picker.containerColor,
//             ),
//             child: CupertinoPicker(
//               backgroundColor: picker.backgroundColor,
//               scrollController: scrollController[i],
//               itemExtent: picker.itemExtent,
//               looping: picker.looping,
//               onSelectedItemChanged: (int index) {
//                 if (__printDebug) print("onSelectedItemChanged");
//                 // setState(() {
//                 ///
//                 /// JG - Update the notifier
//                 ///
//                 // Provider.of<LoadBarbellBlocNotifier>(context, listen: false)
//                 //     .userAddNewBarbellListCurrentIndex = index;

//                 // ///
//                 // /// Immediately trigger the event
//                 // ///
//                 // BlocProvider.of<AddUserBarbellBloc>(context)
//                 //   ..add(UserScrolledBarbellPickerEvent(context, index));

//                 picker.selecteds[i] = index;
//                 updateScrollController(i);
//                 adapter.doSelect(i, index);
//                 if (picker.changeToFirst) {
//                   for (int j = i + 1; j < picker.selecteds.length; j++) {
//                     picker.selecteds[j] = 0;
//                     scrollController[j].jumpTo(0.0);
//                   }
//                 }
//                 if (picker.onSelect != null)
//                   picker.onSelect(picker, i, picker.selecteds);
//                 // });
//               },
//               children: List<Widget>.generate(_length, (int index) {
//                 return adapter.buildItem(context, index);
//               }),
//             ),
//           ),
//         );
//         items.add(view);

//         if (!picker.changeToFirst && picker.selecteds[i] >= _length) {
//           Timer(Duration(milliseconds: 100), () {
//             if (__printDebug) print("timer last");
//             scrollController[i].jumpToItem(_length - 1);
//           });
//         }

//         adapter.setColumn(i);
//       }
//     }
//     if (picker.delimiter != null) {
//       for (int i = 0; i < picker.delimiter.length; i++) {
//         var o = picker.delimiter[i];
//         if (o.child == null) continue;
//         var item = Container(child: o.child, height: picker.height);
//         if (o.column < 0)
//           items.insert(0, item);
//         else if (o.column >= items.length)
//           items.add(item);
//         else
//           items.insert(o.column, item);
//       }
//     }
//     return items;
//   }

//   void updateScrollController(int i) {
//     if (_changeing || !picker.adapter.isLinkage) return;
//     _changeing = true;
//     for (int j = 0; j < picker.selecteds.length; j++) {
//       if (j != i) {
//         if (scrollController[j].position.maxScrollExtent == null) continue;
//         scrollController[j].position.notifyListeners();
//       }
//     }
//     _changeing = false;
//   }
// }

// ///
// /// NewNumberPickerDataAdapter
// ///
// class NewNumberPickerDataAdapter<T> extends NewNumberPickerAdapter<T> {
//   List<PickerItem<T>> data;
//   List<PickerItem<dynamic>> _datas;
//   int _maxLevel = -1;
//   int _col = 0;
//   final bool isArray;

//   NewNumberPickerDataAdapter(
//       {List pickerdata, this.data, this.isArray = false}) {
//     _parseData(pickerdata);
//   }

//   @override
//   bool getIsLinkage() {
//     return !isArray;
//   }

//   void _parseData(final List pickerData) {
//     if (pickerData != null &&
//         pickerData.length > 0 &&
//         (data == null || data.length == 0)) {
//       if (data == null)
//         //
//         // After Flutter 2.0 upgrade,
//         //
//         //  new List<PickerItem<T>>(); syntax has been deprecated
//         //
//         data = List<PickerItem<T>>.filled(0, null, growable: true);
//       //
//       if (isArray) {
//         _parseArrayPickerDataItem(pickerData, data);
//       } else {
//         _parsePickerDataItem(pickerData, data);
//       }
//     }
//   }

//   _parseArrayPickerDataItem(List pickerData, List<PickerItem> data) {
//     if (pickerData == null) return;
//     for (int i = 0; i < pickerData.length; i++) {
//       var v = pickerData[i];
//       if (!(v is List)) continue;
//       List lv = v;
//       if (lv.length == 0) continue;

//       //
//       // After Flutter 2.0 upgrade,
//       //
//       // PickerItem<T>(children: List<PickerItem<T>>());
//       // syntax has been deprecated
//       //
//       PickerItem item = new PickerItem<T>(
//           children: List<PickerItem<T>>.filled(0, null, growable: true));

//       data.add(item);

//       for (int j = 0; j < lv.length; j++) {
//         var o = lv[j];
//         if (o is T) {
//           item.children.add(new PickerItem<T>(value: o));
//         } else if (T == String) {
//           String _v = o.toString();
//           item.children.add(new PickerItem<T>(value: _v as T));
//         }
//       }
//     }
//     if (__printDebug) print("data.length: ${data.length}");
//   }

//   _parsePickerDataItem(List pickerData, List<PickerItem> data) {
//     if (pickerData == null) return;
//     for (int i = 0; i < pickerData.length; i++) {
//       var item = pickerData[i];
//       if (item is T) {
//         data.add(new PickerItem<T>(value: item));
//       } else if (item is Map) {
//         final Map map = item;
//         if (map.length == 0) continue;

//         List<T> _mapList = map.keys.toList();
//         for (int j = 0; j < _mapList.length; j++) {
//           var _o = map[_mapList[j]];
//           if (_o is List && _o.length > 0) {
//             //
//             // After Flutter 2.0 upgrade,
//             //
//             //  new List<PickerItem<T>>(); syntax has been deprecated
//             //
//             List<PickerItem> _children =
//                 List<PickerItem<T>>.filled(0, null, growable: true);
//             // new List<PickerItem<T>>();
//             //print('add: ${data.runtimeType.toString()}');
//             data.add(
//                 new PickerItem<T>(value: _mapList[j], children: _children));
//             _parsePickerDataItem(_o, _children);
//           }
//         }
//       } else if (T == String && !(item is List)) {
//         String _v = item.toString();
//         //print('add: $_v');
//         data.add(new PickerItem<T>(value: _v as T));
//       }
//     }
//   }

//   void setColumn(int index) {
//     _col = index + 1;
//     if (isArray) {
//       if (__printDebug) print("index: $index");
//       if (index + 1 < data.length)
//         _datas = data[index + 1].children;
//       else
//         _datas = null;
//       return;
//     }
//     if (index < 0) {
//       _datas = data;
//     } else {
//       var _select = picker.selecteds[index];
//       if (_datas != null && _datas.length > _select)
//         _datas = _datas[_select].children;
//       else
//         _datas = null;
//     }
//   }

//   @override
//   int getLength() {
//     return _datas == null ? 0 : _datas.length;
//   }

//   @override
//   getMaxLevel() {
//     if (_maxLevel == -1) _checkPickerDataLevel(data, 1);
//     return _maxLevel;
//   }

//   @override
//   Widget buildItem(BuildContext context, int index) {
//     final PickerItem item = _datas[index];
//     if (item.text != null) {
//       return item.text;
//     }
//     return makeText(item.text, item.text != null ? null : item.value.toString(),
//         index == picker.selecteds[_col]);
//   }

//   @override
//   void initSelects() {
//     if (picker.selecteds == null || picker.selecteds.length == 0) {
//       if (picker.selecteds == null)
//         //
//         // JG Updated - After Flutter 2.0 upgrade,
//         //
//         //  new List<int>(); syntax has been deprecated
//         //
//         picker.selecteds = List<int>.filled(0, null, growable: true);
//       // new List<int>();
//       for (int i = 0; i < _maxLevel; i++) picker.selecteds.add(0);
//     }
//   }

//   @override
//   List<T> getSelectedValues() {
//     List<T> _items = [];
//     if (picker.selecteds != null) {
//       if (isArray) {
//         for (int i = 0; i < picker.selecteds.length; i++) {
//           int j = picker.selecteds[i];
//           if (j < 0 || data[i].children == null || j >= data[i].children.length)
//             break;
//           _items.add(data[i].children[j].value);
//         }
//       } else {
//         List<PickerItem<dynamic>> datas = data;
//         for (int i = 0; i < picker.selecteds.length; i++) {
//           int j = picker.selecteds[i];
//           if (j < 0 || j >= datas.length) break;
//           _items.add(datas[j].value);
//           datas = datas[j].children;
//           if (datas == null || datas.length == 0) break;
//         }
//       }
//     }
//     return _items;
//   }

//   _checkPickerDataLevel(List<PickerItem> data, int level) {
//     if (data == null) return;
//     if (isArray) {
//       _maxLevel = data.length;
//       return;
//     }
//     for (int i = 0; i < data.length; i++) {
//       if (data[i].children != null && data[i].children.length > 0)
//         _checkPickerDataLevel(data[i].children, level + 1);
//     }
//     if (_maxLevel < level) _maxLevel = level;
//   }
// }
