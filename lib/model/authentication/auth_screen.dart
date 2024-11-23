import 'package:ecommerce_app_2024/model/admin/admin_login.dart';
import 'package:ecommerce_app_2024/model/screens/forgot_password_screen.dart';
import 'package:ecommerce_app_2024/provider/auth_providers.dart';
import 'package:ecommerce_app_2024/widgets/custome_elevated_btn.dart';
import 'package:ecommerce_app_2024/widgets/custome_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../screens/home_screen.dart';



class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isAdmin = false;
  bool _isLogin = true; // Toggle between Sign In and Sign Up
  bool _isLoading = false;
  bool isSignUp = false;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();





  Future<void> _authenticate() async {
    if (!_formKey.currentState!.validate()) return;

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();


    setState(() => _isLoading = true
    );

    try {
      if(isAdmin){
       Navigator.pushReplacement(context, MaterialPageRoute(
           builder: (context) =>  AdminLogin(),));
      }

      if(_isLogin)  {
        //Sign In
        await Provider.of<AuthProviders>(context, listen: false)
            .signIn(email, password);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomeScreen()),

        );
      }
      else{
        // Sign Up
        await Provider.of<AuthProviders>(context, listen: false)
            .signUp(email, password);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign Up successful! Please log in.')),
        );
        setState(() => _isLogin = true);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).primaryColor,
        toolbarHeight: 75,
        title: Text('Welcome To Ecomm 2024',
          style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      backgroundColor: Colors.deepPurple.shade100,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 16),
              child: Container(
                child: Image.asset('assets/images/user1.jpeg',height: 200,width: 200,),
              ),
            ),
            SizedBox(height: 30,),
            Center(child: Text(_isLogin ? "Login" : "Sign Up",
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 26),)),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
               
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center ,
                        children: [
                         CustomeTextFieldWidget(

                             hintText: 'Enter Your EmailID', //  Email
                             controller: _emailController,
                             prefixIcon: Icons.email,
                             lableText: 'Email',

                             validator: (value) {
                               if (value == null || !value.contains('@')) {
                                 return "Please enter a valid email";
                               }
                               return null;
                             },

                         )
                          ,
                          SizedBox(height: 16,),
                          CustomeTextFieldWidget(
                            lableText: 'Password',
                            hintText: 'Enter Your Password',
                            controller: _passwordController,
                            prefixIcon: Icons.remove_red_eye_rounded,
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.length < 6) {
                                return "Password must be at least 6 characters long";
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 10),
                           if(_isLogin)
                             Align(alignment: Alignment.centerRight,
                               child: TextButton(onPressed: () {
                                 Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen(),));
                               },
                                   child: Text('Forgot Password?'),
                               ),
                             ),

                           SizedBox(),
                           if (_isLoading)
                            CircularProgressIndicator()
                          else
                            CustomeElevatedBtn(
                              text: _isLogin ? "Login" : "Sign Up",
                              onPressed: _authenticate,

                            ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _isLogin = !_isLogin;
                              });
                            },
                            child: Text(_isLogin
                                ? "Don't have an account? Sign Up"
                                : "Already have an account? Log In",
                            style: TextStyle(fontWeight: FontWeight.bold),),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(context, MaterialPageRoute(
                                builder: (context) => AdminLogin(),));
                            },
                            child:Text('Login only Admin',
                              style: TextStyle(fontWeight: FontWeight.bold),) ,

                          ),

                        ],
                      ),
                    ),
                  ],
                ),
            
                ),
            
                 ),
          ],
        ),
      )

    );
  }
}
