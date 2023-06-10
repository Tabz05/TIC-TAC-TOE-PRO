import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tictactoepro/models/user_data_model.dart';
import 'package:tictactoepro/screens/home.dart';
import 'package:tictactoepro/screens/home_log_in.dart';
import 'package:tictactoepro/screens/home_log_in_main.dart';
import 'package:tictactoepro/screens/myProfile.dart';
import 'package:tictactoepro/services/database_service.dart';
import 'package:tictactoepro/shared/colors.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

    final DatabaseService _databaseService = DatabaseService();

    String? _username = null;

    File? _imageFile = null;

    final _picker = ImagePicker();

    Future _imgFromGallery() async {
    
    final _pickedImage = await _picker.pickImage(source: ImageSource.gallery);

      if (_pickedImage != null) {
        setState(() {
          print('hereee');
          _imageFile = File(_pickedImage.path);
          print(_imageFile.toString());
        });
      }
    }

    Future _imgFromCamera() async {

      final _pickedImage = await _picker.pickImage(source: ImageSource.camera);

      if (_pickedImage != null) {
        setState(() {
          _imageFile = File(_pickedImage.path);
        });
      }
    }

  @override
  Widget build(BuildContext context) {
    
    final _userDetails = Provider.of<UserDataModel?>(context);

    return _userDetails == null
        ? SizedBox()
        : SafeArea(
            child: Scaffold(
                backgroundColor: backgroundColor,
                body: Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _imageFile!=null? CircleAvatar(
                                    radius: 100,
                                    backgroundImage: FileImage(_imageFile!),
                                  )
                            : _userDetails.hasProfilePic!
                                ? CircleAvatar(
                                    radius: 100,
                                    backgroundImage: NetworkImage(
                                        _userDetails.profilePicUri!),
                                    
                                  )
                                : CircleAvatar(
                                  radius: 100,
                                    backgroundImage: AssetImage(
                                        'assets/person.png'),
                                    
                                  ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          width:double.infinity,
                          margin: EdgeInsets.symmetric(horizontal:30,vertical:0),
                          decoration: BoxDecoration(  
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.black)
                          ),
                          child: TextField(
                            onChanged: (text){
                               setState(() {
                                  _username = text.toString();
                               });
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: _userDetails.username!),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () async {
                            await _imgFromCamera();
                          },
                          child: Container(
                              width:double.infinity,
                              margin: EdgeInsets.symmetric(horizontal:30,vertical:0),
                              padding: EdgeInsets.all(5),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.black),
                                  ),
                              child: Row(
                                children: [
                                  Icon(Icons.camera),
                                  SizedBox(width: 5,),
                                  Text('Choose from camera',style: TextStyle(fontSize: 16),),
                                ],
                              )),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () async {
                            await _imgFromGallery();
                          },
                          child: Container(
                              width:double.infinity,
                              margin: EdgeInsets.symmetric(horizontal:30,vertical:0),
                              padding: EdgeInsets.all(5),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.black),
                                  ),
                              child: Row(
                                children: [
                                  Icon(Icons.image),
                                  SizedBox(width: 5,),
                                  Text('Choose from gallery',style: TextStyle(fontSize: 16),),
                                ],
                              )),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _imageFile = null;
                            });
                          },
                          child: Container(
                              width:double.infinity,
                              margin: EdgeInsets.symmetric(horizontal:30,vertical:0),
                              padding: EdgeInsets.all(5),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.black),
                                  color:Colors.yellow),
                              child: Text('Remove',style: TextStyle(fontSize: 16),)),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () async {

                            _imageFile!=null ? 
                            await _databaseService.uploadProfilePic(_userDetails.uid!,_imageFile!) :
                            print('pressed');

                            _username!=null && !_username!.isEmpty ? 
                            await _databaseService.updateUsername(_userDetails.uid!,_username!) :
                            print('pressed');

                          },
                          child: Container(
                              width:double.infinity,
                              margin: EdgeInsets.symmetric(horizontal:30,vertical:0),
                              padding: EdgeInsets.all(5),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.black),
                                  color:Colors.blue),
                              child: Text('Submit',style: TextStyle(fontSize: 16,color: Colors.white),)),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                )));
  }
}
