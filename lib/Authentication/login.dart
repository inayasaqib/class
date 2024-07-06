import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unitool/Authentication/authentication.dart';
import 'package:unitool/Views/home.dart';

class Authentication extends StatefulWidget {
  const Authentication({super.key});

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  @override
  final emailController = TextEditingController();
  final passController = TextEditingController();
  loginUser(context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passController.text,
      );
      emailController.clear();
      passController.clear();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Home()));
      print("=============== LoggedIn Successfully ===================");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      print("=============== Catch ===================");
      print(e);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Login",
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: "Email",
                  icon: Icon(Icons.person),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: passController,
                decoration: const InputDecoration(
                  hintText: "Password",
                  icon: Icon(Icons.lock),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {},
                child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Forgot password?",
                      style: TextStyle(fontSize: 10),
                    )),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Center(
                child: ElevatedButton(
                    onPressed: () {
                      loginUser(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      minimumSize: const Size(250, 50),
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
            ),
            const SizedBox(height: 30,),
            Center(
              child: ElevatedButton.icon(
                      onPressed: () async {
                        bool auth = await Authenticate.authentication();
                        print("can authenticate : $auth");
                        if (auth) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Home()));
                        }
                      },
                      icon: const Icon(Icons.fingerprint_sharp),
                      label: const Text("Authenticate"),
                    ),
            )
          ],
        ),
      )),
    );
  }
}
