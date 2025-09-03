///
/// Special Information 2/8/2025:
///
/// The following code is the main entry point of the application.
/// It initializes the application and runs the main widget.
/// The main widget is the root of the application's widget tree.
///
/// To rename the App name, activate and use the command line "rename" tool:
///
/// flutter pub global activate rename
///
/// rename help setBundleId
/// flutter pub global run rename setBundleId --value "com.weightloader.pexl"
///
/// or,
///
/// rename setAppName --value "dumbbell_app"
/// rename setBundleId --value "com.example.dumbbell_app"
///
/// For help using rename tool:
/// rename --help setAppName
/// rename --help setBundleId
///

import 'package:dumbbell_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:dumbbell_app/core/theme/theme.dart';
import 'package:dumbbell_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dumbbell_app/features/auth/presentation/pages/login_page.dart';
// import 'package:dumbbell_app/features/barbell_calc/1presentation/pages/loadbarbellcalc_view.dart';
import 'package:dumbbell_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:dumbbell_app/features/blog/presentation/pages/blog_page.dart';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/bloc/preference_bloc.dart';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/bloc/weightrack_bloc.dart';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/globals/globals.dart';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/notifiers/barbelldisplaylist_notifier.dart';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/notifiers/loadbarbell_notifier.dart';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/notifiers/menu_notifier.dart';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/notifiers/preference_notifier.dart';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/notifiers/weightrack_notifier.dart';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/pages/loadbarbell_view.dart';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/pages/settings_view.dart';
import 'package:dumbbell_app/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        ChangeNotifierProvider<PreferenceProvider>.value(
          value: PreferenceProvider(),
        ),
        // Add this line in if AuthBloc and BlogBloc is used.
        BlocProvider(
          create: (_) => serviceLocator<AppUserCubit>(),
        ),
        // Add this line in if AuthBloc and BlogBloc is used.
        BlocProvider(
          create: (_) => serviceLocator<AuthBloc>(),
        ),
        // Add this line in if AuthBloc and BlogBloc is used.
        BlocProvider(
          create: (_) => serviceLocator<BlogBloc>(),
        ),

        BlocProvider(
          create: (_) => serviceLocator<WeightrackBloc>(),
        ),
      ],
      child: MultiProvider(
        providers: [
          // ///
          // /// My own MainMeuWorkoutsEnum notifier, the globals MenuNotifier.statePageSelected
          // /// and MenuNotifier.statePreviousPage are utilized by the Home, Wendler, Hatch,
          // /// WeightRack, and LoadBarbell views/pages.
          // ///
          // /// Special Informmation (08/20/2020):
          // ///
          // /// Added to MenuNotifier the FilledStacks Completer, DialogManager, and DialogService
          // /// implementation, this allows Alert dialog box to be displayed
          // /// outside the Widget Tree build context.
          // ///
          // ChangeNotifierProvider<MenuNotifier>.value(
          //   value: MenuNotifier(),
          // ),
          // Global Weight Rack Information.
          // Used by the _WeightRackViewState and _AnimatedBarbellState states.
          //
          ChangeNotifierProvider<WeightRackBlocNotifier>.value(
            value: WeightRackBlocNotifier(),
          ),
          //
          // Global LoadBarbellView header information
          // i.e. Title, Working Set information (Percent x Reps of 1RM)
          // Global Barbell In Use Information.
          // Used by the LoadBarbelView page.
          //
          ChangeNotifierProvider<LoadBarbellBlocNotifier>.value(
            value: LoadBarbellBlocNotifier(),
          ),
          //
          // Global barbell and plates display list used in the LoadBarbellView and
          // AnimatedBarbell logic.  i.e.
          //
          // _LoadBarbellViewState._barbell._AnimatedBarbellState._dispayList[] of [_barbell, _platesList[0], ..., _platesList[n]]
          //
          ChangeNotifierProvider<BarbellDisplayListBlocNotifier>.value(
            value: BarbellDisplayListBlocNotifier(),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    //
    // TODO: Add this line in if AuthBloc is used.
    // context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }

  int _currentIndex = 0;

  final List<Widget> _pages = [
    const BlogPage(), //LoginPage(),
    const LoadBarbellView(),
    // const LoadBarbellCalcView(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    ///
    /// Lock the orientation to Portrait mode.
    ///
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    ///
    /// Save device dimensions
    ///
    gDeviceWidth = MediaQuery.of(context).size.width;
    gDeviceHeight = MediaQuery.of(context).size.height;
    gBarbellHeight = (gDeviceHeight * .025).floorToDouble();

    gDumbbellDisplayAreaWidth = MediaQuery.of(context).size.width;
    // gDumbbellDisplayAreaWidth = MediaQuery.of(context).size.width - 16;

    gDumbbellContainerAreaHeight =
        // (MediaQuery.of(context).padding.top - kToolbarHeight) * .18;
        (MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                kToolbarHeight) *
            .24;
    // .34;

    ///
    /// Save Dumbbell/Barbell display area dimensions
    ///
    /// double displayAreaHeight = ((MediaQuery.of(context).size.height -
    gDumbbellDisplayAreaHeight =
        // (MediaQuery.of(context).padding.top - kToolbarHeight) * .18;
        (MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                kToolbarHeight) *
            .20; // Larger than the height of AnimatedContainer of ".15"
    gDumbbellDisplayAreaHeight = gDumbbellDisplayAreaHeight.floorToDouble();

    gDumbbellDisplayAreaRotatedHeight = (MediaQuery.of(context).size.width -
            MediaQuery.of(context).padding.top -
            kToolbarHeight) *
        .15;
    gDumbbellDisplayAreaRotatedHeight =
        gDumbbellDisplayAreaRotatedHeight.floorToDouble();

    // To get height just of SafeArea (for iOS 11 and above):
    var padding = MediaQuery.of(context).padding;
    gDeviceNewHeight = gDeviceHeight - padding.top - padding.bottom;

    gDeviceNewRotatedHeight = gDeviceWidth - padding.top - padding.bottom;

    return Consumer<PreferenceProvider>(builder: (context, provider, child) {
      return StreamBuilder<Brightness>(
          stream: provider.bloc.brightness,
          builder: (context, snapshotBrightness) {
            if (!snapshotBrightness.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            // return MaterialApp(
            //   debugShowCheckedModeBanner: false,
            //   title: 'Iron Master Dumbbell App',
            //   // theme: AppTheme.ironMasterThemeMode,
            //   // theme: (snapshotBrightness.data == Brightness.dark)
            //   //     ? AppTheme.darkThemeMode
            //   //     : AppTheme.ironMasterThemeMode,
            //   home: BlocSelector<AppUserCubit, AppUserState, bool>(
            //     selector: (state) {
            //       return state is AppUserLoggedIn;
            //     },
            //     builder: (context, isLoggedIn) {
            //       if (isLoggedIn) {
            //         // return const BlogPage();
            //         // return LoadBarbellView();
            //         return Scaffold(
            //           body: IndexedStack(
            //             index: _currentIndex,
            //             children: _pages,
            //           ),
            //           bottomNavigationBar: BottomNav(
            //             currentIndex: _currentIndex,
            //             onTap: (index) {
            //               setState(() {
            //                 _currentIndex = index;
            //               });
            //             },
            //           ),
            //         );
            //       }
            //       return const LoginPage();
            //     },
            //   ),
            // );

            // return MaterialApp(
            //   debugShowCheckedModeBanner: false,
            //   title: 'Iron Master Dumbbell App',
            //   // theme: AppTheme.ironMasterThemeMode,
            //   theme: (snapshotBrightness.data == Brightness.dark)
            //       ? AppTheme.darkThemeMode
            //       : AppTheme.ironMasterThemeMode,
            //   home: Scaffold(
            //     body: IndexedStack(
            //       index: _currentIndex,
            //       children: _pages,
            //     ),
            //     bottomNavigationBar: BottomNav(
            //       currentIndex: _currentIndex,
            //       onTap: (index) {
            //         setState(() {
            //           _currentIndex = index;
            //         });
            //       },
            //     ),
            //   ),
            // );

            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'PEXL App',
              // theme: AppTheme.ironMasterThemeMode,
              theme: (snapshotBrightness.data == Brightness.dark)
                  ? AppTheme.darkThemeMode
                  : AppTheme.ironMasterThemeMode,
              home: Scaffold(
                body: IndexedStack(
                  index: _currentIndex,
                  children: _pages,
                ),
                bottomNavigationBar: BottomNav(
                  currentIndex: _currentIndex,
                  onTap: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
              ),
              // BlocSelector<AppUserCubit, AppUserState, bool>(
              //   selector: (state) {
              //     return state is AppUserLoggedIn;
              //   },
              //   builder: (context, isLoggedIn) {
              //     if (isLoggedIn) {
              //       // return const BlogPage();
              //       return LoadBarbellView();
              //     }
              //     return const LoginPage();
              //   },
              // ),
            );
          });
    });
  }
}

class BottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNav({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      destinations: [
        const NavigationDestination(
          icon: Icon(Icons.sports_gymnastics),
          label: 'Logs',
        ),
        NavigationDestination(
          icon: Icon(Icons.fitness_center),
          //     Image.asset(
          //   "lib/features/ironmaster_dumbbells/assets/icons/main_logo.png",
          //   width: 48,
          //   height: 48,
          // ),
          label: 'Load Dumbbell',
        ),
        // const NavigationDestination(
        //   icon: Icon(Icons.fitness_center),
        //   label: 'Barbell Calc',
        // ),
        const NavigationDestination(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }
}
