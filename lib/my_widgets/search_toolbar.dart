import 'package:flutter/material.dart';

typedef StringCallback = void Function(String val);

class SearchToolBar extends StatefulWidget {
  const SearchToolBar({
    Key? key,
    required this.updateList,
    required this.callBack,
    required this.callBackTwo,
  }) : super(key: key);
  final VoidCallback updateList;
  final StringCallback callBack;
  final StringCallback callBackTwo;

  @override
  State<SearchToolBar> createState() => _SearchToolBarState();
}

class _SearchToolBarState extends State<SearchToolBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFF434848),
      alignment: Alignment.center,
      height: 45.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            width: 10,
          ),
          Flexible(
            child: ElevatedButton(
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime(2018, 1, 1),
                  firstDate: DateTime(2010),
                  lastDate: DateTime.now(),
                ).then((date) {
                  widget.callBack(date.toString());
                });
              },
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: const BorderSide(color: Colors.white))),
                  padding: MaterialStateProperty.all(const EdgeInsets.all(6.0)),
                  textStyle: MaterialStateProperty.all<TextStyle>(
                    const TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    const Color(0xFFF7F8F8),
                  )),
              child: const Text(
                'Start Date',
                style: TextStyle(
                  fontSize: 10.0,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            child: ElevatedButton(
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime(2018, 1, 1),
                  firstDate: DateTime(2010),
                  lastDate: DateTime.now(),
                ).then((date) {
                  widget.callBackTwo(date.toString());
                });
              },
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: const BorderSide(color: Colors.white))),
                  padding: MaterialStateProperty.all(const EdgeInsets.all(6.0)),
                  textStyle: MaterialStateProperty.all<TextStyle>(
                    const TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    const Color(0xFFF7F8F8),
                  )),
              child: const Text(
                'End Date',
                style: TextStyle(
                  fontSize: 10.0,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 200,
          ),
          IconButton(
            iconSize: 28,
            onPressed: widget.updateList,
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
