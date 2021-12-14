// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'list_description.dart';

class TopBar extends StatefulWidget {
  const TopBar({Key? key}) : super(key: key);
  @override
  TopBarState createState() => TopBarState();
}

class TopBarState extends State<TopBar> {
  late String titleDescription = "";

  var listaContatos = [
    {
      'url': "https://loremflickr.com/320/320",
      'name': "Alaene",
      'tel': "+ 55 31 9 12345678"
    },
    {
      'url': "https://loremflickr.com/320/321",
      'name': "Tonny - My cat",
      'tel': "+ 55 31 9 234567890"
    },
    {
      'url': "https://loremflickr.com/320/322",
      'name': "Pedro - my boy",
      'tel': "+ 55 31 9 345678901"
    },
    {
      'url': "https://loremflickr.com/320/323",
      'name': "Aleatorio 1",
      'tel': "+ 55 31 9 456789012"
    },
    {
      'url': "https://loremflickr.com/320/324",
      'name': "Aleatorio 11",
      'tel': "+ 55 31 9 567890123"
    },
    {
      'url': "https://loremflickr.com/320/325",
      'name': "Aleatorio 111",
      'tel': "+ 55 31 9 678901234"
    },
    {
      'url': "https://loremflickr.com/320/326",
      'name': "Aleatorio 1111",
      'tel': "+ 55 31 9 789012345"
    },
    {
      'url': "https://loremflickr.com/320/327",
      'name': "Aleatorio 11111",
      'tel': "+ 55 31 9 890123456"
    },
    {
      'url': "https://loremflickr.com/320/328",
      'name': "Aleatorio 11111",
      'tel': "+ 55 31 9 901234567"
    },
    {
      'url': "https://loremflickr.com/320/329",
      'name': "Aleatorio 111111",
      'tel': "+ 55 31 9 102345678"
    },
    {
      'url': "https://loremflickr.com/320/330",
      'name': "Alaene",
      'tel': "+ 55 31 9 11234567"
    },
    {
      'url': "https://loremflickr.com/320/331",
      'name': "Aleatorio 1111111",
      'tel': "+ 55 31 9 122345678"
    },
    {
      'url': "https://loremflickr.com/320/332",
      'name': "Aleatorio 1111111",
      'tel': "+ 55 31 9 134567890"
    },
    {
      'url': "https://loremflickr.com/320/333",
      'name': "Aleatorio 1111111",
      'tel': "+ 55 31 9 14767115"
    },
    {
      'url': "https://loremflickr.com/320/334",
      'name': "Aleatorio 1111111",
      'tel': "+ 55 31 9 15767115"
    },
  ];

  void _navigateToNextScreen(BuildContext context, String title) {
    titleDescription = title.toString();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => DescriptionContact(title: title.toString())));
  }

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
                itemCount: listaContatos.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _navigateToNextScreen(
                          context, listaContatos[index]['name'].toString());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.all(10),
                            child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.lightGreen,
                                backgroundImage: NetworkImage(
                                    listaContatos[index]['url'].toString()))),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 160,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                listaContatos[index]['name'].toString(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                listaContatos[index]['tel'].toString(),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ),
      ],
    );
  }
}
