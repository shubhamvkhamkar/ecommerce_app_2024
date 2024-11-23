import 'package:ecommerce_app_2024/model/admin/admin_panel_screen.dart';
import 'package:ecommerce_app_2024/model/authentication/auth_screen.dart';
import 'package:ecommerce_app_2024/widgets/custome_elevated_btn.dart';
import 'package:ecommerce_app_2024/widgets/custome_text_field_widget.dart';
import 'package:flutter/material.dart';

class AdminLogin extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _AdminLoginState();


}
class _AdminLoginState extends State<AdminLogin>{
  String currentForm = "admin";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _adminUserController = TextEditingController();
  final _adminPassController = TextEditingController();

  bool _isLoading = false;

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)));
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(message, style: const TextStyle(color: Colors.red))),
    );
  }

  void _authenticate() {
    final username = _adminUserController.text.trim();
    final password = _adminPassController.text.trim();

    if (currentForm == "admin") {
      if (username == 'admin' && password == 'admin') {
        _showMessage('Admin Login Successful');
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => AdminPanelScreen(),));

      } else {
        _showError('Invalid Admin Credentials');
      }
    }



  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       toolbarHeight: 75,
       backgroundColor: Colors.blue,
       title: Text('Admin Login'),
     ),
     backgroundColor: Colors.blue.shade100,
     body: Form(
     key: _formKey,
     child: Center(
       child: Padding(
         padding: const EdgeInsets.all(8.0),
         child: SingleChildScrollView(
           child: Column(
               mainAxisAlignment: MainAxisAlignment.center ,
               children: [
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 16),
                   child: Container(
                     child: Image.asset('assets/images/admin.png',height: 200,width: 200,),
                   ),
                 ),
                 SizedBox(height: 30,),
                 CustomeTextFieldWidget(

                   controller: _adminUserController,
                   hintText: 'Admin Username',
                   lableText: 'Username',
                   prefixIcon: Icons.verified_user,

                 ),
                 SizedBox(height: 16,),
                 CustomeTextFieldWidget(
                   controller: _adminPassController,
                   lableText: 'Password',
                   obscureText: true,
                   prefixIcon: Icons.remove_red_eye,
                   hintText: 'Admin Password',
                 ),
                 SizedBox(height: 24,),
                 CustomeElevatedBtn(onPressed: (){
                 _authenticate();
                 }, text: 'Admin Login',
                   ),

                 SizedBox(height: 16,),
                 TextButton(
                   onPressed: () {
                     Navigator.pushReplacement(context, MaterialPageRoute(
                       builder: (context) => AuthScreen(),));
                   },
                   child:Text('back to login') ,

                 ),
                 if (_isLoading)
                      CircularProgressIndicator()
               ],

           ),
         ),
       ),

     ),

   ),
   );
  }

}