import 'package:chat/auth/authentication.dart';
import 'package:chat/modals/userDetailModel.dart';
import 'package:chat/pages/Home/profilePage/profile.dart';
import 'package:chat/pages/signin%20&%20signup/signin.dart';
import 'package:chat/utils/theme.dart';
import 'package:chat/pages/Home/contact/contactScreen.dart';
import 'package:chat/widgets/homeScreen.dart';
import 'package:chat/pages/Home/profilePage/profileScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class home_page extends StatefulWidget {
  home_page({super.key});

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(
      length: 2,
      vsync: this,
    );
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: appBarColor,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                expandedHeight: 150,
                flexibleSpace: ListView(
                  children: [
                    StreamBuilder(
                        stream: authServices().getContactDetails(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text('error');
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return Column(
                            children: snapshot.data!.map((e) {
                              if (e['uid'] ==
                                  authServices().getCurrentUser()!.uid) {
                                return _buildUserDetail(
                                  e['firstName'],
                                  e['lastName'],
                                  e['password'],
                                );
                              } else {
                                return Container();
                              }
                            }).toList(),
                          );
                        }),
                  ],
                ),
                bottom: TabBar(
                  controller: tabController,
                  tabs: [
                    Tab(
                      icon: Icon(
                        Icons.home_outlined,
                        color: Color.fromARGB(255, 255, 110, 7),
                      ),
                      child: Container(
                        child: const Text('Home'),
                      ),
                    ),
                    Tab(
                      icon: Icon(
                        Icons.contact_page_rounded,
                        color: Color.fromARGB(255, 255, 110, 7),
                      ),
                      child: Container(
                        child: const Text('Contacts'),
                      ),
                    ),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: tabController,
            children: [
              homeScreen(),
              contact_screen(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserDetail(
    String firstName,
    String lastName,
    String password,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => profilePage(
                  full_name: firstName + " " + lastName,
                  password: password,
                ),
              ),
            );
          },
          child: CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(
              'assets/images/welcome.png',
            ),
          ),
        ),
        Text(
          'CHAT HOME',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black54),
        ),
        IconButton(
          onPressed: () {
            authServices().logOutUser();
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => signPage(),
            ));
          },
          icon: Icon(
            Icons.login_outlined,
          ),
        )
      ],
    );
  }
}
