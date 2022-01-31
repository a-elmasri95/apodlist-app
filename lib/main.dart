import 'package:app_one/my_widgets.dart/home_widget.dart';
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
            title: const Text(
              'AppOne',
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal),
            ),
            centerTitle: true,
            backgroundColor: Colors.black),
        body: const HomeWidget(
          //try DISPLAYING DIFFERENT WIDGETSSSSSSSS IN LISTVIEW
          // USE LISTBUILDER TO DYNAMICALLY POPULATE A LISTVIEW
          outputList: [
            Text('Hello'),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.account_tree_outlined),
          backgroundColor: AppColors.mintGreen,
          onPressed: onClick,
        ),
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
