class Response {
  Records records;
  Filtered filtered;

  Response({this.records, this.filtered});

  Response.fromJson(Map<String, dynamic> json) {
    records =
        json['records'] != null ? new Records.fromJson(json['records']) : null;
    filtered = json['filtered'] != null
        ? new Filtered.fromJson(json['filtered'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.records != null) {
      data['records'] = this.records.toJson();
    }
    if (this.filtered != null) {
      data['filtered'] = this.filtered.toJson();
    }
    return data;
  }
}

class Records {
  List<String> expiryDates;
  List<Data> data;
  String timestamp;
  double underlyingValue;
  List<int> strikePrices;

  Records(
      {this.expiryDates,
      this.data,
      this.timestamp,
      this.underlyingValue,
      this.strikePrices});

  Records.fromJson(Map<String, dynamic> json) {
    expiryDates = json['expiryDates'].cast<String>();
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    timestamp = json['timestamp'];
    underlyingValue = json['underlyingValue'];
    strikePrices = json['strikePrices'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['expiryDates'] = this.expiryDates;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['timestamp'] = this.timestamp;
    data['underlyingValue'] = this.underlyingValue;
    data['strikePrices'] = this.strikePrices;
    return data;
  }
}

class Data {
  String strikePrice;
  String expiryDate;
  PE pE;
  PE cE;

  Data({this.strikePrice, this.expiryDate, this.pE, this.cE});

  Data.fromJson(Map<String, dynamic> json) {
    strikePrice = json['strikePrice'].toString();
    // print("===-$json");
    // expiryDate = json['expiryDate'];
    pE = json['PE'] != null ? new PE.fromJson(json['PE']) : null;
    cE = json['CE'] != null ? new PE.fromJson(json['CE']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['strikePrice'] = this.strikePrice;
    data['expiryDate'] = this.expiryDate;
    if (this.pE != null) {
      data['PE'] = this.pE.toJson();
    }
    if (this.cE != null) {
      data['CE'] = this.cE.toJson();
    }
    return data;
  }
}

class PE {
  String strikePrice;
  String expiryDate;
  String underlying;
  String identifier;
  String openInterest;
  String changeinOpenInterest;
  String pchangeinOpenInterest;
  String totalTradedVolume;
  String impliedVolatility;
  String lastPrice;
  String change;
  String pChange;
  String totalBuyQuantity;
  String totalSellQuantity;
  String bidQty;
  String bidprice;
  String askQty;
  String askPrice;
  String underlyingValue;

  PE(
      {this.strikePrice,
      this.expiryDate,
      this.underlying,
      this.identifier,
      this.openInterest,
      this.changeinOpenInterest,
      this.pchangeinOpenInterest,
      this.totalTradedVolume,
      this.impliedVolatility,
      this.lastPrice,
      this.change,
      this.pChange,
      this.totalBuyQuantity,
      this.totalSellQuantity,
      this.bidQty,
      this.bidprice,
      this.askQty,
      this.askPrice,
      this.underlyingValue});

  PE.fromJson(Map<String, dynamic> json) {
    strikePrice = json['strikePrice'].toString();
    expiryDate = json['expiryDate'].toString();
    underlying = json['underlying'].toString();
    identifier = json['identifier'].toString();
    openInterest = json['openInterest'].toString();
    changeinOpenInterest = json['changeinOpenInterest'].toString();
    pchangeinOpenInterest = json['pchangeinOpenInterest'].toString();
    totalTradedVolume = json['totalTradedVolume'].toString();
    impliedVolatility = json['impliedVolatility'].toString();
    lastPrice = json['lastPrice'].toString();
    change = json['change'].toString();
    pChange = json['pChange'].toString();
    totalBuyQuantity = json['totalBuyQuantity'].toString();
    totalSellQuantity = json['totalSellQuantity'].toString();
    bidQty = json['bidQty'].toString();
    bidprice = json['bidprice'].toString();
    askQty = json['askQty'].toString();
    askPrice = json['askPrice'].toString();
    underlyingValue = json['underlyingValue'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['strikePrice'] = this.strikePrice;
    data['expiryDate'] = this.expiryDate;
    data['underlying'] = this.underlying;
    data['identifier'] = this.identifier;
    data['openInterest'] = this.openInterest;
    data['changeinOpenInterest'] = this.changeinOpenInterest;
    data['pchangeinOpenInterest'] = this.pchangeinOpenInterest;
    data['totalTradedVolume'] = this.totalTradedVolume;
    data['impliedVolatility'] = this.impliedVolatility;
    data['lastPrice'] = this.lastPrice;
    data['change'] = this.change;
    data['pChange'] = this.pChange;
    data['totalBuyQuantity'] = this.totalBuyQuantity;
    data['totalSellQuantity'] = this.totalSellQuantity;
    data['bidQty'] = this.bidQty;
    data['bidprice'] = this.bidprice;
    data['askQty'] = this.askQty;
    data['askPrice'] = this.askPrice;
    data['underlyingValue'] = this.underlyingValue;
    return data;
  }
}

class Filtered {
  List<Data> data;
  PE cE;
  CE pE;

  Filtered({this.data, this.cE, this.pE});

  Filtered.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    cE = json['CE'] != null ? new PE.fromJson(json['CE']) : null;
    pE = json['PE'] != null ? new CE.fromJson(json['PE']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    if (this.cE != null) {
      data['CE'] = this.cE.toJson();
    }
    if (this.pE != null) {
      data['PE'] = this.pE.toJson();
    }
    return data;
  }
}

class CE {
  double totOI;
  double totVol;

  CE({this.totOI, this.totVol});

  CE.fromJson(Map<String, dynamic> json) {
    totOI = json['totOI'];
    print("=--=-=-=$totOI");
    totVol = json['totVol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totOI'] = this.totOI;
    data['totVol'] = this.totVol;
    return data;
  }
}
