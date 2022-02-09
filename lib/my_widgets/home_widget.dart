import 'dart:convert';
import 'package:app_one/my_widgets/search_toolbar.dart';
import 'package:app_one/utils/colors.dart';
import 'package:app_one/web_data/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final ScrollController _scrollController = ScrollController();
  String webUrl =
      'https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&start_date=2021-09-01&end_date=2022-01-01';
  String endpointUrl = 'https://api.nasa.gov/planetary/apod';
  Map<String, String> queryParams = {
    'api_key': 'JfsVH2sdKphwxnyRhTsgqIUjCms4udNUqLutA2mL',
    'start_date': '2021-09-01',
    'end_date': '2022-01-1',
  };
  late Future<List<MemeModel>> models;
  bool isloading = false;
  String stDate = '';
  String enDate = '';

  @override
  void initState() {
    super.initState();
    models = fetchModel();
  }

  Future<List<MemeModel>> fetchModel() async {
    List<MemeModel> modelList = [];
    Uri requestUrl =
        Uri.parse(endpointUrl).replace(queryParameters: queryParams);
    final response = await get(requestUrl);
    if (response.statusCode == 200) {
      var list = jsonDecode(response.body);
      for (var i = 0; i < list.length; i++) {
        if (!(list[i]['media_type'] == 'video')) {
          modelList.add(MemeModel.fromJson(list[i]));
        }
      }
      setState(() {
        isloading = false;
      });
      return modelList; //though this returns JSONArray and not object after jsonDecode
    } else {
      setState(() {
        isloading = false;
      });
      return [];
    }
  }

  updateList() {
    String startDate = stDate.substring(0, 10);
    String endDate = enDate.substring(0, 10);
    if ((startDate.isNotEmpty && endDate.isNotEmpty) &&
        (int.parse(stDate.substring(0, 4)) <=
            int.parse(enDate.substring(0, 4)))) {
      setState(() {
        queryParams['start_date'] = startDate;
        queryParams['end_date'] = endDate;
        isloading = true;
        models = fetchModel();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please fill all dates correctly.'),
        backgroundColor: Colors.white,
      ));
      throw Exception('Fill all fields.');
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool listItemSelected = false;

    return SafeArea(
      top: true,
      child: Container(
        color: Colors.white,
        child: FutureBuilder<List<MemeModel>>(
          future: models,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SearchToolBar(
                    updateList: updateList,
                    callBack: (val) => setState(() {
                      stDate = val;
                    }),
                    callBackTwo: (val) => setState(() {
                      enDate = val;
                    }),
                  ),
                  Expanded(
                    flex: 1,
                    child: Scrollbar(
                      controller: _scrollController,
                      isAlwaysShown: false,
                      showTrackOnHover: true,
                      thickness: 5.0,
                      child: isloading == true
                          ? const Center(
                              child: CircularProgressIndicator(
                              backgroundColor: Colors.black,
                              color: Colors.red,
                            ))
                          : ListView.builder(
                              controller: _scrollController,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return Card(
                                    borderOnForeground: false,
                                    child: ListTile(
                                      textColor: Colors.white,
                                      selected: listItemSelected,
                                      tileColor: Colors
                                          .white, //const Color(0xFFF5F5DC),
                                      onTap: () {},
                                      dense: true,
                                      title: Text(
                                        snapshot.data![index].name,
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                      subtitle: Text(snapshot.data![index].date,
                                          style: const TextStyle(
                                              color: Colors.black)),
                                      leading: CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        radius: 30.0,
                                        child: Image(
                                          image: NetworkImage(
                                              snapshot.data![index].url),
                                        ),
                                      ),
                                    ));
                              },
                            ),
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.black,
              color: Colors.red,
            ));
          },
        ),
      ),
    );
  }
}
