import 'package:flutter/material.dart';
import 'package:social_app/components/my_button.dart';
import 'package:social_app/components/my_textfield.dart';

class RegisterPage extends StatelessWidget {
  final void Function()? onTap;
  
  RegisterPage({super.key, required this.onTap});

  // text controllers
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPwController = TextEditingController();



  void register() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(child: 
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
              onTap: register
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
                  onTap: onTap,
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
      )
    );
  }
}