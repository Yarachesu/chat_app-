import 'package:chat/auth/authentication.dart';
import 'package:chat/modals/userDetailModel.dart';
import 'package:chat/pages/signin%20&%20signup/bloc/auth_bloc.dart';
import 'package:chat/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class profilePage extends StatefulWidget {
  final String full_name;
  final String password;
  profilePage({
    super.key,
    required this.password,
    required this.full_name,
  });

  @override
  State<profilePage> createState() => _profilePageState();
}

Map<String, dynamic>? k;
TextEditingController Fcontroller = TextEditingController();
TextEditingController Lcontroller = TextEditingController();
TextEditingController Pcontroller = TextEditingController();

class _profilePageState extends State<profilePage> {
  @override
  void initState() {
    _authData();

    super.initState();
  }

  Future<void> _authData() async {
    k = await authServices().userMap();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final fu = context.watch<AuthBloc>().state as loginRequestedSuccessState;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/images/default.jpg'),
                ),
                Positioned(
                  bottom: -3,
                  right: -3,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.camera_alt_outlined,
                      color: primeryColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return Text(widget.full_name);
              },
            ),
            SizedBox(
              height: 15,
            ),
            displayUserInfo(
                UpdateUserData: () async {
                  authServices().updateName(
                    uid: k!['uid'],
                    firstName: Fcontroller.text,
                    lastName: Lcontroller.text,
                  );
                  Navigator.of(context).pop();
                },
                nameOrEmail: widget.full_name,
                isname: true,
                title: 'change your name'),
            SizedBox(
              height: 15,
            ),
            displayUserInfo(
                UpdateUserData: () async {
                  String res = await authServices().updatePassword(
                    uid: k!['uid'],
                    Newpassword: Pcontroller.text,
                  );
                  Navigator.of(context).pop();
                  if (res == 'success') {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('successfuly chaged!')));
                  } else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(res)));
                    print(k!['uid']);
                  }
                },
                nameOrEmail: widget.password,
                isname: false,
                title: 'change your password'),
          ],
        ),
      ),
    );
  }
}

class displayUserInfo extends StatelessWidget {
  final String title;
  final bool isname;
  final String nameOrEmail;
  final VoidCallback UpdateUserData;
  const displayUserInfo({
    super.key,
    required this.UpdateUserData,
    required this.nameOrEmail,
    required this.isname,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            Text(
              nameOrEmail,
              style: TextStyle(fontSize: 18),
            ),
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => SimpleDialog(
                    contentPadding: EdgeInsets.only(left: 15),
                    title: Text(title),
                    insetPadding: EdgeInsets.symmetric(horizontal: 10),
                    children: [
                      isname
                          ? UsertextField(
                              controller: Fcontroller,
                              lable: 'first name',
                            )
                          : UsertextField(
                              controller: Pcontroller,
                              lable: 'enter password',
                            ),
                      SizedBox(
                        height: 13,
                      ),
                      isname
                          ? UsertextField(
                              controller: Lcontroller,
                              lable: 'last name',
                            )
                          : Container(),
                      SizedBox(
                        height: 13,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextButton(
                              onPressed: UpdateUserData,
                              child: Icon(Icons.check),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              child: Text('change'),
            ),
          ],
        ),
      ),
    );
  }
}

class UsertextField extends StatelessWidget {
  final String lable;
  final controller;
  const UsertextField({
    super.key,
    required this.controller,
    required this.lable,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        label: Text(lable),
      ),
    );
  }
}
