import 'package:chat/auth/authentication.dart';
import 'package:chat/auth/chatAuthentic.dart';
import 'package:chat/pages/Home/chatWith.dart';
import 'package:chat/utils/theme.dart';
import 'package:flutter/material.dart';

class contact_screen extends StatelessWidget {
  contact_screen({super.key});
  final chatServices _chatservice = chatServices();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'contacts',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        _buildcontacts(),
      ],
    );
  }

  Widget _buildcontacts() {
    return StreamBuilder(
      stream: _chatservice.getContactName(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('404 : Error'),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Column(
          children: snapshot.data!.map((userData) {
            if (userData['email'] == authServices().getCurrentUser()!.email) {
              return Container();
            }
            return _buildNames(
              userData['firstName'],
              userData['lastName'],
              context,
              userData['uid'],
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildNames(
    String firstName,
    String lastName,
    BuildContext context,
    String reciverId,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => chatWith(
                reciverId: reciverId,
                fullName: firstName + " " + lastName,
              ),
            ));
          },
          child: Container(
            height: 70,
            width: 350,
            decoration: BoxDecoration(
              color: primeryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.person,
                    size: 20,
                  ),
                  Text(
                    firstName + ' ' + lastName,
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
