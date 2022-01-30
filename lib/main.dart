import 'package:app_one/utils/colors.dart';
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
  void initState() {
    super.initState();
  }

  void onClick() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'AppOne',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('AppOne'),
            centerTitle: true,
            backgroundColor: AppColors.mintGreen,
          ),
          body: SafeArea(
            child: Container(),
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.account_tree_outlined),
            onPressed: onClick,
          ),
          resizeToAvoidBottomInset: true,
        ));
  }
}
