import 'package:flutter/material.dart';
import 'package:optionchain/OptionBloc.dart';
import 'package:optionchain/optionModel.dart';

// ignore: must_be_immutable
class OptionChainDetails extends StatefulWidget {
  @required
  String mainTitle;
  OptionChainDetails({Key key, this.mainTitle}) : super(key: key);

  @override
  _OptionChainDetailsState createState() => _OptionChainDetailsState();
}

class _OptionChainDetailsState extends State<OptionChainDetails> {
  String title;
  OptionBloc _optionBloc = OptionBloc();
  @override
  void initState() {
    title = widget.mainTitle;
    _optionBloc.getData(title);
    super.initState();
  }

  Widget headTitle(String data) {
    return Expanded(
      flex: 2,
      child: Center(
        child: Container(
          child: Text(
            "$data" ?? "",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  Widget horizontalLibe() {
    return Container(
      height: 20,
      width: 2,
      color: Colors.black,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$title"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 3, bottom: 3),
              color: Colors.black,
              child: Row(
                children: [
                  Container(
                    height: 10,
                    width: 4,
                  ),
                  Flexible(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        headTitle("OI"),
                        headTitle("COI"),
                        headTitle("V"),
                        headTitle("LTP"),
                        headTitle("SP"),
                        headTitle("LTP"),
                        headTitle("V"),
                        headTitle("COI"),
                        headTitle("OI"),
                      ],
                    ),
                  ),
                  Container(
                    height: 10,
                    width: 4,
                  ),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: _optionBloc.dataListStream,
                builder:
                    (BuildContext context, AsyncSnapshot<List<Data>> snapshot) {
                  return snapshot.data == null
                      ? Center(
                          child: Text("Loading..."),
                        )
                      : Container(
                          color: Colors.black12,
                          child: ListView.builder(
                            addAutomaticKeepAlives: true,
                            shrinkWrap: true,
                            padding: EdgeInsets.only(bottom: 5),
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int i) {
                              Data data = snapshot.data[i];
                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 15,
                                        width: 3,
                                        color: Colors.red,
                                      ),
                                      Flexible(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            headTitle(data.cE.openInterest),
                                            horizontalLibe(),
                                            headTitle(
                                                data.cE.changeinOpenInterest),
                                            horizontalLibe(),
                                            headTitle(
                                                data.cE.totalTradedVolume),
                                            horizontalLibe(),
                                            headTitle(data.cE.lastPrice),
                                            horizontalLibe(),
                                            headTitle(data.strikePrice),
                                            horizontalLibe(),
                                            headTitle(data.pE.lastPrice),
                                            horizontalLibe(),
                                            headTitle(
                                                data.pE.totalTradedVolume),
                                            horizontalLibe(),
                                            headTitle(
                                                data.pE.changeinOpenInterest),
                                            horizontalLibe(),
                                            headTitle(data.pE.openInterest),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 15,
                                        width: 3,
                                        color: Colors.red,
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 2,
                                    color: Colors.black,
                                  )
                                ],
                              );
                            },
                          ),
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
