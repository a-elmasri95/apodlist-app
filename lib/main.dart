import 'package:app_one/utils/colors.dart';
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
            leading: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            title: const Text(
              'Dashboard',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal),
            ),
            centerTitle: true,
            backgroundColor: AppColors.royalBlue),
        body: const HomeWidget(),
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
