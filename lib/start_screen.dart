import 'package:flutter/material.dart';
import 'package:internship_task_kanishka/login_screen.dart';
import 'package:internship_task_kanishka/main.dart';
import 'package:internship_task_kanishka/signup_screen.dart';
import 'package:internship_task_kanishka/widgets/common_button.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  bool _value = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🙏 _welcome 🙏'),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: Center(
          child: Column(
            children: [
              CommonButton(
                onTap: () {
                  Navigator.push(context, LoginScreen.route());
                },
                text: 'Login',
              ),
              CommonButton(
                onTap: () {
                  Navigator.push(context, SignUpScreen.route());
                },
                text: 'Signup',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
