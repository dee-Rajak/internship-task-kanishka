import 'package:flutter/material.dart';
import 'package:internship_task_kanishka/main.dart';
import 'package:internship_task_kanishka/widgets/auth_field.dart';
import 'package:internship_task_kanishka/widgets/rounded_small_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      );
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  bool _value = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('_signUp'),
        centerTitle: true,
        actions: [
          Switch(
              value: _value,
              onChanged: (value) {
                setState(() {
                  _value = value;
                  if (_value)
                    MyApp.of(context)!.changeTheme(ThemeMode.dark);
                  else
                    MyApp.of(context)!.changeTheme(ThemeMode.light);
                });
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 40),
          child: Column(
            children: [
              AuthField(controller: name, hintText: 'Name'),
              const SizedBox(
                height: 30,
              ),
              AuthField(controller: email, hintText: 'Email'),
              const SizedBox(
                height: 30,
              ),
              AuthField(controller: password, hintText: 'Password'),
              const SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.topRight,
                child: RoundedSmallButton(
                    onTap: () async {
                      SharedPreferences sp =
                          await SharedPreferences.getInstance();
                      await sp.setString('password', password.text);
                      await sp.setString('email', email.text);
                      await sp.setString('name', name.text);
                      Navigator.pop(context);
                    },
                    label: '_signUp'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
