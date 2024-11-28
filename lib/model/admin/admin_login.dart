import 'package:ecommerce_app_2024/model/admin/admin_panel_screen.dart';
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
       title: Text('Admin'),
     ), body: Form(
     key: _formKey,
     child: Center(
       child: Column(
           mainAxisAlignment: MainAxisAlignment.center ,
           children: [

             TextField(
               controller: _adminUserController,
               decoration: InputDecoration(
                 labelText: 'Username',

               ),
             ),
             SizedBox(height: 16,),
             TextField(
               controller: _adminPassController,
               decoration: InputDecoration(
                 labelText: 'Password',

               ),
               obscureText: true,
             ),
             SizedBox(height: 24,),
             ElevatedButton(onPressed: (){
             _authenticate();
             },
               child: Text('Admin Login'),),


             SizedBox(height: 16,),

             if (_isLoading)
                  CircularProgressIndicator()


           ]),
     ),

   ),
   );
  }

}