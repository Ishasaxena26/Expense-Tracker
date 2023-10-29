import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses.dart';
import 'package:flutter/services.dart'; //this is used for settig the orientation of the app

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);

var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness
      .dark, //tells flutter that this color will be applied to dark theme
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

void main() {
  /* WidgetsFlutterBinding
      .ensureInitialized(); //ensures locking the orientation and running of UI
  SystemChrome.setPreferredOrientations([
    DeviceOrientation
        .portraitUp, //even if device is rotated ..the app will not rotate
  ]).then((fn) { */ //fn is a func....but we need do anything with that
  //runApp is placed here so that the app only starts once the orientation is set ..
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kDarkColorScheme,
        cardTheme: const CardTheme().copyWith(
          color: kDarkColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          //isme copyWith nhi lagra kyunki yeh is format se likhte hai
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.primaryContainer,
            foregroundColor: kDarkColorScheme.onPrimaryContainer,
          ),
        ),
      ),
      theme: ThemeData().copyWith(
        useMaterial3: true,
        //scaffoldBackgroundColor: Color.fromARGB(255, 49, 162, 194),

        //copyWith is used so that we can overwrite certain properties and rest properties are provided by flutter
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          //isme copyWith nhi lagra kyunki yeh is format se likhte hai
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.bold,
                color: kColorScheme.onSecondaryContainer,
                fontSize: 17,
              ),
            ),
      ),
      //   themeMode:ThemeMode.system ,//default
      home: const Expenses(), //expenses widget from expenses.dart file
    ),
  );
}
//   );
// }
