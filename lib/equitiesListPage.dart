import 'package:flutter/material.dart';
import 'package:optionchain/Details.dart';
import 'package:optionchain/OptionBloc.dart';

class EquitiesList extends StatefulWidget {
  EquitiesList({Key key}) : super(key: key);

  @override
  _EquitiesListState createState() => _EquitiesListState();
}

class _EquitiesListState extends State<EquitiesList> {
  OptionBloc _optionBloc = OptionBloc();

  TextEditingController _searchList = TextEditingController();

  @override
  void initState() {
    _optionBloc.setEquitiesList();
    super.initState();
  }

  List data = List();

  List newSearchList = List();

  setData(List responseList) {
    Future.delayed(Duration.zero, () {
      _optionBloc.equitiListStreamSink.add(null);
      data = responseList;
      newSearchList = responseList;
      setState(() {});
    });
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            StreamBuilder(
              stream: _optionBloc.equitiListStream,
              builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                return snapshot.data != null
                    ? setData(snapshot.data)
                    : Container();
              },
            ),
            TextField(
              controller: _searchList,
              onChanged: (searchValue) {
                if (searchValue.length > 0) {
                  newSearchList = List();
                  data.forEach((element) {
                    if (element
                        .toString()
                        .toLowerCase()
                        .contains(searchValue.toLowerCase())) {
                      print(element);
                      newSearchList.add(element);
                      setState(() {});
                    }
                  });
                }
              },
            ),
            ListView.builder(
                itemCount: newSearchList.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int i) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OptionChainDetails(
                            mainTitle: "${newSearchList[i]}",
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(newSearchList[i]),
                            Icon(Icons.arrow_right),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
