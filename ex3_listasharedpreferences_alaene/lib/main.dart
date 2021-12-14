// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  static String theme = "light"; 
  static bool isDark = false;
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(theme == 'light'? ThemeMode.light : ThemeMode.dark);

  @override
  Widget build(BuildContext context) {
    getTheme();
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
    return MaterialApp(
      title: 'Shared Preferences',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
       darkTheme: ThemeData(
        brightness: Brightness.dark,
         primarySwatch: Colors.purple,
       ),
       themeMode: currentMode,
      
      home: const MyHomePage(title: 'Shared Preferences'),
    );
        });
  }

  Future<void> getTheme() async {
      theme = await StorageManager.getTheme()  as String;
      themeNotifier.value = theme == 'light' ?  ThemeMode.light : ThemeMode.dark;
  }

}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class StorageManager {
  static void saveData(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }
  

  static Future<bool> deleteData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  static Future<String?> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("themeMode");
  }
}

class _MyHomePageState extends State<MyHomePage> {
 

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.title)),
        actions: [
            PopupMenuButton(
                 itemBuilder: (BuildContext bc) => <PopupMenuEntry>[
                  PopupMenuItem(
                    child: Text("Selecione o Tema"),
                    value: 1,
                  ),
                  PopupMenuDivider(),
                  CheckedPopupMenuItem(
                    child: Text("Light"),
                    value: "Light",
                    checked: !MyApp.isDark,
                  ),
                  CheckedPopupMenuItem(
                    child: Text("Dark"),
                    value: "Dark",
                    checked: MyApp.isDark,
                  )
                ],
            
            onSelected: (result) {
              if (result == "Light") {
                StorageManager.saveData('themeMode', 'light');
                MyApp.themeNotifier.value = ThemeMode.light;
                MyApp.isDark  = false;
              }
              else {
                StorageManager.saveData('themeMode', 'dark');
                MyApp.themeNotifier.value = ThemeMode.dark;
                MyApp.isDark  = true;
              }
}),
        ]
      )
    );
  }
}
