import 'dart:io';
import 'package:cov_19/app/repositories/data_repository.dart';
import 'package:cov_19/app/repositories/endpoints_data.dart';
import 'package:cov_19/app/services/api.dart';
import 'package:cov_19/app/ui/endpoint_card.dart';
import 'package:cov_19/app/ui/last_updated_status_text.dart';
import 'package:cov_19/app/ui/show_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  EndpointsData _endpointsData;

  @override
  void initState() {
    super.initState();
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    _endpointsData = dataRepository.getAllEndpointsCachedData();
    _updateData();
  }

  Future<void> _updateData() async {
    try {
      final dataRepository =
          Provider.of<DataRepository>(context, listen: false);
      final endpointsData = await dataRepository.getAllEndpointData();
      setState(() => _endpointsData = endpointsData);
    } on SocketException catch (_) {
      showAlertDialog(
          context: context,
          title: "Connection Error",
          content: "Could not retrieve data. Try again later",
          actionText: "OK");
    } catch (_) {
      showAlertDialog(
          context: context,
          title: "Unknown error",
          content: "Please contact support or try again later",
          actionText: "OK");
    }
  }

  @override
  Widget build(BuildContext context) {
    final formatter = LastUpdateDateFormatter(
        lastUpdated: _endpointsData != null
            ? _endpointsData.values[Endpoint.cases]?.date
            : null);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cov Tracker'),
      ),
      body: RefreshIndicator(
        onRefresh: _updateData,
        child: ListView(
          children: <Widget>[
            LastUpdatedStatusText(text: formatter.lastUpdatedDateStatus()),
            for (var endpoint in Endpoint.values)
              EndpointCard(
                endpoint: endpoint,
                value: _endpointsData != null
                    ? _endpointsData.values[endpoint]?.value
                    : null,
              )
          ],
        ),
      ),
    );
  }
}
