import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/globals/globals.dart';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/models/commonSwitch_model.dart';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/models/ironmaster_selection_model.dart';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/notifiers/preference_notifier.dart';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/utils/ironmaster_dbell_set.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/models/commonSwitch_model.dart';
// import 'package:pexlapp/preference_notifier.dart';
// import 'package:pexlapp/blocs/commonSwitch_bloc.dart';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/notifiers/weightrack_notifier.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:provider/provider.dart';

///////////////////////////////////////////////////////////////////////////
//
// Widget commonDisplayWeightRackSwitch
//
///////////////////////////////////////////////////////////////////////////
// Widget commonDisplayWeightRackSwitch(BuildContext context, double leftOffset) {
//   CommonSwitchClass theSwitch =
//       Provider.of<WeightRackBlocNotifier>(context, listen: false)
//           .weightRackSelectionSwitch;

//   return Row(
//     // mainAxisAlignment: MainAxisAlignment.end,
//     // crossAxisAlignment: CrossAxisAlignment.end,
//     children: <Widget>[
//       // Padding(
//       //   padding: EdgeInsets.all(10),
//       // ),
//       Padding(
//         padding: EdgeInsets.only(left: leftOffset), //100),
//       ),
//       Text(
//         theSwitch.title.toString(),
//         style: TextStyle(color: Colors.black),
//       ),

//       ///
//       // Spacer(flex:20),
//       ///
//       Padding(
//         padding: EdgeInsets.only(left: 5),
//       ),
//       Text(
//         theSwitch.onName.toString(),
//         style: TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
//       ),
//       Switch(
//         value: theSwitch.isSwitchedOn,
//         onChanged: (value) {
//           theSwitch.isSwitchedOn = value;
//           // Update to invoke notifyListeners().
//           Provider.of<WeightRackBlocNotifier>(context, listen: false)
//               .weightRackSelectionSwitch = theSwitch;
//         },
//         activeTrackColor: Colors.green,
//         activeColor: Colors.lightGreenAccent,
//         inactiveTrackColor: Colors.green,
//         inactiveThumbColor: Colors.lightGreenAccent,
//       ),
//       Text(
//         theSwitch.offName.toString(),
//         style: TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
//       ),
//       Spacer(flex: 4),
//     ],
//   );
// }

///////////////////////////////////////////////////////////////////////////
//
// Widget _rowSwitch
//
///////////////////////////////////////////////////////////////////////////
Widget _rowSwitch(BuildContext context, CommonSwitchClass theSwitch) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    // crossAxisAlignment: CrossAxisAlignment.end,
    children: <Widget>[
      // Padding(
      //   padding: EdgeInsets.only(left: 100),
      // ),
      Text(
        theSwitch.title.toString(),
        style:
            TextStyle(color: Colors.orange[200], fontSize: 14), //Colors.black),
      ),

      ///
      // Spacer(flex:20),
      ///
      Padding(
        padding: EdgeInsets.only(left: 5),
      ),
      Text(theSwitch.onName.toString(),
          style: TextStyle(color: Colors.orange[200], fontSize: 14)
          // TextStyle(
          //     color: Theme.of(context).primaryColor, //Colors.black,
          //     fontStyle: FontStyle.italic),
          ),
      Switch(
        value: theSwitch.isSwitchedOn,
        onChanged: (value) {
          // theSwitch.callbackFunc(context, value);

          theSwitch.isSwitchedOn = value;
          // Update to invoke notifyListeners().
          if (theSwitch ==
              Provider.of<WeightRackBlocNotifier>(context, listen: false)
                  .weightRackSelectionSwitch) {
            Provider.of<WeightRackBlocNotifier>(context, listen: false)
                .weightRackSelectionSwitch = theSwitch;
          } else if (theSwitch ==
              Provider.of<WeightRackBlocNotifier>(context, listen: false)
                  .kiloPoundsSelectionSwitch) {
            Provider.of<WeightRackBlocNotifier>(context, listen: false)
                .kiloPoundsSelectionSwitch = theSwitch;
          } else if (theSwitch ==
              Provider.of<PreferenceProvider>(context, listen: false)
                  .colorThemeSwitch) {
            Provider.of<PreferenceProvider>(context, listen: false)
                .setColorThemeSwitchithContext(context, theSwitch);
          }
        },
        activeTrackColor: Theme.of(context).primaryColor,
        activeColor: Theme.of(context).colorScheme.secondary,
        inactiveTrackColor: Theme.of(context).colorScheme.secondary,
        inactiveThumbColor: Theme.of(context).primaryColor,
      ),
      Text(theSwitch.offName.toString(),
          style: TextStyle(color: Colors.orange[200], fontSize: 14)
          // TextStyle(
          //     color: Theme.of(context).primaryColor, //Colors.black,
          //     fontStyle: FontStyle.italic),
          ),
      // Spacer(flex: 4),
    ],
  );
}

///////////////////////////////////////////////////////////////////////////
//
// Widget commonSwitch
//
///////////////////////////////////////////////////////////////////////////
Widget commonSwitch(BuildContext context, CommonSwitchClass theSwitch,
    {bool border = false}) {
  return (border == false)
      ? _rowSwitch(context, theSwitch)
      : (Container(
          margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(3.0),
          decoration:
              BoxDecoration(border: Border.all(color: Colors.orange[200]!)),
          child: _rowSwitch(context, theSwitch),
        ));
}

///////////////////////////////////////////////////////////////////////////
//
// Widget commonIronMasterDumbbellSwitch
//
///////////////////////////////////////////////////////////////////////////
Widget commonIronMasterDumbbellSwitch(BuildContext context) {
  //, IronMasterDumbbellSetClass theIronMasterDbSet) {
  return MultiSelectContainer(
      maxSelectableCount: 1,
      singleSelectedItem: true,
      isMaxSelectableWithPerpetualSelects: true,
      showInListView: false,
      listViewSettings: ListViewSettings(
          scrollDirection: Axis.horizontal,
          separatorBuilder: (_, __) => const SizedBox(
                width: 10,
              )),
      items: [
        MultiSelectCard(value: '45lb Set', label: '45lb IronMaster Set'),
        MultiSelectCard(value: '75lb Set', label: '75lb IronMaster Set'),
        MultiSelectCard(value: '120lb Set', label: '120lb IronMaster Set'),
        MultiSelectCard(value: '165lb Set', label: '165lb IronMaster Set'),
        MultiSelectCard(value: 'MoJeer 20kg Set', label: 'MoJeer 20kg Set'),
        MultiSelectCard(value: 'MoJeer 40kg Set', label: 'MoJeer 40kg Set'),
      ],
      onChange: (allSelectedItems, selectedItem) {
        if (kDebugMode) {
          print('selectedItem = $selectedItem');
        }
        Provider.of<WeightRackBlocNotifier>(context, listen: false)
            .dumbbellSet = gGetDumbbellSetIndex(selectedItem);

        // Set maxes
        gIronMasterWeightMaxIndex = gGetDumbbellSetMaxIndex(context);
        Provider.of<WeightRackBlocNotifier>(
          context,
          listen: false,
        ).ironMasterBottomViewWeightIndex = gIronMasterWeightMaxIndex;

        gIronMasterBottomViewWeightIndex = gIronMasterWeightMaxIndex;
      });
}
