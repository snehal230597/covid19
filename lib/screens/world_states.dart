import 'package:covid_tracker/models/WorldStatesModel.dart';
import 'package:covid_tracker/screens/countries_list.dart';
import 'package:covid_tracker/services/utilities/states_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStateScreen extends StatefulWidget {
  const WorldStateScreen({Key? key}) : super(key: key);

  @override
  State<WorldStateScreen> createState() => _WorldStateScreenState();
}

class _WorldStateScreenState extends State<WorldStateScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: Duration(seconds: 3), vsync: this)
        ..repeat();

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final List colorList = [
    Color(0xff4285F4),
    Color(0xff1aa260),
    Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              FutureBuilder(
                future: statesServices.fetchWorldStatesRecords(),
                builder: (context, AsyncSnapshot<WorldStatesModel> snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        controller: _controller,
                        size: 50,
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * .01),
                        PieChart(
                          dataMap: {
                            "Total":
                                double.parse(snapshot.data!.cases!.toString()),
                            "Recoverd": double.parse(
                                snapshot.data!.recovered!.toString()),
                            "Deaths":
                                double.parse(snapshot.data!.deaths!.toString())
                          },
                          chartValuesOptions: ChartValuesOptions(
                              showChartValuesInPercentage: true),
                          chartRadius: MediaQuery.of(context).size.width / 3,
                          animationDuration: Duration(milliseconds: 1200),
                          chartType: ChartType.ring,
                          legendOptions: LegendOptions(
                              legendPosition: LegendPosition.left),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * 0.06),
                          child: Card(
                            child: Column(
                              children: [
                                ReUsableRow(
                                    title: 'Total',
                                    value: snapshot.data!.cases.toString()),
                                ReUsableRow(
                                    title: 'Deaths',
                                    value: snapshot.data!.deaths.toString()),
                                ReUsableRow(
                                    title: 'Recovered',
                                    value: snapshot.data!.recovered.toString()),
                                ReUsableRow(
                                    title: 'Active',
                                    value: snapshot.data!.active.toString()),
                                ReUsableRow(
                                    title: 'Critical',
                                    value: snapshot.data!.critical.toString()),
                                ReUsableRow(
                                    title: 'Today Deaths',
                                    value:
                                        snapshot.data!.todayDeaths.toString()),
                                ReUsableRow(
                                    title: 'Today Recovered',
                                    value: snapshot.data!.todayRecovered
                                        .toString()),
                              ],
                            ),
                          ),
                       ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CountriesListScreen(),
                              ),
                            );
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                'Track Countries',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReUsableRow extends StatelessWidget {
  String? title, value;

  ReUsableRow({Key? key, this.title, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(title!), Text(value!)],
          ),
          SizedBox(height: 5),
          Divider()
        ],
      ),
    );
  }
}
