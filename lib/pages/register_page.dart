import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app/components/my_button.dart';
import 'package:social_app/components/my_textfield.dart';
import '../helper/helper_functions.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text controllers
  final TextEditingController usernameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPwController = TextEditingController();

  void registerUser() async {
    // show loading circle
    showDialog(
      context: context, 
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      )
    );

    // check passwords 
    if (passwordController.text != confirmPwController.text) {
      // pop loading circle
      Navigator.pop(context);

      // show error
      displayMessageToUser("Passwords don't match!", context);
    }

    else {
      // try creating the user
      try {
        UserCredential? userCredential = 
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: emailController.text, 
              password: passwordController.text
            );

        createUserDocument(userCredential);

        if(context.mounted) Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);

        displayMessageToUser(e.code, context);
      }
    }
  }


  Future<void> createUserDocument(UserCredential? userCredential) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
        .collection("Users")
        .doc(userCredential.user!.email)
        .set({
          'email' : userCredential.user!.email,
          'username' : usernameController.text,
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Center(child: 
        Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // logo
              Icon(
                Icons.person,
                size: 80,
                color: Theme.of(context).colorScheme.inversePrimary
              ),
        
              const SizedBox(height: 25,),
        
              // app name
              const Text(
                "M I N I M A L", 
                style: TextStyle(
                  fontSize: 20
                )
              ),
        
              const SizedBox(height: 50,),
        
              //email textfield
              MyTextField(
                hintText: "Username", 
                obscureText: false, 
                controller: usernameController
              ),
      
              const SizedBox(height: 10,),
      
              MyTextField(
                hintText: "Email", 
                obscureText: false, 
                controller: emailController
              ),
      
              const SizedBox(height: 10,),
              // password textfield
              MyTextField(
                hintText: "Password", 
                obscureText: true, 
                controller: passwordController
              ),
      
              const SizedBox(height: 10,),
      
              MyTextField(
                hintText: "Confirm Password", 
                obscureText: true, 
                controller: confirmPwController
              ),
      
              const SizedBox(height: 25,),
      
              // sign in button
              MyButton(
                text: "Register", 
                onTap: registerUser
              ),
      
              const SizedBox(height: 25),
        
              // don't have an account? 
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary
                    )
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      " Login",
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      )
                    ),
                  )
                ],
              )
            ]
            ),
        ),
        ),
      )
    );
  }
}