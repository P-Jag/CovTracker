import 'package:cov_19/app/services/api.dart';
import 'package:flutter/material.dart';

class EndpointsData {
  EndpointsData({@required this.values});
  final Map<Endpoint, int> values;

  int get cases => values[Endpoint.cases];
  int get casesSuspected => values[Endpoint.casesSuspected];
  int get casesConfirmed => values[Endpoint.casesConfirmed];
  int get deaths => values[Endpoint.deaths];
  int get recovered => values[Endpoint.recovered];

  @override
  String toString() =>
      'cases: $cases, casesSuspected: $casesSuspected, casesConfirmed: $casesConfirmed, deaths: $deaths, recovered: $recovered';
}
