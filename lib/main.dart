// import 'package:example/change_settings.dart';
// import 'package:example/enable_in_background.dart';
// import 'package:flutter/material.dart';
// import 'package:location/location.dart';
// import 'package:url_launcher/url_launcher.dart';

// import 'change_notification.dart';
// import 'get_location.dart';
// import 'listen_location.dart';
// import 'permission_status.dart';
// import 'service_enabled.dart';

// const _url = 'https://github.com/Lyokone/flutterlocation';

// void main() => runApp(const MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Location',
//       theme: ThemeData(
//         primarySwatch: Colors.amber,
//       ),
//       home: const MyHomePage(title: 'Flutter Location Demo'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, this.title});
//   final String? title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final Location location = Location();

//   Future<void> _showInfoDialog() {
//     return showDialog<void>(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Demo Application'),
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[
//                 const Text('Created by Guillaume Bernos'),
//                 InkWell(
//                   child: const Text(
//                     _url,
//                     style: TextStyle(
//                       decoration: TextDecoration.underline,
//                     ),
//                   ),
//                   onTap: () => launchUrl(Uri.parse(_url)),
//                 ),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('Ok'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title!),
//         actions: <Widget>[
//           IconButton(
//             icon: const Icon(Icons.info_outline),
//             onPressed: _showInfoDialog,
//           )
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           padding: const EdgeInsets.all(32),
//           // FIXME: This ignore can be removed when we drop support for Flutter 3.10.
//           // ignore: prefer_const_constructors
//           child: Column(
//             // FIXME: This ignore can be removed when we drop support for Flutter 3.10.
//             // ignore: prefer_const_literals_to_create_immutables
//             children: [
//               const PermissionStatusWidget(),
//               const Divider(height: 32),
//               const ServiceEnabledWidget(),
//               const Divider(height: 32),
//               const GetLocationWidget(),
//               const Divider(height: 32),
//               const ListenLocationWidget(),
//               const Divider(height: 32),
//               const ChangeSettings(),
//               const Divider(height: 32),
//               const EnableInBackgroundWidget(),
//               const Divider(height: 32),
//               const ChangeNotificationWidget()
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'dart:convert';

import 'package:android_physical_buttons/android_physical_buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

final List<String> _debugLog = [];
Location? location;
dynamic lm;
const String serverUrl = 'https://droneguard.jaideepak.repl.co/sos';
Future<void> post(String e) async {
  final res = await http.post(
    Uri.parse(serverUrl),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(e),
  );
  print(res);
}

// LocationDto? _locationDto;
dynamic fn;
void main() async {
  debugPrint = (message, {wrapWidth}) {
    print(message);
    post(message ?? 'NULL');
    if (fn != null) {
      fn(message);
    } else {
      _debugLog.add(message.toString());
    }
  };

  WidgetsFlutterBinding.ensureInitialized();

  // get the current location
  // debugPrint(await LocationManager().getCurrentLocation());

  // start listen to location updates
  // StreamSubscription<LocationDto> locationSubscription =
  //     lm.locationStream.listen((loc) => _locationDto = loc);

  await Permission.ignoreBatteryOptimizations.request();
  // const androidConfig = FlutterBackgroundAndroidConfig(
  //   notificationTitle: 'SOS',
  //   notificationText:
  //       'Background notification for keeping the SOS app running in the background',
  //   notificationImportance: AndroidNotificationImportance.Max,
  // );
  // final success =
  //     await FlutterBackground.initialize(androidConfig: androidConfig);
  // await FlutterBackground.enableBackgroundExecution();
  // debugPrint('Background runner service : $success');

  // Future.delayed(Duration.zero, () async {
  //   Timer.periodic(const Duration(seconds: 1), (timer) {
  //     Future.delayed(Duration.zero, () async {
  //       debugPrint("ticker");
  //       debugPrint((await lm.getCurrentLocation()).toJson());
  //       debugPrint((await Permission.locationAlways.request()).isGranted);
  //     });
  //   });
  // });

  runApp(
    MaterialApp(
      initialRoute: 'home',
      routes: {
        'home': (context) => const MyApp(),
        'eme': (context) => const EmergencyNumbersPage()
      },
    ),
  );
}

final List<EmergencyNumber> emergencyNumbers = [
  EmergencyNumber('Police', '100'),
  EmergencyNumber('Fire', '101'),
  EmergencyNumber('Ambulance', '102'),
  EmergencyNumber('Women Helpline', '1091'),
  EmergencyNumber('Women Helpline - Domestic Abuse', '181'),
  EmergencyNumber('Senior Citizen Helpline', '1091'),
  EmergencyNumber('Medical Helpline', '108'),
  EmergencyNumber('Child Helpline', '1098'),
  EmergencyNumber('Disaster Management', '1077'),
  EmergencyNumber('Railway Enquiry', '139'),
  EmergencyNumber('Road Accident Emergency Service', '1073'),
  EmergencyNumber('AIDS Helpline', '1097'),
  EmergencyNumber('LPG Emergency Helpline', '1906'),
  EmergencyNumber('Electricity Complaints', '1912'),
  EmergencyNumber('Crime Stopper', '1090'),
  EmergencyNumber('Centralized Accident and Trauma Services (CATS)', '102'),
  EmergencyNumber("Women's Helpline - All India", '181'),
  EmergencyNumber('Tourist Helpline', '1363'),
  EmergencyNumber('Earthquake Helpline', '1092'),
  EmergencyNumber('Anti-Poison', '1066'),
  EmergencyNumber('COVID-19 Helpline', '1075'),
  EmergencyNumber('Cyber Crime Helpline', '155260'),
  EmergencyNumber('Gas Leakage Helpline', '1906'),
  EmergencyNumber('Child Abuse Helpline', '1098'),
  EmergencyNumber('National Emergency Number', '112'),
  EmergencyNumber('Traffic Police Helpline', '103'),
  EmergencyNumber('Water Supply Helpline', '1916'),
  // Add more emergency numbers here
];

class EmergencyNumber {
  EmergencyNumber(this.name, this.number);
  final String name;
  final String number;
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _latestHardwareButtonEvent;
  int powerButtonPressCount = 0;
  int lastPowerButtonPressTimestamp = 0; // Track timestamp of the last press

  // Placeholder server endpoint

  @override
  void initState() {
    super.initState();
    fn = _debugLog.add;
    AndroidPhysicalButtons.listen((key) {
      setState(() {
        _latestHardwareButtonEvent = key.toString();
        if (key.name == 'power') {
          handlePowerButtonPress();
        } else {
          debugPrint(key.name);
        }
      });
    });
    Future.delayed(Duration.zero, () async {
      try {
        location = Location();
        final perm = await location!.requestPermission();
        debugPrint('Permission : $perm');
        final bg = await location!.enableBackgroundMode();
        debugPrint('Background mode : $bg');
        final service = await location!.requestService();

        debugPrint(
          'Permission status : $perm \n Service status : $service \n Background status : $bg',
        );
        if (MediaQuery.of(context).size.width < 200) {
          debugPrint('LocationData<lat: 11.0606956, long: 77.0337545>');
        } else {
          debugPrint((await location!.getLocation()).toString());
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    });
  }

  void handlePowerButtonPress() {
    final currentTimestamp = DateTime.now().millisecondsSinceEpoch;

    // Check if the time since the last press is within 3 seconds
    if (currentTimestamp - lastPowerButtonPressTimestamp <= 3000) {
      powerButtonPressCount++;
      debugPrint('Counting ... $powerButtonPressCount');

      // Check if 5 consecutive presses have occurred
      if (powerButtonPressCount >= 5) {
        sendSOS();
        powerButtonPressCount = 0; // Reset count after sending SOS
      }
    } else {
      // _locationDto = null;
      powerButtonPressCount = 1; // Reset count if the time gap is too long
    }

    lastPowerButtonPressTimestamp = currentTimestamp;
  }

  Future<void> sendSOS() async {
    // Send SOS signal to the server
    try {
      debugPrint('Sending the SOS');

      final pos = await location!.getLocation();
      debugPrint(pos.toString());
      final res = await http.post(
        Uri.parse(serverUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'lat': pos.latitude,
          'long': pos.longitude,
          'acc': pos.accuracy,
          'alt': pos.altitude,
        }),
      );
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  bool _debugMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MediaQuery.of(context).size.width > 200
          ? AppBar(
              title: const Text(
                'Home',
                style: TextStyle(fontSize: 24),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      _debugMode = !_debugMode;
                    });
                  },
                  icon: const Icon(Icons.bug_report),
                ),
              ],
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.indigo],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            )
          : AppBar(
              centerTitle: true,
              title: const Text('SOS'),
            ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 100,
              width: double.infinity,
              child: GestureDetector(
                onTap: () {
                  debugPrint('LocationData<lat: 11.0606956, long: 77.0337545>');
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  if (_debugMode)
                    Expanded(
                      child: ListView.builder(
                        itemCount: _debugLog.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              leading: const Icon(
                                Icons.bug_report,
                                color: Colors.red,
                              ),
                              title: Text(_debugLog[index]),
                              subtitle: Text(
                                DateFormat('MMM dd, HH:mm')
                                    .format(DateTime.now()),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  const SizedBox(height: 20),
                  Align(
                    child: Image.asset(
                      'assets/drone.png', // Replace with your image path
                      width: 400,
                      height: 300,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => const EmergencyNumbersPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 16,
                      ),
                      backgroundColor: Colors.indigo,
                      textStyle: const TextStyle(fontSize: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('View Emergency Numbers'),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EmergencyNumbersPage extends StatefulWidget {
  const EmergencyNumbersPage({super.key});

  @override
  _EmergencyNumbersPageState createState() => _EmergencyNumbersPageState();
}

class _EmergencyNumbersPageState extends State<EmergencyNumbersPage> {
  String _searchTerm = '';

  List<EmergencyNumber> getFilteredEmergencyNumbers() {
    return emergencyNumbers.where((number) {
      return number.name.toLowerCase().contains(_searchTerm.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.lightBlueAccent, Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text(
          'Emergency Numbers',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchTerm = value;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Search for an emergency number...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: getFilteredEmergencyNumbers().length,
              itemBuilder: (context, index) {
                final number = getFilteredEmergencyNumbers()[index];
                return EmergencyButton(
                  name: number.name,
                  number: number.number,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class EmergencyButton extends StatelessWidget {
  const EmergencyButton({
    super.key,
    required this.name,
    required this.number,
  });
  final String name;
  final String number;

  Future<void> _callEmergencyNumber() async {
    final url = 'tel:$number';
    await launch(url);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: GestureDetector(
        onTap: _callEmergencyNumber,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              splashColor: Colors.blue.withOpacity(0.2),
              onTap: _callEmergencyNumber,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          number,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(12),
                      child: const Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
