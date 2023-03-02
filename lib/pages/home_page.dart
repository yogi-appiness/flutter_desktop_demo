import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:techcloudpro_demo/pages/cubit/login_cubit.dart';

/// Home Page: Dashboard page where there are 2 sections.
/// Left pane where users can edit the GDP values and sumbit.
/// Right pane contains the pie chart with the GDP values provided by user
/// AUTHOR: Yogendra J Pai
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static Route<HomePage> createRoute() =>
      MaterialPageRoute(builder: (_) => const HomePage());

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Initialize with dummy values
  Map<String, int> dataMap = {
    "consumption": 329912,
    "investment": 234322,
    "government": 732422,
    "imports": 2477664,
    "exports": 182248,
    "others": 76234
  };

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    List<ChartData> chartData = [];
    // Create chart entries based on the map data.
    dataMap.forEach(
      (key, value) {
        chartData.add(ChartData(key.toUpperCase(), value));
      },
    );
    final user = BlocProvider.of<LoginCubit>(context).state.user;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.pink,
        title: const Text(
          "TechCloud Dashboard",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
        ),
        //Image.asset("assets/techcloud_logo.png",width: 240.0),
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<LoginCubit>(context).logoutUser();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/app_bg.jpg",
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(36.0),
                  child: Text(
                    "Hi ${user?.name}, Welcome to TechCloud Dashboard.",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: const Color.fromARGB(255, 188, 255, 245),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 2.0,
                              spreadRadius: 0.0,
                              offset: Offset(
                                  1.0, 1.0), // shadow direction: bottom right
                            )
                          ],
                        ),
                        width: 440.0,
                        height: 550.0,
                        margin: const EdgeInsets.only(right: 64.0),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 24.0),
                        child: FormBuilder(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _titleWidget("Consumption GDP (INR Crores)"),
                              const SizedBox(height: 8.0),
                              FormBuilderTextField(
                                name: 'consumption',
                                initialValue: dataMap["consumption"].toString(),
                                maxLength: 10,
                                decoration: const InputDecoration(
                                  counterText: "",
                                ),
                                validator: gdpValidator,
                                onSaved: (val) {
                                  dataMap["consumption"] =
                                      int.parse(val ?? "0");
                                },
                              ),
                              const SizedBox(height: 16.0),
                              _titleWidget("Investment GDP (INR Crores)"),
                              const SizedBox(height: 8.0),
                              FormBuilderTextField(
                                name: 'investment',
                                initialValue: dataMap["investment"].toString(),
                                maxLength: 10,
                                decoration: const InputDecoration(
                                  counterText: "",
                                ),
                                validator: gdpValidator,
                                onSaved: (val) {
                                  dataMap["investment"] = int.parse(val ?? "0");
                                },
                              ),
                              const SizedBox(height: 16.0),
                              _titleWidget("Government GDP (INR Crores)"),
                              const SizedBox(height: 8.0),
                              FormBuilderTextField(
                                name: 'government',
                                initialValue: dataMap["government"].toString(),
                                maxLength: 10,
                                decoration: const InputDecoration(
                                  counterText: "",
                                ),
                                validator: gdpValidator,
                                onSaved: (val) {
                                  dataMap["government"] = int.parse(val ?? "0");
                                },
                              ),
                              const SizedBox(height: 16.0),
                              _titleWidget("Imports GDP (INR Crores)"),
                              const SizedBox(height: 8.0),
                              FormBuilderTextField(
                                name: 'imports',
                                initialValue: dataMap["imports"].toString(),
                                maxLength: 10,
                                decoration: const InputDecoration(
                                  counterText: "",
                                ),
                                validator: gdpValidator,
                                onSaved: (val) {
                                  dataMap["imports"] = int.parse(val ?? "0");
                                },
                              ),
                              const SizedBox(height: 16.0),
                              _titleWidget("Exports GDP (INR Crores)"),
                              const SizedBox(height: 8.0),
                              FormBuilderTextField(
                                name: 'exports',
                                initialValue: dataMap["exports"].toString(),
                                maxLength: 10,
                                decoration: const InputDecoration(
                                  counterText: "",
                                ),
                                validator: gdpValidator,
                                onSaved: (val) {
                                  dataMap["exports"] = int.parse(val ?? "0");
                                },
                              ),
                              const SizedBox(height: 16.0),
                              _titleWidget("Others GDP (INR Crores)"),
                              const SizedBox(height: 8.0),
                              FormBuilderTextField(
                                name: 'others',
                                initialValue: dataMap["others"].toString(),
                                maxLength: 10,
                                decoration: const InputDecoration(
                                  counterText: "",
                                ),
                                validator: gdpValidator,
                                onSaved: (val) {
                                  dataMap["others"] = int.parse(val ?? "0");
                                },
                              ),
                              const SizedBox(height: 16.0),
                              Center(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState?.validate() ??
                                        false) {
                                      _formKey.currentState?.save();
                                      setState(() {});
                                    }
                                  },
                                  child: const Text("Generate Chart"),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: const Color.fromARGB(255, 188, 255, 245),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 2.0,
                              spreadRadius: 0.0,
                              offset: Offset(
                                  1.0, 1.0), // shadow direction: bottom right
                            )
                          ],
                        ),
                        padding: const EdgeInsets.all(64.0),
                        height: 550.0,
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(bottom: 48.0),
                              child: Text(
                                "India GDP (FY 2021-2022) in INR Crores",
                                style: TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SfCircularChart(
                              margin: const EdgeInsets.all(0.0),
                              tooltipBehavior: TooltipBehavior(enable: true),
                              series: <CircularSeries>[
                                // Render pie chart
                                PieSeries<ChartData, String>(
                                    dataSource: chartData,
                                    radius: "100",
                                    dataLabelSettings: const DataLabelSettings(
                                        isVisible: true),
                                    xValueMapper: (ChartData data, _) => data.x,
                                    yValueMapper: (ChartData data, _) => data.y)
                              ],
                              legend: Legend(
                                  isVisible: true,
                                  height: "100",
                                  position: LegendPosition.bottom,
                                  overflowMode: LegendItemOverflowMode.wrap,
                                  orientation: LegendItemOrientation.vertical),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Validate the GDP values so that its only a numeric value
  String? gdpValidator(String? text) {
    if (text?.isEmpty ?? true) {
      return "Field cannot be empty";
    }

    if (!RegExp(r'^[0-9]+$').hasMatch(text!)) {
      return "Only Numbers allowed";
    }

    return null;
  }

  // Text field title
  _titleWidget(String title) => Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.w500),
      );
}

/// Object for chart data entry
class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final int y;
}
