import 'package:flutter/material.dart';
import 'stopwatch.dart';
import 'appbar.dart';

class LoginScreen extends StatefulWidget {

  @override
  State<LoginScreen>createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool loggedIn = false;
  late String name;

  void _validate() {
    final form = _formKey.currentState;
    if (!form!.validate()) {
      return;
    }

    final name = _nameController.text;
    final email = _emailController.text;

    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => AppBarr(name:name, email:email, key: _formKey, )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar (
          title: Text('Login'),
        ),
        body: Center(
          child: _buildLoginForm(),
        )
    );
  }

  Widget _buildSuccess() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.check, color: Colors.orangeAccent),
        Text('Hi $name'),
      ],
    );
  }

  Widget _buildLoginForm() {
    return Form (
      key: _formKey,
      child: Padding (
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Runner'),
              validator: (text) => text!.isEmpty ? 'Enter the runner\'s name.' : null,
            ),

            TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (text) {
                  if (text!.isEmpty) {
                    return 'Enter email.' ;
                  }
                  final regex = RegExp('[^@+@[^\.]+\..+');
                  if (!regex.hasMatch(text)) {
                    return 'Enter a valid email';
                  }
                  return null;
                }
            ),

            SizedBox(height: 20),
            ElevatedButton(
                onPressed: _validate,
                child: Text('Continue'))


          ],
        ),
      ),
    );
  }
}