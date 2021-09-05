import 'package:v_app/videoconference/joinmeeting.dart';
import 'package:v_app/videoconference/createmeeting.dart';
import 'package:flutter/material.dart';
import 'package:v_app/variables.dart';
import 'package:flutter/src/widgets/ticker_provider.dart';

class VideoConferenceScreen extends StatefulWidget {
  const VideoConferenceScreen({Key? key}) : super(key: key);

  @override
  _VideoConferenceScreenState createState() => _VideoConferenceScreenState();
}

class _VideoConferenceScreenState extends State<VideoConferenceScreen> with SingleTickerProviderStateMixin{
  TabController tabController;
  buildtab(String name){
    return Container(
      width: 150,
      height: 50,
      child: Card(
        child: Center(
          child: Text(name,style: mystyle(15,Colors.black,FontWeight.w700)),
        ),
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController=TabController(length: 2, vsync: this );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        title: Text("VApp",
          style: mystyle(20,Colors.white,FontWeight.w700),
        ),
        bottom: TabBar(
          controller: tabController,
          tabs: [
            buildtab("Join Meeting"),
            buildtab("Create Meeting")],
        ),
      ),
      body: TabBarView(
          controller: tabController,
          children: [
            JoinMeeting(),
            CreateMeeting(),
      ]),
    );
  }
}
