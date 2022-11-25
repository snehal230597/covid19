import 'package:covid_tracker/screens/world_states.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  String? image, name;
  int? totalCases,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      todayRecovered,
      test;

  @override
  State<DetailScreen> createState() => _DetailScreenState();

  DetailScreen(
      {required this.image,
      required this.name,
      required this.totalCases,
      required this.totalDeaths,
      required this.totalRecovered,
      required this.active,
      required this.critical,
      required this.todayRecovered,
      required this.test});
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name!),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.06),
                      ReUsableRow(
                          title: 'Cases', value: widget.totalCases.toString()),
                      ReUsableRow(
                          title: 'Recovered', value: widget.todayRecovered.toString()),
                      ReUsableRow(
                          title: 'Death', value: widget.totalDeaths.toString()),
                      ReUsableRow(
                          title: 'Critical', value: widget.critical.toString()),
                      ReUsableRow(
                          title: 'Today Recovered', value: widget.todayRecovered.toString()),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image!),
              )
            ],
          )
        ],
      ),
    );
  }
}
