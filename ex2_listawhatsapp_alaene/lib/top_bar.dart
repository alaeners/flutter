// ignore_for_file: file_names
import 'package:flutter/material.dart';

class TopBar extends StatefulWidget {
  const TopBar({Key? key}) : super(key: key);
  @override
  TopBarState createState() => TopBarState();
}

class TopBarState extends State<TopBar> {
  var listaContatos = [
    {
      'image': NetworkImage("https://loremflickr.com/320/320"),
      'name': "Alaene",
      'tel': "+ 55 31 9 94767115"
    },
    {
      'image': NetworkImage("https://loremflickr.com/320/321"),
      'name': "Tonny - My cat",
      'tel': "+ 55 31 9 94767115"
    },
    {
      'image': NetworkImage("https://loremflickr.com/320/322"),
      'name': "Pedro - my boy",
      'tel': "+ 55 31 9 94767115"
    },
    {
      'image': NetworkImage("https://loremflickr.com/320/323"),
      'name': "Aleatorio 1",
      'tel': "+ 55 31 9 94767115"
    },
    {
      'image': NetworkImage("https://loremflickr.com/320/324"),
      'name': "Aleatorio 11",
      'tel': "+ 55 31 9 94767115"
    },
    {
      'image': NetworkImage("https://loremflickr.com/320/325"),
      'name': "Aleatorio 111",
      'tel': "+ 55 31 9 94767115"
    },
    {
      'image': NetworkImage("https://loremflickr.com/320/326"),
      'name': "Aleatorio 1111",
      'tel': "+ 55 31 9 94767115"
    },
    {
      'image': NetworkImage("https://loremflickr.com/320/327"),
      'name': "Aleatorio 11111",
      'tel': "+ 55 31 9 94767115"
    },
    {
      'image': NetworkImage("https://loremflickr.com/320/328"),
      'name': "Aleatorio 11111",
      'tel': "+ 55 31 9 94767115"
    },
    {
      'image': NetworkImage("https://loremflickr.com/320/329"),
      'name': "Aleatorio 111111",
      'tel': "+ 55 31 9 94767115"
    },
    {
      'image': NetworkImage("https://loremflickr.com/320/330"),
      'name': "Alaene",
      'tel': "+ 55 31 9 94767115"
    },
    {
      'image': NetworkImage("https://loremflickr.com/320/331"),
      'name': "Aleatorio 1111111",
      'tel': "+ 55 31 9 94767115"
    },
    {
      'image': NetworkImage("https://loremflickr.com/320/332"),
      'name': "Aleatorio 1111111",
      'tel': "+ 55 31 9 94767115"
    },
    {
      'image': NetworkImage("https://loremflickr.com/320/333"),
      'name': "Aleatorio 1111111",
      'tel': "+ 55 31 9 94767115"
    },
    {
      'image': NetworkImage("https://loremflickr.com/320/334"),
      'name': "Aleatorio 1111111",
      'tel': "+ 55 31 9 94767115"
    },
  ];

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
