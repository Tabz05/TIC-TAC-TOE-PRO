import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:tictactoepro/models/user_data_model.dart';
import 'package:tictactoepro/shared/colors.dart';
import 'package:tictactoepro/shared/loading.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    
    final _userDetails = Provider.of<UserDataModel?>(context);

    Map<String,double>? _matchMap = null;
    Map<String,double>? _wonMap = null;
    Map<String,double>? _turnMap = null;

    Map<String,double>? _multiMatchMap = null;
    Map<String,double>? _multiWonMap = null;
    Map<String,double>? _multiTurnMap = null;

    if (_userDetails != null) {
      
      _matchMap = {
        'Matches Won': _userDetails.won!.toDouble(),
        'Matches Lost': _userDetails.lost!.toDouble(),
        'Matches Draw': _userDetails.draw!.toDouble(),
      };

      _wonMap = {
        'Won First': _userDetails.wonFirst!.toDouble(),
        'Won Second': _userDetails.wonSecond!.toDouble(),
      };

      _turnMap = {
        'First Turn': _userDetails.first!.toDouble(),
        'Second Turn': _userDetails.second!.toDouble(),
      };

      _multiMatchMap = {
        'Matches Won': _userDetails.multi_won!.toDouble(),
        'Matches Lost': _userDetails.multi_lost!.toDouble(),
        'Matches Draw': _userDetails.multi_draw!.toDouble(),
      };

      _multiWonMap = {
        'Won First': _userDetails.multi_wonFirst!.toDouble(),
        'Won Second': _userDetails.multi_wonSecond!.toDouble(),
      };

      _multiTurnMap = {
        'First Turn': _userDetails.multi_first!.toDouble(),
        'Second Turn': _userDetails.multi_second!.toDouble(),
      };
    }

    return _userDetails == null
        ? Loading()
        : SafeArea(
            child: Scaffold(
            backgroundColor: backgroundColor,
            body: Container(
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    _userDetails.hasProfilePic!
                        ? CircleAvatar(
                            backgroundImage:
                                NetworkImage(_userDetails.profilePicUri!),
                            radius: 100,
                          )
                        : CircleAvatar(
                            backgroundImage: AssetImage('assets/person.png'),
                            radius: 100),
                    SizedBox(
                      height: 40,
                    ),
                    Text('Username: ' + _userDetails.username!,
                        style: TextStyle(fontSize: 16)),
                    SizedBox(
                      height: 20,
                    ),
                    Text('Email: ' + _userDetails.email!,
                        style: TextStyle(fontSize: 16)),
                    SizedBox(
                      height: 30,
                    ),
                    Text('Single Player Games',
                        style: TextStyle(fontSize: 16)),
                    SizedBox(
                      height: 30,
                    ),
                    PieChart(
                      dataMap: _matchMap!,
                      chartRadius: MediaQuery.of(context).size.width / 2,
                      chartValuesOptions: ChartValuesOptions(
                        decimalPlaces: 0,
                      ),
                    ),
                    PieChart(
                        dataMap: _wonMap!,
                        chartRadius: MediaQuery.of(context).size.width / 2,
                        chartValuesOptions: ChartValuesOptions(
                        decimalPlaces: 0,
                      )),
                    PieChart(
                        dataMap: _turnMap!,
                        chartRadius: MediaQuery.of(context).size.width / 2,
                        chartValuesOptions: ChartValuesOptions(
                        decimalPlaces: 0,
                      ),),
                    SizedBox(
                      height: 30,
                    ),
                    Text('Multi Player Games',
                        style: TextStyle(fontSize: 16)),
                    SizedBox(
                      height: 30,
                    ), 
                    PieChart(
                      dataMap: _multiMatchMap!,
                      chartRadius: MediaQuery.of(context).size.width / 2,
                      chartValuesOptions: ChartValuesOptions(
                        decimalPlaces: 0,
                      ),
                    ),
                    PieChart(
                        dataMap: _multiWonMap!,
                        chartRadius: MediaQuery.of(context).size.width / 2,
                        chartValuesOptions: ChartValuesOptions(
                        decimalPlaces: 0,
                      )),
                    PieChart(
                        dataMap: _multiTurnMap!,
                        chartRadius: MediaQuery.of(context).size.width / 2,
                        chartValuesOptions: ChartValuesOptions(
                        decimalPlaces: 0,
                      ),),   
                  ],
                ),
              ),
            ),
          ));
  }
}
