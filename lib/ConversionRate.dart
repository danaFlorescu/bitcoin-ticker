import 'networking.dart';

const apiKey = '41604A95-4D57-4E64-AE9C-FA23547EE79F';
const cryptoCurrencyURL = 'https://rest.coinapi.io/v1/exchangerate';

class Conversion {
  Conversion(this.firstCurrency, this.secondCurrency);

  final String firstCurrency;

  final String secondCurrency;

  Future<dynamic> getCurrency() async {
    NetworkHelper networkHelper = NetworkHelper(
        '$cryptoCurrencyURL/$firstCurrency/$secondCurrency?apikey=$apiKey');

    var cryptoData = await networkHelper.getData();

    return cryptoData;
  }
}
