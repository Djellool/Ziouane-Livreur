import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:ze_livreur/provider/InscriptionProvider.dart';
import 'package:ze_livreur/provider/auth.dart';
import 'package:ze_livreur/provider/navigation_provider.dart';
import 'package:ze_livreur/provider/request_provider.dart';
import 'package:ze_livreur/screens/views/ContainerScreen.dart';
import 'package:ze_livreur/screens/views/Inscription_login/Inscrit.dart';
import 'package:ze_livreur/screens/views/Inscription_login/login.dart';
import 'package:ze_livreur/screens/views/Notification/navigationscreen.dart';
import 'package:ze_livreur/screens/views/Notification/notificationscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await FirebaseMessaging.instance.getToken();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<Auth>(create: (_) => Auth()),
    ChangeNotifierProvider(create: (context) => RequestProvider()),
    ChangeNotifierProvider<InscriptionProvider>(
        create: (_) => InscriptionProvider())
  ], child: ze_livreur()));
}

// ignore: camel_case_types
class ze_livreur extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NavigationProvider>(
        create: (_) => NavigationProvider(), child: Navigation());
  }
}

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  final storage = new FlutterSecureStorage();
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    readToken();
    _registerOnFirebase();
    getMessage();
    super.initState();
  }

  Future<void> readToken() async {
    String token = await storage.read(key: "token");
    await Provider.of<Auth>(context, listen: false).tryToken(context, token);
    print("token : $token");
  }

  _registerOnFirebase() {
    _firebaseMessaging.subscribeToTopic('all');
    _firebaseMessaging.getToken().then((token) => print(token));
  }

  void getMessage() {
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage messageRemoted) {
        print("rahi temchi");
        print(messageRemoted.toString());

        RemoteNotification notification = messageRemoted.notification;
        AndroidNotification android = messageRemoted.notification?.android;
        Map<String, dynamic> message = messageRemoted.data;
        print(message.toString());
        var provider = Provider.of<RequestProvider>(context, listen: false);
        var userprovider = Provider.of<Auth>(context, listen: false);
        print(userprovider.livreurExt.idLivExt);
        if (userprovider.livreurExt.etat == "online" &&
            userprovider.authenticated != "notified" &&
            userprovider.authenticated != "delivring") {
          provider.changenom(message['nom']);
          provider.changeprenom(message['prenom']);
          provider.changepickup(message['pickup']);
          provider.changedropoff(message['dropoff']);
          provider.changetel(message['tel']);
          provider.changeprix(double.parse(message['prix']));
          Provider.of<Auth>(context, listen: false).changeauth("notified");
        }
      },
      onDone: () {
        print("sdsdsd");
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage messageRemoted) {
      print("hello");
      Map<String, dynamic> message = messageRemoted.data;
      var userprovider = Provider.of<Auth>(context, listen: false);
      if (userprovider.livreurExt.etat == "online") {}
      var provider = Provider.of<RequestProvider>(context, listen: false);
      provider.changenom(message['nom']);
      provider.changeprenom(message['prenom']);
      provider.changepickup(message['pickup']);
      provider.changedropoff(message['dropoff']);
      provider.changetel(message['tel']);
      provider.changeprix(double.parse(message['prix']));
      Provider.of<Auth>(context, listen: false).changeauth("notified");
    });
  }

  @override
  Widget build(context) {
    getMessage();
    return MaterialApp(
      home: Scaffold(
        body: Consumer<Auth>(
          builder: (context, auth, child) {
            switch (auth.authenticated) {
              case "loggedin":
                {
                  return ContainerScreen();
                }
                break;
              case "loggedout":
                {
                  return LoginScreen();
                }
                break;
              case "blocked":
                {
                  return Inscrit();
                }
                break;
              case "notified":
                {
                  return NotificationPage();
                }
                break;
              case "delivring":
                {
                  return NavigationPage();
                }
                break;
            }
            return null;
          },
        ),
      ),
    );
  }
}
