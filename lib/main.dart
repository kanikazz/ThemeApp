import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theme_app/helper/AppTheme.dart';
import 'package:theme_app/helper/AppTypography.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // 1. Provide AppTheme above the MaterialApp, so it will be available on all pages.
      create: (_) => AppTheme(AppTheme.myTheme),
      builder: (context, _) => MaterialApp(
        title: 'Flutter Demo',
        theme: Provider.of<AppTheme>(context).getTheme(),
        debugShowCheckedModeBanner: false,
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void updateThemeMode(ThemeData themeMode) {
    context.read<AppTheme>().setTheme(themeMode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.appColors.background,
      appBar: AppBar(
        backgroundColor: context.theme.appColors.primary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
              // Usage of custom typography with text theme extension.
              style: AppTypography.body1.copyWith(
                color: context.theme.appColors.primary,
              ),
            ),
            Text(
              '$_counter',
              // Usage of custom typography without text theme extension.
              style: AppTypography.h1.copyWith(
                color: context.theme.appColors.primary,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => updateThemeMode(AppTheme.light),
                  child: const Text('Light'),
                ),
                TextButton(
                  onPressed: () => updateThemeMode(AppTheme.dark),
                  child: const Text('Dark'),
                ),
                TextButton(
                  onPressed: () => updateThemeMode(AppTheme.myTheme),
                  child: const Text('My Theme'),
                ),
                TextButton(
                  onPressed: () => updateThemeMode(AppTheme.blackTheme),
                  child: const Text('Black Theme'),
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        backgroundColor: context.theme.appColors.primary,
        foregroundColor: context.theme.appColors.onPrimary,
        child: const Icon(Icons.add),
      ),
    );
  }
}