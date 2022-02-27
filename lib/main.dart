import 'package:flutter/material.dart';
import 'package:clevertap_plugin/clevertap_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  var inboxInitialized = false;

  late CleverTapPlugin _clevertapPlugin;
  @override
  void initState() {

    CleverTapPlugin.createNotificationChannel("2311", "devflutter", "Flutter Test", 5, true);
    super.initState();
    CleverTapPlugin.initializeInbox();
    CleverTapPlugin.setDebugLevel(3);

  }
  String textHolder = 'Old Sample Text...!!!';

  Future<void> changeText() async {
    var temp= {"":""};
    CleverTapPlugin.recordEvent("devennativedisp", temp);
    setState(() async {
      //  List <dynamic> displayUnits = await CleverTapPlugin.getAllDisplayUnits();
      //    textHolder = "Display Units = "+displayUnits.toString();
      print("deven test");
      List <dynamic> myJSON = await CleverTapPlugin.getAllDisplayUnits();
      print("deven "+myJSON.toString());

      // String nameString = jsonEncode(nameJson); // jsonEncode != .toString()

      // String jsonTags = jsonEncode(displayUnits);
      // var decodedJson = json.decode(jsonTags);
      // var jsonValue= json.decode(decodedJson['value']);
      //   print("Display Units = " + displayUnits.toString());
      //displayUnits.toString();
    });
    setState(() {
      textHolder = "Display Units";
    });
  }
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }
  void inboxDidInitialize() {
    setState(() {
      print("inboxDidInitialize called");
      inboxInitialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Card(
              color: Colors.grey.shade300,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListTile(
                  title: Text("Performs onUserLogin"),
                  subtitle: Text("Used to identify multiple profiles"),
                  onTap: onUserLogin,
                ),
              ),
            ),
            Card(
              color: Colors.grey.shade300,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListTile(
                  title: Text("Push Notification"),
                  subtitle: Text("Pushes/Records an event"),
                  onTap: recordEvent,
                ),
              ),
            ),
            Card(
              color: Colors.grey.shade300,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListTile(
                  title: Text("App Inbox"),
                  subtitle: Text("App Inbox event"),
                  onTap: opappinbox,
                ),
              ),
            ),
            Card(
              color: Colors.grey.shade300,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListTile(
                  title: Text("In App"),
                  subtitle: Text("In App event"),
                  onTap: inapp,
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Text('$textHolder',
                    style: TextStyle(fontSize: 21)
                )
            ),
            ElevatedButton(
              onPressed: () => changeText(),
              child: Text('Click Here To Change Text Widget Text Dynamically'),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void onUserLogin() {
    var stuff = ["bags", "shoes"];
    var profile = {
      'Name': 'deven',
      //'Identity': '100',
      'Email': 'deven@flutter.com',
      'Phone': '+918779636312',
      'DOB':'29-11-1998',
      'stuff': stuff,
      'MSG-push':true,
      'MSG-whatsapp':true,
      'MSG-sms':true,
      'MSG-email':true
    };
    CleverTapPlugin.onUserLogin(profile);
    //showToast("onUserLogin called, check console for details");
  }
  void recordEvent() {
    var eventData = {
      'number': 1
    };
    CleverTapPlugin.recordEvent("DevenFlutterPush",eventData);
  }
  void opappinbox(){
    if (inboxInitialized) {
        var styleConfig = {
          'noMessageTextColor': '#ff6600',
          'noMessageText': 'No message(s) to show.',
          'navBarTitle': 'App Inbox',
          'navBarTitleColor': '#101727',
          'navBarColor': '#EF4444',
          'tabs': ["Offers"]
        };
        CleverTapPlugin.showInbox(styleConfig);
    }

    var eventData = {
      'number': 1
    };
    CleverTapPlugin.recordEvent("DevenPushEvent",eventData);

  }
  void inapp(){

    var temp= {"":""};
    CleverTapPlugin.recordEvent("devenflutterinapp",temp);

  }

}
