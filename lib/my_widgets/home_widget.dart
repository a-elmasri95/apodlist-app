import 'dart:convert';
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
  final TextEditingController _textEditingController1 = TextEditingController();
  final TextEditingController _textEditingController2 = TextEditingController();
  String webUrl =
      'https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&start_date=2021-09-01&end_date=2022-01-01';
  String endpointUrl = 'https://api.nasa.gov/planetary/apod';
  Map<String, String> queryParams = {
    'api_key': 'DEMO_KEY',
    'start_date': '2021-09-01',
    'end_date': '2022-01-1',
  };
  late Future<List<MemeModel>> models;
  bool isloading = false;

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
    String startDate = _textEditingController1.text;
    String endDate = _textEditingController2.text;
    if (startDate.isNotEmpty && endDate.isNotEmpty) {
      setState(() {
        queryParams['start_date'] = startDate;
        queryParams['end_date'] = endDate;
        isloading = true;
        models = fetchModel();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please insert all dates'),
        backgroundColor: Colors.white,
      ));
      throw Exception('Fill all fields.');
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _textEditingController1.dispose();
    _textEditingController2.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool listItemSelected = false;

    return SafeArea(
      top: true,
      child: Container(
        color: Colors.black,
        child: FutureBuilder<List<MemeModel>>(
          future: models,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    color: const Color(0xFF000080),
                    alignment: Alignment.center,
                    height: 40.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Flexible(
                          child: TextField(
                            controller: _textEditingController1,
                            keyboardType: TextInputType.datetime,
                            decoration: const InputDecoration(
                              hintText: 'Start Date',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontStyle: FontStyle.normal,
                                fontSize: 10.0,
                              ),
                            ),
                            style: Theme.of(context).textTheme.button,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Flexible(
                          child: TextField(
                            controller: _textEditingController2,
                            decoration: const InputDecoration(
                              hintText: 'End Date',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontStyle: FontStyle.normal,
                                fontSize: 10.0,
                              ),
                            ),
                            style: Theme.of(context).textTheme.button,
                          ),
                        ),
                        const SizedBox(
                          width: 100,
                        ),
                        IconButton(
                          onPressed: updateList,
                          icon: const Icon(
                            Icons.refresh,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
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
                                      tileColor: const Color(0xFFF5F5DC),
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
