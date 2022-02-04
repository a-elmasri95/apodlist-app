import 'dart:convert';
import 'package:app_one/utils/colors.dart';
import 'package:app_one/web_data/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';

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
    scrollController.addListener(() {});
  }

  void refreshPage() {
    setState(() {});
  }

  void _onListItemTap() {}

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
    bool listItemSelected = false;

    return SafeArea(
      top: true,
      child: Container(
        color: Colors.black,
        child: FutureBuilder<List<Model>>(
          future: models,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Scrollbar(
                controller: scrollController,
                isAlwaysShown: false,
                showTrackOnHover: true,
                thickness: 5.0,
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.white,
                      child: ListTile(
                        leading: const Icon(
                          Icons.account_balance_wallet,
                          color: AppColors.royalBlue,
                        ),
                        onTap: _onListItemTap,
                        textColor: Colors.black,
                        selected: listItemSelected,
                        dense: true,
                        title: Text(snapshot.data![index].title),
                        subtitle: Text(snapshot.data![index].id.toString()),
                        trailing: const Icon(
                          Icons.arrow_right,
                          color: AppColors.scarletRed,
                        ),
                      ),
                    );
                  },
                ),
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
