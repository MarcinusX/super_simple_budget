import 'package:flutter/material.dart';
import 'package:super_simple_budget/generated/i18n.dart';

typedef String NameGetter(BuildContext context);

class Currency {
  final String symbol;
  final bool onLeft;
  final NameGetter getName;
  final String name;

  Currency._(this.symbol, this.name, this.onLeft, this.getName);

  static Currency gbp =
      new Currency._("£", "GBP", true, (context) => S.of(context).currencyGBP);
  static Currency usd = new Currency._(
      "\$", "USD", true, (context) => S.of(context).currencyUSD('\$'));
  static Currency eur =
      new Currency._("€", "EUR", false, (context) => S.of(context).currencyEUR);
  static Currency pln = new Currency._(
      "zł", "PLN", false, (context) => S.of(context).currencyPLN);

  static List<Currency> currencies = [
    Currency.usd,
    Currency.gbp,
    Currency.eur,
    Currency.pln
  ];

  @override
  String toString() => name;

  static Currency fromString(String name) {
    switch (name) {
      case "GBP":
        return gbp;
      case "USD":
        return usd;
      case "EUR":
        return eur;
      case "PLN":
        return pln;
      default:
        return usd;
    }
  }
}

String valueWithCurrency(double value, Currency currency) {
  String sign = value < 0 ? "-" : "";
  String prefix = currency.onLeft ? currency.symbol : "";
  String stringValue = value.abs().toStringAsFixed(2);
  String suffix = currency.onLeft ? "" : " ${currency.symbol}";
  return sign + prefix + stringValue + suffix;
}
