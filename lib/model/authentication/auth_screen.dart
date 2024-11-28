import 'package:ecommerce_app_2024/model/admin/admin_login.dart';
import 'package:ecommerce_app_2024/provider/auth_providers.dart';
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

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isLogin = true; // Toggle between Sign In and Sign Up
  bool _isLoading = false;
  bool isSignUp = false;



  Future<void> _authenticate() async {
    if (!_formKey.currentState!.validate()) return;

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

   /* final adminUsername = _adminUserController.text.trim();
    final adminPassword = _adminPassController.text.trim();*/

    setState(() => _isLoading = true);

    try {
      if(isAdmin){
       Navigator.pushReplacement(context, MaterialPageRoute(
           builder: (context) =>  AdminLogin(),));
      }

      if(_isLogin)  {
        // Sign In
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
        title: Text(_isLogin ? "Login" : "Sign Up"),
      ),
      body: Padding(
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


                    SizedBox(height: 16,),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(labelText: "Email"),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || !value.contains('@')) {
                          return "Please enter a valid email";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(labelText: "Password"),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return "Password must be at least 6 characters long";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),
                     if (_isLoading)
                      CircularProgressIndicator()
                    else
                      ElevatedButton(
                        onPressed: _authenticate,
                        child: Text(_isLogin ? "Login" : "Sign Up"),
                      ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(_isLogin
                          ? "Don't have an account? Sign Up"
                          : "Already have an account? Log In"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => AdminLogin(),));
                      },
                      child:Text('Login only Admin') ,

                    ),

                  ],
                ),
              ),
            ],
          ),







          ),

           )

    );
  }
}
