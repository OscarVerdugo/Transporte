import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:app/utils/Routes.dart';
import 'package:app/preferences/user_preferences.dart';

import 'api/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((v) async {
    UserPreferences prefs = new UserPreferences();
    await prefs.initPrefs();
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AuthProvider())
        ],
        child: ChangeNotifierProvider(
          create: (BuildContext c) => AuthProvider(),
          child: Consumer(
            builder: (BuildContext c, AuthProvider auth, _) {
              print(RoutesByStatus[auth.status]);
              return MaterialApp(
                title: 'Material App',
                debugShowCheckedModeBanner: false,
                routes: Routes,
                initialRoute: RoutesByStatus[auth.status],
              );
            },
          ),
        ));
  }
}
