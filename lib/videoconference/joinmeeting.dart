import 'dart:io';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:flutter/material.dart';
import 'package:jitsi_meet/feature_flag/feature_flag_enum.dart';
import 'package:jitsi_meet_platform_interface/feature_flag/feature_flag_enum.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:v_app/variables.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class JoinMeeting extends StatefulWidget {
  const JoinMeeting({Key? key}) : super(key: key);

  @override
  _JoinMeetingState createState() => _JoinMeetingState();
}

class _JoinMeetingState extends State<JoinMeeting> {
  TextEditingController namecontroller =TextEditingController();
  TextEditingController roomcontroller=TextEditingController();
  bool isVideoMuted=true;
  bool isAudioMuted=true;
 String username=' ';

 @override
  void initState(){
    super.initState();
    getuserdata();
  }
  getuserdata()async{
    DocumentSnapshot userdoc=
    await usercollection.doc(FirebaseAuth.instance.currentUser.uid.get());
    setState(() {
      username=userdoc.data()['username'];
    });
  }
  joinmeeting()async{
try{
  Map<FeatureFlagEnum,bool> featureflags = {
    FeatureFlagEnum.WELCOME_PAGE_ENABLED:false
  };
  if(Platform.isAndroid){
    featureflags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED]=false;
  }
  else if(Platform.isIOS){
    featureflags[FeatureFlagEnum.PIP_ENABLED]=false;
  }
  var options=JitsiMeetingOptions()
    ..room= roomcontroller.text,
    ..userDisplayName =namecontroller.text=='' ? username : namecontroller.text
    ..audioMuted=isAudioMuted
    ..videoMuted=isVideoMuted
    ..featureFlags.addAll(featureflags);
  await JitsiMeet.joinMeeting(options);
}catch(e){
  print("Error:$e");

}
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 13
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 24),
              Text("Room Code",
              style:mystyle(20) ,
              ),
              SizedBox(
                height: 20,
              ),
              PinCodeTextField(
                controller:roomcontroller,
                  length: 6,
                  autoDisposeControllers: false,
                  animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.underline
                ),
                animationDuration: Duration(milliseconds: 300),
                onChanged: (value){},
              ),
              SizedBox(height: 10,),
              TextField(
                controller: namecontroller,
                style: mystyle(20),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Name(Leave if you want your username)",
                  labelStyle: mystyle(15)),
              ),
              SizedBox(
                 height: 16,
              ),
              CheckboxListTile(
                value: isVideoMuted,
                onChanged:(value){
                  setState(() {
                    isVideoMuted=value;
                  });
                },
                title: Text("Video Muted",
                  style: mystyle(18,Colors.black),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              CheckboxListTile(
                value: isAudioMuted,
                onChanged:(value){
                  setState(() {
                    isAudioMuted=value;
                  });
                },
                title: Text("Audio Muted",
                  style: mystyle(18,Colors.black),
                ),
              ),
              SizedBox(height: 20),
              Text("Of course ,you can customise your settings in the meeting ",
                style:mystyle(15),
                textAlign: TextAlign.center
              ),
              Divider(
                height: 48,
                thickness: 2.0,
              ),
              InkWell(
                onTap: ()=>joinmeeting(),
                child:Container(
                  width: double.maxFinite,
                  height: 64,
                  decoration: BoxDecoration(
                      gradient:
                      LinearGradient(colors: GradientColors.facebookMessenger)

                  ),
                  child: Center(
                    child: Text("Join Meeting",
                      style: mystyle(20,Colors.white),
                    ),
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
