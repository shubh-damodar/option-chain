import 'dart:async';
import 'dart:convert';
import 'package:optionchain/connection.dart';
import 'package:optionchain/optionModel.dart';
import 'package:optionchain/sharedPre.dart';

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
  //
  //
  // // -------------------------------Data List-------------------------->>
  final StreamController<List> equitiListStreamController =
      StreamController<List>.broadcast();

  StreamSink<List> get equitiListStreamSink => equitiListStreamController.sink;

  Stream<List> get equitiListStream => equitiListStreamController.stream;
  // ------------------------------End----------------------------->>

  void getCookies() {
    _connection.setCookies();
  }

  reqResponse(response) {
    var strikeResponse = response['records']['underlyingValue'];
    print(strikeResponse);
    List<dynamic> dynamicList = response['filtered']["data"] as List<dynamic>;
    List master1 = [];
    List master2 = [];
    List incremental = [];
    List decremental = [];
    List<dynamic> addingList = [];
    dynamicList.forEach((element) {
      if (element['strikePrice'] < strikeResponse) {
        incremental.add(element);
      } else {
        decremental.add(element);
      }
    });
    var j = 0;
    decremental.forEach((element) {
      if (j < 10) {
        master2.add(element);
        j++;
      }
    });
    var i = 0;
    incremental.reversed.forEach((element) {
      if (i < 9) {
        master1.add(element);
        i++;
      }
    });
    master1.reversed.forEach((element) {
      addingList.add(element);
    });
    master2.forEach((element) {
      addingList.add(element);
    });
    addingList.map((i) => filterdData.add(Data.fromJson(i))).toList();
    return dataListStreamSink.add(filterdData);
  }

  getData(String symbole) {
    _connection.getDetails(symbole).then((response) {
      return reqResponse(response);
    });
  }

  getEquities(String symbole) {
    _connection.getEquitie(symbole).then((response) {
      return reqResponse(response);
    });
  }

  setEquitiesList() {
    _connection.getEquitiesList().then((responese) {
      List<String> masterList = [];
      List<dynamic> equitiList = [];
      responese.forEach((element) {
        // masterList.add(jsonEncode(element));
        equitiList.add(element);
        print(element);
      });
      // SharedPrefManager.setMasterQuote(masterList);
      equitiListStreamSink.add(equitiList);
    });
  }

  dispose() {
    dataListStreamController.close();
    equitiListStreamController.close();
  }
}
