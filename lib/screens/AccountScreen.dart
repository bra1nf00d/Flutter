import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testtask/services/index.dart';
import 'package:testtask/widgets/index.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: NavBar(title: 'Account'),
      body: const SignInForm(),
    );
  }
}

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  SignInFormState createState() {
    return SignInFormState();
  }
}

class SignInFormState extends State<SignInForm> {
  Future signInWithGoogle() async {
    await Provider.of<Auth>(context, listen: false).signIn();
  }

  Future signOut() async {
    await Provider.of<Auth>(context, listen: false).signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Form(
        child: Consumer<Auth>(
          builder: (context, auth, child) {
            final user = auth.user;

            if (user != null) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: user.photoUrl == null
                        ? Container(
                            padding: const EdgeInsets.all(50.0),
                            decoration: const BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle
                            ),
                          )
                        : CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(user.photoUrl!),
                            backgroundColor: Colors.blue,
                          ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                  Text(
                    'Name: ${user.displayName}',
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'Email: ${user.email}',
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.black),
                          shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                            ),
                          ),
                          minimumSize: MaterialStateProperty.all(
                            const Size(200, 60),
                          ),
                        ),
                        onPressed: signOut,
                        child: const Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 130,
                    height: 130,
                    margin: const EdgeInsets.only(
                      top: 30,
                    ),
                    child: Image.network(
                      "https://miro.medium.com/v2/resize:fit:1000/1*ilC2Aqp5sZd1wi0CopD1Hw.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 70,
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hey there",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Welcome back",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 10,
                        ),
                        child: Text(
                          "Sign in to your Google account",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.black),
                        shape: MaterialStateProperty.all(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                        minimumSize: MaterialStateProperty.all(
                          const Size(150, 60),
                        ),
                      ),
                      onPressed: signInWithGoogle,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 2.5,
                            ),
                            child: Image.network(
                              'http://pngimg.com/uploads/google/google_PNG19635.png',
                              fit:BoxFit.cover
                            ),
                          ),
                          const Text(
                            'Sign In with Google',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}