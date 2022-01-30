import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(const AppOne());
}

class AppOne extends StatefulWidget {
  const AppOne({Key? key}) : super(key: key);

  @override
  _AppOneState createState() => _AppOneState();
}

class _AppOneState extends State<AppOne> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'AppOne',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: Scaffold(
          appBar: null,
          body: null,
          floatingActionButton: null,
          resizeToAvoidBottomInset: true,
        ));
  }
}
