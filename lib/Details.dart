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
  var call;
  @override
  void initState() {
    title = widget.mainTitle;
    _optionBloc.getData(title);
    _optionBloc.getEquities(title);
    call = "";
    super.initState();
  }

  Container setAutomaticCount() {
    Future.delayed(const Duration(seconds: 2), () {
      int totalPutCOI = sumTwo(putCOI);
      int totalCallCOI = sumTwo(callCOI);
      setState(() {
        call = (totalPutCOI - totalCallCOI);
      });
      print("Put: $totalPutCOI");
      print("Call: $totalCallCOI");
      print("Total: ${totalPutCOI - totalCallCOI}");
    });
    return Container();
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

  List<int> callCOI = [];
  List<int> putCOI = [];

  int sumTwo(List<int> numbers) {
    int sum = 0;
    for (var i in numbers) {
      sum = sum + i;
    }
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$title"),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 3, bottom: 3),
              // color: Colors.black,
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
                        // headTitle("V"),
                        headTitle("LTP"),
                        headTitle("SP"),
                        headTitle("LTP"),
                        // headTitle("V"),
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
                          child: ListView.builder(
                            addAutomaticKeepAlives: true,
                            shrinkWrap: true,
                            padding: EdgeInsets.only(bottom: 5),
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int i) {
                              Data data = snapshot.data[i];
                              callCOI
                                  .add(int.parse(data.cE.changeinOpenInterest));
                              putCOI
                                  .add(int.parse(data.pE.changeinOpenInterest));
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
                                        child: Container(
                                          color: i == 9
                                              ? Colors.white.withOpacity(0.3)
                                              : Colors.black,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              headTitle(data.cE.openInterest),
                                              horizontalLibe(),
                                              headTitle(
                                                  data.cE.changeinOpenInterest),
                                              // horizontalLibe(),
                                              // headTitle(
                                              //     data.cE.totalTradedVolume),
                                              horizontalLibe(),
                                              headTitle(data.cE.lastPrice),
                                              horizontalLibe(),
                                              headTitle(data.strikePrice),
                                              horizontalLibe(),
                                              headTitle(data.pE.lastPrice),
                                              // horizontalLibe(),
                                              // headTitle(
                                              //     data.pE.totalTradedVolume),
                                              horizontalLibe(),
                                              headTitle(
                                                  data.pE.changeinOpenInterest),
                                              horizontalLibe(),
                                              headTitle(data.pE.openInterest),
                                            ],
                                          ),
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
            call == ""
                ? setAutomaticCount()
                : Container(
                    width: 0,
                    height: 0,
                  ),
            call == ""
                ? Container()
                : Container(
                    color: call.toString().contains('-')
                        ? Colors.red
                        : Colors.green,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 3,
                          child: Center(
                            child: Text(
                              call.toString(),
                            ),
                          ),
                        ),
                        Container(
                          child: Container(
                            width: 1,
                            height: 50,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 3,
                          child: Center(
                            child: Text(
                                call.toString().contains('-') ? "Sell" : "Buy"),
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
