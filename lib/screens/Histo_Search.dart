import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ze_livreur/models/Histo_mensuelle.dart';
import 'package:ze_livreur/provider/navigation_provider.dart';
import 'package:ze_livreur/services/ApiCalls.dart';
import 'package:ze_livreur/provider/auth.dart';
import 'package:provider/provider.dart';

class HistoSearchScreen extends StatefulWidget {
  @override
  _HistoSearchScreenState createState() => _HistoSearchScreenState();
}

class _HistoSearchScreenState extends State<HistoSearchScreen> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Auth>(context, listen: false).livreurExt;
    var providernav = Provider.of<NavigationProvider>(context, listen: false);

    Size size = MediaQuery.of(context).size;
    double screenheight = size.height;
    double screenwidth = size.width;

    Color background = Color(0xFFF2F2F2);
    Color orange = Color(0xFFF28322);
    Color violet = Color(0xFF382B8C);
    Color orangeclair = Color(0xFFEEA86B);
    Color grey2 = Color(0xFF646464);

    String getmonth(int month) {
      if (month == 1) return "Janvier";
      if (month == 2) return "Fevrier";
      if (month == 3) return "Mars";
      if (month == 4) return "Avril";
      if (month == 5) return "May";
      if (month == 6) return "Juin";
      if (month == 7) return "Juillet";
      if (month == 8) return "Aout";
      if (month == 9) return "Septembre";
      if (month == 10) return "Octobre";
      if (month == 11) return "Novembre";
      if (month == 12) return "Decembre";
    }

    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              providernav.getsearch,
              style: TextStyle(fontSize: 20),
            ),
            backgroundColor: orangeclair,
          ),
          body: FutureBuilder(
              future: ApiCalls().gethistomensuelle(
                  provider.idLivExt, providernav.getmonth, providernav.getyear),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Stack(
                    children: <Widget>[
                      ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.only(
                              right: 16,
                              left: 16,
                              top: MediaQuery.of(context).size.height * 0.03),
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            print(
                                "Search : " + providernav.getsearch.toString());
                            if (snapshot.data[index].datelivraison
                                    .toString()
                                    .toLowerCase()
                                    .contains(
                                        providernav.getsearch.toLowerCase()) ||
                                snapshot.data[index].clientname
                                    .toString()
                                    .toLowerCase()
                                    .contains(
                                        providernav.getsearch.toLowerCase()) ||
                                snapshot.data[index].clientprenom
                                    .toString()
                                    .toLowerCase()
                                    .contains(
                                        providernav.getsearch.toLowerCase()) ||
                                snapshot.data[index].dropoff
                                    .toString()
                                    .toLowerCase()
                                    .contains(
                                        providernav.getsearch.toLowerCase()) ||
                                snapshot.data[index].pickup
                                    .toString()
                                    .toLowerCase()
                                    .contains(
                                        providernav.getsearch.toLowerCase())) {
                              return box(snapshot.data[index]);
                            } else {
                              return Container(
                                height: 0,
                                width: 0,
                              );
                            }
                          }),
                    ],
                  );
                }
                if (snapshot.hasError) {
                  return Text("Erreur");
                }
                return Center(child: CircularProgressIndicator());
              }),
        ),
      ),
    );
  }

  Widget box(Histo_mensuel histo) {
    Size size = MediaQuery.of(context).size;
    double screenheight = size.height;
    double screenwidth = size.width;

    Color background = Color(0xFFF2F2F2);
    Color orange = Color(0xFFF28322);
    Color violet = Color(0xFF382B8C);
    Color grey2 = Color(0xFF646464);
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: ResponsiveFlutter.of(context).scale(8),
          vertical: ResponsiveFlutter.of(context).scale(8)),
      width: screenwidth * 0.9,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: violet),
          ]),
      child: Padding(
        padding:
            const EdgeInsets.only(bottom: 16, right: 16, left: 16, top: 16),
        child: Column(
          children: [
            SizedBox(
              child: Align(
                alignment: Alignment.topRight,
                child: Text(
                  DateFormat.yMMMMd('en_US')
                      .format(DateTime.parse(histo.datelivraison)),
                  style: TextStyle(
                      fontSize: ResponsiveFlutter.of(context).fontSize(2.5),
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: background,
                  backgroundImage: AssetImage('assets/images/avatar.png'),
                  radius: 30,
                ),
                SizedBox(
                  width: screenwidth * 0.1,
                ),
                Flexible(
                    child: Text(
                  histo.clientname + " " + histo.clientprenom,
                  maxLines: 2,
                  softWrap: true,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                      fontSize: ResponsiveFlutter.of(context).fontSize(3),
                      color: violet,
                      fontWeight: FontWeight.bold),
                )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  histo.pickup,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: ResponsiveFlutter.of(context).fontSize(2.2),
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: screenwidth * 0.02,
                ),
                CircleAvatar(
                  radius: ResponsiveFlutter.of(context).scale(10),
                  backgroundColor: orange,
                  child: CircleAvatar(
                    backgroundColor: background,
                    radius: ResponsiveFlutter.of(context).scale(7),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(2)),
                    width: ResponsiveFlutter.of(context).wp(25),
                    child: Divider(
                      thickness: 3,
                      color: grey2,
                      indent: 3,
                      endIndent: 3,
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: ResponsiveFlutter.of(context).scale(10),
                  backgroundColor: Colors.black,
                  child: CircleAvatar(
                    backgroundColor: background,
                    radius: ResponsiveFlutter.of(context).scale(7),
                  ),
                ),
                SizedBox(
                  width: screenwidth * 0.02,
                ),
                Text(
                  histo.dropoff,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: ResponsiveFlutter.of(context).fontSize(2.2),
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Center(
              child: Divider(
                thickness: 2,
                color: orange,
                indent: screenwidth * 0.2,
                endIndent: screenwidth * 0.2,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  histo.prix.toString() + " Da",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: ResponsiveFlutter.of(context).fontSize(3.5),
                      fontWeight: FontWeight.bold),
                ),
                RatingBar(
                  itemSize: 17,
                  initialRating: histo.note.toDouble(),
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  ignoreGestures: true,
                  itemCount: 5,
                  ratingWidget: RatingWidget(
                    full: Image(
                        color: orange,
                        image: AssetImage('assets/images/heart.png')),
                    half: Image(
                        color: orange,
                        image: AssetImage('assets/images/heart_half.png')),
                    empty: Image(
                        color: orange,
                        image: AssetImage('assets/images/heart_border.png')),
                  ),
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  onRatingUpdate: (rating) {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}