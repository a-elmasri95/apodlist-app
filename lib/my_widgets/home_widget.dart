import 'dart:convert';
import 'package:app_one/utils/colors.dart';
import 'package:app_one/web_data/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final PageController pageController = PageController();
  final ScrollController scrollController = ScrollController();
  late Future<List<MemeModel>> models;

  @override
  void initState() {
    super.initState();
    models = fetchModel();
    scrollController.addListener(() {});
  }

  Future<List<MemeModel>> fetchModel() async {
    List<MemeModel> modelList = [];
    final response = await get(Uri.parse(
        'https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&start_date=2021-09-01&end_date=2022-01-01'));
    if (response.statusCode == 200) {
      var list = jsonDecode(response.body);
      for (var i = 0; i < list.length; i++) {
        if (!(list[i]['media_type'] == 'video')) {
          modelList.add(MemeModel.fromJson(list[i]));
        }
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
    bool listItemSelected = false;

    return SafeArea(
      top: true,
      child: Container(
        color: AppColors.royalBlue,
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
                        const IconButton(
                          onPressed: null,
                          icon: Icon(
                            Icons.replay_circle_filled_rounded,
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
                      controller: scrollController,
                      isAlwaysShown: false,
                      showTrackOnHover: true,
                      thickness: 5.0,
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Card(
                              borderOnForeground: false,
                              child: ListTile(
                                textColor: Colors.white,
                                selected: listItemSelected,
                                tileColor: Colors.black,
                                onTap: () {},
                                dense: true,
                                title: Text(
                                  snapshot.data![index].name,
                                ),
                                subtitle: Text(snapshot.data![index].date),
                                leading: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: 30.0,
                                  child: Image(
                                    image:
                                        NetworkImage(snapshot.data![index].url),
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
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
