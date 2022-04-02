import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
import 'ConversionRate.dart';
import 'package:my_bitcoin_ticker_solution/ShowCurrency.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';

  String finalCurrencyBTC = "";
  String finalCurrencyETH = "";
  String finalCurrencyLTC = "";

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value.toString();
          loadData();
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
      },
      children: pickerItems,
    );
  }

  void loadData() async {
    //bitcoin
    Conversion conversionBTC = new Conversion('BTC', selectedCurrency);
    String myVarBTC = (await conversionBTC.getCurrency())["rate"].toString();

    //ethereum
    Conversion conversionETH = new Conversion('ETH', selectedCurrency);
    String myVarETH = (await conversionETH.getCurrency())["rate"].toString();

    //litecoin
    Conversion conversionLTC = new Conversion('LTC', selectedCurrency);
    String myVarLTC = (await conversionLTC.getCurrency())["rate"].toString();

    setState(() {
      finalCurrencyBTC = myVarBTC;
      finalCurrencyETH = myVarETH;
      finalCurrencyLTC = myVarLTC;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ShowCurrency(typeOfCurrency: "BTC", finalCurrency: finalCurrencyBTC),
          ShowCurrency(typeOfCurrency: "ETH", finalCurrency: finalCurrencyETH),
          ShowCurrency(typeOfCurrency: "LTC", finalCurrency: finalCurrencyLTC),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}
