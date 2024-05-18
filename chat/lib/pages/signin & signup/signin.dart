import 'package:chat/auth/authentication.dart';
import 'package:chat/modals/userDetailModel.dart';
import 'package:chat/pages/Home/home.dart';
import 'package:chat/pages/signin%20&%20signup/bloc/auth_bloc.dart';
import 'package:chat/pages/signin%20&%20signup/signup.dart';
import 'package:chat/utils/button.dart';
import 'package:chat/utils/textField.dart';
import 'package:chat/utils/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class signPage extends StatelessWidget {
  signPage({super.key});
  TextEditingController nameCon = TextEditingController();
  TextEditingController emailUpCon = TextEditingController();
  TextEditingController passwordCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: ListView(
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    border: Border.all(color: Colors.red),
                  ),
                  height: 150,
                  width: 200,
                  child: const Image(
                    fit: BoxFit.fill,
                    image: AssetImage(
                      'assets/images/chat.png',
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  height: 450,
                  width: 350,
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          'Wellcome',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormfields(
                        nameCon,
                        'Input Name',
                        const Icon(Icons.person),
                        Colors.grey.shade400,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormfields(
                        emailUpCon,
                        'Input email',
                        const Icon(Icons.email),
                        Colors.grey.shade400,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormfields(
                        passwordCon,
                        'Input password ',
                        const Icon(Icons.password),
                        Colors.grey.shade400,
                      ),
                      const SizedBox(
                        height: 10,
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
                          return button(() {
                            context.read<AuthBloc>().add(
                                  loginRequestedEvent(
                                      userData: userDetail(
                                    LastName: nameCon.text,
                                    firstName: nameCon.text,
                                    password: passwordCon.text,
                                    uid: '',
                                    email: emailUpCon.text,
                                  )),
                                );
                          }, 200, 20, 'SignIn', context);
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(secondaryColor),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => signUpPage(),
                                ),
                              );
                            },
                            child: Text(
                              'SignUp',
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
