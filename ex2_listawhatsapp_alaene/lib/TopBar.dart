// ignore_for_file: file_names
import 'package:flutter/material.dart';

class TopBar extends StatefulWidget {
  const TopBar({Key? key}) : super(key: key);
  @override
  TopBarState createState() => TopBarState();
}

class TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 50,
          alignment: Alignment.bottomCenter,
          width: MediaQuery.of(context).size.width,
          color: Colors.green.shade700,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
                color: Colors.white),
            height: MediaQuery.of(context).size.height - 200,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16, right: 10, bottom: 10),
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 240,
            child: ListView.builder(
                itemCount: 15,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.all(10),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.lightGreen,
                            backgroundImage: NetworkImage(
                                "https://loremflickr.com/320/32$index"),
                          )),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 160,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const <Widget>[
                            Text(
                              "Alaene <3",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                }),
          ),
        ),
      ],
    );
  }
}
