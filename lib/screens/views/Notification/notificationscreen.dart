import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:ze_livreur/screens/views/Notification/navigationscreen.dart';

// ignore: must_be_immutable
class NotificationPage extends StatelessWidget {
  Color grey = Color(0xFF424242);
  Color grey2 = Color(0xFF646464);
  Color background = Color(0xFFF2F2F2);
  Color green = Color(0xFF4ED964);
  Color red = Color(0xFFFF3A32);
  Color orange = Color(0xFFF28322);
  Color violet = Color(0xFF382B8C);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appbar(context),
        backgroundColor: grey,
        body: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                offretext(context),
                notiftext(context),
                avatar(context),
                cout(context),
                destination(context),
                buttons(context)
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget appbar(context) {
  return AppBar(
    elevation: 0,
    backgroundColor: NotificationPage().grey,
    shadowColor: null,
    centerTitle: true,
    leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_rounded,
            color: NotificationPage().background),
        onPressed: () => Navigator.pop(context)),
  );
}

Widget offretext(context) {
  return Container(
      margin: EdgeInsets.only(top: ResponsiveFlutter.of(context).scale(10)),
      child: Text(
        "offre\nde livraison",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: NotificationPage().background,
          fontFamily: "Mom cake",
          fontSize: ResponsiveFlutter.of(context).fontSize(7),
          fontWeight: FontWeight.bold,
        ),
      ));
}

Widget notiftext(context) {
  return Container(
      margin: EdgeInsets.only(top: ResponsiveFlutter.of(context).scale(10)),
      width: ResponsiveFlutter.of(context).wp(80),
      child: Text(
        "Vous avez une nouvelle offre de livraison, ne ratez pas l'opportunité !",
        style: TextStyle(
          color: NotificationPage().background,
          fontSize: ResponsiveFlutter.of(context).fontSize(2.3),
          fontWeight: FontWeight.w400,
        ),
      ));
}

Widget avatar(context) {
  return Container(
    margin: EdgeInsets.only(top: ResponsiveFlutter.of(context).scale(10)),
    child: Column(
      children: [
        CircleAvatar(
          backgroundColor: NotificationPage().background,
          radius: ResponsiveFlutter.of(context).scale(50),
          child: Image(
            width: ResponsiveFlutter.of(context).scale(80),
            image: AssetImage("assets/images/avatar.png"),
          ),
        ),
        Text(
          "ziouane omar",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: NotificationPage().background,
            fontFamily: "Mom cake",
            fontSize: ResponsiveFlutter.of(context).fontSize(3.5),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

Widget cout(context) {
  return Container(
    margin: EdgeInsets.only(top: ResponsiveFlutter.of(context).scale(10)),
    width: ResponsiveFlutter.of(context).wp(80),
    padding: EdgeInsets.all(ResponsiveFlutter.of(context).scale(10)),
    decoration: BoxDecoration(
      color: NotificationPage().background,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Cout de livraison",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: NotificationPage().grey2,
            fontFamily: "Mom cake",
            fontSize: ResponsiveFlutter.of(context).fontSize(2.5),
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "1350 DA",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Mom cake",
            fontSize: ResponsiveFlutter.of(context).fontSize(7),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

Widget destination(context) {
  return Container(
    margin: EdgeInsets.only(top: ResponsiveFlutter.of(context).scale(10)),
    width: ResponsiveFlutter.of(context).wp(80),
    padding: EdgeInsets.all(ResponsiveFlutter.of(context).scale(10)),
    decoration: BoxDecoration(
      color: NotificationPage().background,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: [
        SizedBox(
          width: ResponsiveFlutter.of(context).wp(15),
          child: Column(
            children: [
              CircleAvatar(
                radius: ResponsiveFlutter.of(context).scale(10),
                backgroundColor: NotificationPage().orange,
                child: CircleAvatar(
                  backgroundColor: NotificationPage().background,
                  radius: ResponsiveFlutter.of(context).scale(7),
                ),
              ),
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(2)),
                height: ResponsiveFlutter.of(context).hp(5),
                child: VerticalDivider(
                  thickness: 3,
                  color: NotificationPage().grey2,
                  indent: 3,
                  endIndent: 3,
                ),
              ),
              CircleAvatar(
                radius: ResponsiveFlutter.of(context).scale(10),
                backgroundColor: Colors.black,
                child: CircleAvatar(
                  backgroundColor: NotificationPage().background,
                  radius: ResponsiveFlutter.of(context).scale(7),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Kouba",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Mom cake",
                      fontSize: ResponsiveFlutter.of(context).fontSize(3.5),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "à 5min",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: NotificationPage().grey2,
                      fontFamily: "Mom cake",
                      fontSize: ResponsiveFlutter.of(context).fontSize(2),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text(
                "Chemin de Ziouane, Kouba, Alger ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: NotificationPage().grey2,
                  fontFamily: "Mom cake",
                  fontSize: ResponsiveFlutter.of(context).fontSize(2),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                  child: Divider(
                thickness: 2,
                color: NotificationPage().grey2,
                endIndent: ResponsiveFlutter.of(context).scale(15),
              )),
              Text(
                "Hydra",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Mom cake",
                  fontSize: ResponsiveFlutter.of(context).fontSize(3.5),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Chemin de Ziouane, Hydra, Alger ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: NotificationPage().grey2,
                  fontFamily: "Mom cake",
                  fontSize: ResponsiveFlutter.of(context).fontSize(2),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buttons(context) {
  return Container(
    margin: EdgeInsets.only(top: ResponsiveFlutter.of(context).scale(10)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Container(
              width: ResponsiveFlutter.of(context).scale(100),
              height: ResponsiveFlutter.of(context).scale(50),
              decoration: BoxDecoration(
                  color: NotificationPage().red,
                  borderRadius: BorderRadius.circular(10)),
              child: Icon(
                Icons.remove_circle_outline_outlined,
                color: NotificationPage().background,
                size: ResponsiveFlutter.of(context).fontSize(5.5),
              ),
            )),
        FlatButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => NavigationPage()),
              );
            },
            child: Container(
              width: ResponsiveFlutter.of(context).scale(100),
              height: ResponsiveFlutter.of(context).scale(50),
              decoration: BoxDecoration(
                  color: NotificationPage().green,
                  borderRadius: BorderRadius.circular(10)),
              child: Icon(
                Icons.check_circle_outline_outlined,
                color: NotificationPage().background,
                size: ResponsiveFlutter.of(context).fontSize(5.5),
              ),
            ))
      ],
    ),
  );
}