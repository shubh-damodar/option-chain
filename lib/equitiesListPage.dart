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

  @override
  void initState() {
    _optionBloc.setEquitiesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: _optionBloc.equitiListStream,
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            return snapshot.data == null
                ? Center(
                    child: Text("Loading..."),
                  )
                : Container(
                    child: ListView.builder(
                      addAutomaticKeepAlives: true,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(bottom: 5),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int i) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OptionChainDetails(
                                    mainTitle: "${snapshot.data[i]}"),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(snapshot.data[i]),
                                  Icon(Icons.arrow_right),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
          },
        ),
      ),
    );
  }
}
