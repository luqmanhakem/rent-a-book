import 'package:flutter/material.dart';

import 'package:rentabook/theme/color/light_color.dart';
import 'package:rentabook/widget/circular_container.dart';

Widget subheader(BuildContext context, String title) {
    var width = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
      child: Container(
          height: 120,
          width: width,
          decoration: BoxDecoration(
            color: LightColor.orange,
          ),
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                  top: 10,
                  right: -120,
                  child: circularContainer(300, LightColor.lightOrange2)),
              Positioned(
                  top: -60,
                  left: -65,
                  child: circularContainer(width * .5, LightColor.darkOrange)),
              Positioned(
                  top: -230,
                  right: -30,
                  child: circularContainer(width * .7, Colors.transparent,
                      borderColor: Colors.white38)),
              Positioned(
                  top: 50,
                  left: 0,
                  child: Container(
                      width: width,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Stack(
                        children: <Widget>[
                          // Icon(
                          //   Icons.keyboard_arrow_left,
                          //   color: Colors.white,
                          //   size: 40,
                          // ),
                          Align(
                              alignment: Alignment.center,
                              child: Text(
                                title,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w500),
                              ))
                        ],
                      ))),
            ],
          )),
    );
  }