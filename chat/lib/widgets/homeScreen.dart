import 'package:chat/pages/Home/contact/contacts.dart';
import 'package:chat/utils/theme.dart';
import 'package:chat/pages/Home/contact/contactScreen.dart';
import 'package:flutter/material.dart';

class homeScreen extends StatelessWidget {
  const homeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Text(
          'Welcom to the best chat app',
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.amber),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 200,
          width: 200,
          child: Image(
            fit: BoxFit.fill,
            image: AssetImage('assets/images/welcome.png'),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 70,
          width: 200,
          child: MaterialButton(
            height: 80,
            minWidth: 150,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => contacts(),
              ));
            },
            color: secondaryColor,
            child: Row(
              children: [
                Text(
                  'Go to contacts',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(Icons.arrow_forward_ios)
              ],
            ),
          ),
        )
      ],
    );
  }
}
