import 'dart:io';

import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/bloc/preference_bloc.dart';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/notifiers/preference_notifier.dart';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/widgets/grouped_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const SettingsPage(),
      );
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final blocPrefs = Provider.of<PreferenceProvider>(context).bloc;

    return StreamBuilder<Object>(
        stream: blocPrefs.brightness,
        builder: (context, snapshotBrightness) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  ///
                  /// Save the preferences.
                  ///
                  gSharedPrefs.savePreferences();
                  Navigator.of(context).pop();
                },
              ),
              title: const Text('SETTINGS'),
              backgroundColor: Colors.deepPurpleAccent,
              flexibleSpace: Container(
                height:
                    80 + (((Platform.isIOS) == true) ? kToolbarHeight : 0.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: (snapshotBrightness.data == Brightness.light)
                          ? [Color(0xFFaaaaaa), Color(0xFFeeeeee)]
                          : [Color(0xFF485563), Color(0xFF29323C)],
                      // [Color(0xFF485563), Color(0xFF29323C)],
                      tileMode: TileMode.clamp,
                      begin: Alignment.topCenter,
                      stops: [0.0, 1.0],
                      end: Alignment.bottomCenter),
                ),
              ),
            ),
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: (snapshotBrightness.data == Brightness.light)
                        ? [Color(0xFFaaaaaa), Color(0xFFeeeeee)]
                        : [Color(0xFF485563), Color(0xFF29323C)],
                    // [Color(0xFF485563), Color(0xFF29323C)],
                    tileMode: TileMode.clamp,
                    begin: Alignment.topCenter,
                    stops: [0.0, 1.0],
                    end: Alignment.bottomCenter),
              ),
              child: DumbbellSetCheckboxList(),
            ),
          );
        });
  }
}
