import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoepro/models/user_data_model.dart';
import 'package:tictactoepro/screens/edit_profile.dart';
import 'package:tictactoepro/screens/home.dart';
import 'package:tictactoepro/screens/myProfile.dart';
import 'package:tictactoepro/screens/singlePlayerLoggedIn/log_in_choose_symbol.dart';
import 'package:tictactoepro/services/auth_service.dart';
import 'package:tictactoepro/shared/colors.dart';

class HomeLogInMain extends StatefulWidget {
  const HomeLogInMain({super.key});

  @override
  State<HomeLogInMain> createState() => _HomeLogInMainState();
}

class _HomeLogInMainState extends State<HomeLogInMain> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    
    final _userDetails = Provider.of<UserDataModel?>(context);

    print('This: ' + _userDetails.toString());

    return _userDetails == null
        ? SizedBox()
        : SafeArea(
            child: Scaffold(
              backgroundColor: backgroundColor,
              appBar: AppBar(
                backgroundColor: Colors.red,
              ),
              drawer: Drawer(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ChangeNotifierProvider.value(
                              value: _userDetails,
                              child: MyProfile(),
                            ),
                          ),
                        );
                      },
                      child: ListTile(
                        leading: Icon(Icons.person),
                        title: Text(_userDetails.username!),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ChangeNotifierProvider.value(
                              value: _userDetails,
                              child: EditProfile(),
                            ),
                          ),
                        );
                      },
                      child: ListTile(
                        leading: Icon(Icons.edit),
                        title: Text('Edit Profile'),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        dynamic result = await _auth.signOut();

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Home()),
                        );
                      },
                      child: ListTile(
                        leading: Icon(Icons.logout),
                        title: Text('Log Out'),
                      ),
                    )
                  ],
                ),
              ),
              body: Container(
                width: double.infinity,
                height: double.infinity,
                margin: EdgeInsets.all(20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: SizedBox(),
                      ),
                      Text(
                        'TIC-TAC-TOE',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: SizedBox(),
                      ),
                      Text(
                        'Welcome ' + _userDetails.username.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: SizedBox(),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ChangeNotifierProvider.value(
                                value: _userDetails,
                                child: LogInChooseSymbol(),
                              ),
                            ),
                          );
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.red),
                            padding: EdgeInsets.all(10),
                            child: Text('Single Player',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16))),
                      ),
                      Flexible(
                        flex: 3,
                        fit: FlexFit.tight,
                        child: SizedBox(),
                      ),
                      Text(
                        'Developed by Tabish Shamim',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: SizedBox(),
                      ),
                    ]),
              ),
            ),
          );
  }
}
