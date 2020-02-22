import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import 'package:rentabook/helper/quad_clipper.dart';
import 'package:rentabook/models/book.dart';
import 'package:rentabook/page/rent_form_page.dart';
import 'package:rentabook/theme/color/light_color.dart';
import 'package:rentabook/widget/header.dart';

class BookMenuPage extends StatefulWidget {

  @override
  _BookMenuPageState createState() => _BookMenuPageState();
}

class _BookMenuPageState extends State<BookMenuPage> {
  double width;

  Widget _categoryRow(
    String title,
    Color primary,
    Color textColor,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                color: LightColor.titleTextColor, fontWeight: FontWeight.bold),
          ),
          _chip("See all", primary)
        ],
      ),
    );
  }

  Widget _card(
      {Book book,
      Color primary = Colors.redAccent,
      String imgPath,
      String chipText1 = '',
      String chipText2 = '',
      String chipText3 = '',
      int duration,
      Widget backWidget,
      Color chipColor = LightColor.orange,
      bool isPrimaryCard = false}) {
    return Container(        
        height: isPrimaryCard ? 190 : 180,
        width: isPrimaryCard ? 400 * (0.32) : 400 * (0.32),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: BoxDecoration(
            color: primary.withAlpha(200),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  offset: Offset(0, 5),
                  blurRadius: 10,
                  color: LightColor.lightpurple.withAlpha(20))
            ]),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: Container(
            child: Stack(
              children: <Widget>[
                backWidget,
                Positioned(
                    top: 20,
                    left: 10,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey.shade300,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 5),
                          Center(
                            child: Text('$duration', style: TextStyle(fontSize: 12)),
                          ),
                          Center(
                            child: Text('Days', style: TextStyle(fontSize: 10)),
                          ),
                        ],
                      ),
                    )),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: _cardInfo(chipText1, chipText2, chipText3,
                      LightColor.titleTextColor, chipColor,
                      isPrimaryCard: isPrimaryCard),
                )
              ],
            ),
          ),
        ));
  }

  Widget _cardInfo(String title, String courses, String endDate,Color textColor, Color primary,
      {bool isPrimaryCard = false}) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: 10 ,right: 10),
            width: 300 * .32,
            alignment: Alignment.topCenter,
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: isPrimaryCard ? Colors.white : textColor),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 3,right: 10),
            width: 300 * .32,
            alignment: Alignment.topCenter,
            child: Text(
              courses,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                  color: isPrimaryCard ? Colors.white : textColor),
            ),
          ),
          SizedBox(height: 5),
          _chip(endDate, primary, height: 5, isPrimaryCard: isPrimaryCard)
        ],
      ),
    );
  }

  Widget _chip(String text, Color textColor,
      {double height = 0, bool isPrimaryCard = false}) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: height),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: textColor.withAlpha(isPrimaryCard ? 200 : 50),
      ),
      child: Text(
        text,
        style: TextStyle(
            color: isPrimaryCard ? Colors.white : textColor, fontSize: 12),
      ),
    );
  }

  Widget _decorationContainerB(Color primary, double top, double left) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: -65,
          right: -65,
          child: CircleAvatar(
            radius: 70,
            backgroundColor: Colors.blue.shade100,
            child: CircleAvatar(radius: 30, backgroundColor: primary),
          ),
        ),
        Positioned(
            top: 35,
            right: -40,
            child: ClipRect(
                clipper: QuadClipper(),
                child: CircleAvatar(
                    backgroundColor: LightColor.lightseeBlue, radius: 40)))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
      children: <Widget>[
        header(context, 'Main Menu', 'Hello, User!'),
        SizedBox(height: 20),
        _categoryRow("Active Rent Book", LightColor.orange, LightColor.orange),
        SizedBox(height: 230,child: _buildGraphicListView()),
      ],
      )),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => RentFormPage()
            ));
          },
          label: Text('Rent Book Here!'),
          backgroundColor: Colors.pinkAccent,
          icon: Icon(Icons.collections_bookmark)),
    );
  }

  Widget _buildGraphicListView() {
    return WatchBoxBuilder(
        box: Hive.box('books'),
        builder: (context, bookBox) {
          return ListView.builder(
            itemCount: bookBox.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final book = bookBox.getAt(index) as Book;
              final duration = book.endBorrowDate.difference(book.startBorrowDate).inDays;
              final String _endDate = DateFormat('dd-MM-yyyy').format(book.endBorrowDate);
              return _card(
                book: bookBox.get(index),
                primary: Colors.white,
                chipColor: LightColor.seeBlue,
                backWidget: _decorationContainerB(Colors.white, 90, -40),
                chipText1: book.bookTitle,
                chipText2: book.authorName,
                chipText3: _endDate,
                duration: duration,
                );
            },
          );
        });
  }
}
