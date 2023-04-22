import 'package:flutter/material.dart';
import 'package:internship_task_kanishka/home.dart';
import 'package:internship_task_kanishka/main.dart';
import 'package:internship_task_kanishka/widgets/auth_field.dart';
import 'package:internship_task_kanishka/widgets/rounded_small_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  bool _value = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('_login'),
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
                      String? s_email = sp.getString('email');
                      String? s_password = sp.getString('password');
                      String? s_name = sp.getString('name');
                      print('$email, $password');
                      if (s_email == email.text &&
                          s_password == password.text) {
                        Navigator.push(context, HomeScreen.route());
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Invalid Credentials'),
                          ),
                        );
                      }
                    },
                    label: '_login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
