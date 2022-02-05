import 'package:flutter/material.dart';

import 'my_widgets/home_widget.dart';

void main(List<String> args) {
  runApp(const AppOne());
}

class AppOne extends StatelessWidget {
  const AppOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppOne',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
            leading: const Image(
                image: NetworkImage(
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e5/NASA_logo.svg/2449px-NASA_logo.svg.png')),
            title: const Text('APOD'),
            toolbarHeight: 40.0,
            leadingWidth: 50.0,
            foregroundColor: Colors.white,
            centerTitle: true,
            backgroundColor: Colors.blueGrey),
        body: const HomeWidget(),
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
