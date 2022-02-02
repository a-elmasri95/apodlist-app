import 'dart:convert';

import 'package:app_one/web_data/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final PageController pageController = PageController();
  final ScrollController scrollController = ScrollController();
  late Future<List<Model>> models;

  @override
  void initState() {
    super.initState();
    models = fetchModel();
    scrollController.addListener(() {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Scrolling...')));
    });
  }

  refreshPage() {
    setState(() {});
  }

  Future<List<Model>> fetchModel() async {
    List<Model> modelList = [];
    final response =
        await get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if (response.statusCode == 200) {
      var list = jsonDecode(response.body);
      for (var i = 0; i < list.length; i++) {
        modelList.add(Model.fromJson(list[i]));
      }
      return modelList; //though this returns JSONArray and not object after jsonDecode
    } else {
      throw Exception('Failed to load the models');
    }
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<DataRow> _retrievedData = [];
    bool rowFill = true;

    return SafeArea(
        top: true,
        child: PageView.builder(
          physics: const BouncingScrollPhysics(),
          scrollBehavior: const CupertinoScrollBehavior(),
          scrollDirection: Axis.horizontal,
          controller: pageController,
          itemBuilder: (context, position) {
            if (position == 0) {
              return Container(
                color: Colors.white,
                child: FutureBuilder<List<Model>>(
                  future: models,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        controller: scrollController,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                              textColor: Colors.black,
                              title: Text(snapshot.data![index].id.toString()));
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return const CircularProgressIndicator();
                  },
                ),
              );
            } else {
              return Container(
                color: Colors.black,
                child: SingleChildScrollView(
                  child: DataTable(
                    headingRowColor:
                        MaterialStateProperty.all(Colors.amberAccent),
                    headingRowHeight: 30.0,
                    sortColumnIndex: 0,
                    showCheckboxColumn: true,
                    dataRowColor: MaterialStateProperty.all(Colors.white),
                    dataRowHeight: 20.0,
                    dataTextStyle: const TextStyle(
                      fontStyle: FontStyle.normal,
                      color: Colors.black,
                    ),
                    border: TableBorder.all(
                      color: Colors.black,
                      width: 2.0,
                    ),
                    columns: const [
                      DataColumn(
                          label: Text(
                        'userId',
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                      )),
                      DataColumn(
                          label: Text(
                        'id',
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                      )),
                      DataColumn(
                          label: Text(
                        'title',
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                      ))
                    ],
                    rows: rowFill == false
                        ? _retrievedData
                        : [
                            DataRow(
                                cells: const <DataCell>[
                                  DataCell(Text('')),
                                  DataCell(Text('')),
                                  DataCell(Text('')),
                                ],
                                onLongPress: () {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content:
                                        Text('Why are you longpressing me?'),
                                  ));
                                }),
                          ],
                  ),
                ),
              );
            }
          },
          itemCount: 2,
          onPageChanged: (int f) {},
          pageSnapping: true,
        ));
  }
}
