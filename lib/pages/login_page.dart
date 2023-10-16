import 'package:flutter/material.dart';
import 'package:social_app/components/my_textfield.dart';

class LoginPage extends StatelessWidget {

  // text controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  LoginPage({super.key});

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
            // forgot password
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Forgot Password?", style: TextStyle(color: Theme.of(context).colorScheme.secondary),),
              ],
            )
            // sign in button
      
            // don't have an account? 
      
          ]
          ),
      ),
      )
    );
  }
}