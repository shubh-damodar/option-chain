import 'dart:async';
import 'package:optionchain/connection.dart';
import 'package:optionchain/optionModel.dart';

class OptionBloc {
  Connection _connection = Connection();
  List<Data> filterdData = [];

// -------------------------------Data List-------------------------->>
  final StreamController<List<Data>> dataListStreamController =
      StreamController<List<Data>>.broadcast();

  StreamSink<List<Data>> get dataListStreamSink =>
      dataListStreamController.sink;

  Stream<List<Data>> get dataListStream => dataListStreamController.stream;
  // ------------------------------End----------------------------->>

  getCookies() {
    print("Getting cookies");
  }

  getData(String symbole) {
    _connection.getDetails(symbole).then((response) {
      List<dynamic> dynamicList = response['filtered']["data"] as List<dynamic>;
      dynamicList.map((i) => filterdData.add(Data.fromJson(i))).toList();
      dataListStreamSink.add(filterdData);
    });
  }

  dispose() {
    dataListStreamController.close();
  }
}
