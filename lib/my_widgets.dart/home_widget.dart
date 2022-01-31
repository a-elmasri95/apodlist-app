import 'package:flutter/material.dart';

class HomeWidget extends StatelessWidget {
  final List<Widget> outputList;
  const HomeWidget({
    Key? key,
    required this.outputList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://images.unsplash.com/photo-1585314062340-f1a5a7c9328d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          shrinkWrap: false,
          padding: const EdgeInsets.all(20.0),
          children: outputList,
        ),
      ),
    );
  }
}
