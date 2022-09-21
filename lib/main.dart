import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import './pages/favorites_page.dart';
import './providers/favorites.dart';
import './providers/filters.dart';
import './pages/credits_page.dart';
import './pages/dimore_page.dart';
import './pages/filters_page.dart';
import './pages/itinerari_page.dart';
import "./pages/intro_dimora_page.dart";
import './pages/home_page.dart';
import './pages/dimora_details_page.dart';
import './pages/servizi_page.dart';
import './pages/itinerario_details_page.dart';
import './pages/servizio_details_page.dart';
import './utils/colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Favorites()),
        ChangeNotifierProvider(create: (ctx) => Filters()),
      ],
      child: MaterialApp(
        title: 'Castelturismo',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        supportedLocales: const [
          Locale('it'),
          Locale('en'),
          Locale('es'),
          Locale('de'),
        ],
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
          primarySwatch: whiteSwatch,
          appBarTheme: const AppBarTheme(
            foregroundColor: Colors.white,
            backgroundColor: Colors.black,
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.black,
          ),
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: Colors.white,
                displayColor: Colors.white,
                fontFamily: "Ubuntu",
              ),
        ),
        home: const HomePage(),
        routes: {
          "/filters": (context) => const FiltersPage(),
          "/itinerari": (context) => const ItinerariPage(),
          "/itinerario": (context) => const ItinerarioDetailsPage(),
          "/credits": (context) => const CreditsPage(),
          "/dimore": (context) => const DimorePage(),
          "/intro-dimora": (context) => const IntroDimoraPage(),
          "/dimora-details": (context) => const DimoraDetailsPage(),
          "/servizi": (context) => const ServiziPage(),
          "/servizio": (context) => const ServizioPage(),
          "/favorites": (context) => const FavoritesPage(),
        },
        // onGenerateRoute: (settings) {
        //   if (settings.name == "/dimora-details") {
        //     return PageRouteBuilder(
        //       settings: settings,
        //       pageBuilder: (_, __, ___) => const DimoraDetailsPage(),
        //       transitionsBuilder: (_, a, __, c) => SlideTransition(
        //         position: Tween(
        //           begin: const Offset(0.0, 1.0),
        //           end: Offset.zero,
        //         ).animate(
        //           CurvedAnimation(
        //             parent: a,
        //             curve: const Interval(0, 0.70, curve: Curves.linear),
        //           ),
        //         ),
        //         child: c,
        //       ),
        //     );
        //   }
        //   // Unknown route
        //   return MaterialPageRoute(builder: (_) => const HomePage());
        // },
      ),
    );
  }
}
