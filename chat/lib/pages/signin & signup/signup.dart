import 'package:chat/auth/authentication.dart';
import 'package:chat/modals/userDetailModel.dart';
import 'package:chat/pages/Home/home.dart';
import 'package:chat/pages/signin%20&%20signup/bloc/auth_bloc.dart';
import 'package:chat/utils/button.dart';
import 'package:chat/utils/textField.dart';
import 'package:chat/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class signUpPage extends StatelessWidget {
  signUpPage({super.key});
  TextEditingController firstnameCon = TextEditingController();
  TextEditingController lastnameCon = TextEditingController();

  TextEditingController emailUpCon = TextEditingController();
  TextEditingController passwordCon = TextEditingController();
  TextEditingController confirmpasswordCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primeryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: ListView(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back),
            ),
            Center(
              child: Container(
                width: 350,
                decoration: BoxDecoration(
                  color: primeryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    const Center(
                      child: Text(
                        'Wellcome',
                        style: TextStyle(
                          fontSize: 30,
                          color: secondaryColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormfields(
                      firstnameCon,
                      'Input First Name ',
                      const Icon(Icons.person),
                      primeryColor,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormfields(
                      lastnameCon,
                      'Input last Name ',
                      const Icon(Icons.person),
                      primeryColor,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormfields(
                      emailUpCon,
                      'Input email ',
                      const Icon(Icons.email),
                      primeryColor,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormfields(
                      passwordCon,
                      'Input password',
                      const Icon(Icons.password),
                      primeryColor,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormfields(
                      confirmpasswordCon,
                      'confirm password',
                      const Icon(Icons.password),
                      primeryColor,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is failureState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.error),
                            ),
                          );
                        }
                        if (state is loginRequestedSuccessState) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => home_page(),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is LoadingState) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return button(() async {
                          context.read<AuthBloc>().add(signUpRequestedEvent(
                                  userData: userDetail(
                                LastName: lastnameCon.text,
                                firstName: firstnameCon.text,
                                password: passwordCon.text,
                                uid: authServices().getCurrentUser()!.uid,
                                email: emailUpCon.text,
                              )));
                        }, 200, 20, 'SignUp', context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
