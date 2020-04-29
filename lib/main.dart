import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MethodChannel _methodChannel = MethodChannel('MY_SP');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SP getStringList sample'),),
      body: Column(
        children: <Widget>[
          RaisedButton(
            child: Text('Read SP from Android'),
            onPressed: (){
              _readSP();
            },

          ),

          RaisedButton(
            child: Text('Write SP in Android'),
            onPressed: (){
              _methodChannel.invokeMethod('WRITE');

            },
          ),
        ],
      ),
    );
  }

  _readSP()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var _messageLog = prefs.getStringList('messageLog');
    print ('_messageLog = $_messageLog');
  }

//  _setSP()async{
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    CurrentUser _user1 = CurrentUser(userId: 'one', device: 'nokia');
//    CurrentUser _user2 = CurrentUser(userId: 'two', device: 'apple');
//    List<String> _userList = [json.encode(_user1.toJson()), json.encode(_user2.toJson())];
//    //await prefs.setStringList('mydata', _userList);
//    // var guestId = prefs.getString('guestId');
////  print('guestId = $guestId');
//
//    // getStringList would change Android's Set<String> to String
//    // var mydata = prefs.getStringList('messageLog'); // return null if not found
//
//    var mydata = prefs.getString('messageLog'); // return null if not found
//    print('mydata = $mydata ');
//    var _newList = mydata.split('|');
//    print('_newList = $_newList ');
//    List<MessageInfo> _mL = _newList.map((d){
//      return MessageInfo.fromJson( json.decode(d));
//    }).toList();
//
//    print('MessageInfo list = $_mL');
//    print('MessageInfo list len= ${_mL.length}');
//    print('ml[0] = ${_mL[0].toJson()}');
////  prefs.remove('messageLog');
////  print( 'prefs.getStringList(messageLog) = ${ prefs.getStringList('messageLog')}' );
//
//
//    // print(' length = ${mydata.length}');
////  List<dynamic> _newList = List<dynamic>.from(mydata);
////  List<MessageInfo> mydataList = _newList.map((d){
////    print('d = $d');
////    Map<dynamic, dynamic> _temp = json.decode(d);
////    print('_temp = $_temp');
////    return MessageInfo.fromJson(_temp);
////   // return CurrentUser.fromJson(_temp);
////  }).toList();
////  print('mydataList = $mydataList');
////  prefs.remove('messageLog');
////  print( 'prefs.getStringList(messageLog) = ${ prefs.getStringList('messageLog')}' );
//
//
//  }

}
