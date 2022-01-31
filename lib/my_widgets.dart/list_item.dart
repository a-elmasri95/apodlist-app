import 'package:flutter/material.dart';

class MyListItem extends StatelessWidget {
  const MyListItem({Key? key, this.dataRes = 'Empty Response'})
      : super(key: key);
  final String dataRes;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(20.0),
      child: Text(dataRes),
    );
  }
}
