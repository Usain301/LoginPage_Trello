import 'package:flutter/material.dart';
import 'package:flutter_application_4/forgot_password_view.dart';
import 'package:flutter_application_4/home_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  bool _isLogin = false, _isShowPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9FAFC),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SvgPicture.asset(
                  'assets/trello_logo.svg',
                  height: 50.0,
                ),
                const SizedBox(height: 50),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const Text('Trelloya giriş yap', style: TextStyle(fontSize: 20.0)),
                        const SizedBox(height: 40.0),
                        TextFormField(
                          controller: _emailCtrl,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Lütfen bir email giriniz';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            hintText: 'Email',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          controller: _passwordCtrl,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Lütfen bir şifre giriniz';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: 'Şifre',
                              border: const OutlineInputBorder(),
                              suffix: IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  onPressed: () {
                                    setState(() => _isShowPassword = !_isShowPassword);
                                  },
                                  icon: Icon(
                                    _isShowPassword ? Icons.visibility : Icons.visibility_off,
                                  ))),
                          obscureText: !_isShowPassword ? true : false,
                        ),
                        const SizedBox(height: 10.0),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (context) => const ForgotPasswordView()));
                            },
                            child: const Text(
                              'Şifremi Unuttum',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),

                        // login button
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF59AC44),
                            minimumSize: const Size(double.infinity, 50.0),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                          ),
                          onPressed: () async => _login(),
                          child: _isLogin
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text('Giriş Yap'),
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          'veya',
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 30),
                        // google login button
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            minimumSize: const Size(double.infinity, 50.0),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                          ),
                          onPressed: () async {},
                          child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                            FaIcon(FontAwesomeIcons.google),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Google ile devam edin'),
                          ]),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // Microsoft login button
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            minimumSize: const Size(double.infinity, 50.0),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                          ),
                          onPressed: () async {},
                          child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                            FaIcon(FontAwesomeIcons.microsoft),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Microsoft ile devam edin'),
                          ]),
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        // facebook login button
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            minimumSize: const Size(double.infinity, 50.0),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                          ),
                          onPressed: () async {},
                          child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                            FaIcon(FontAwesomeIcons.facebook),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Facebook ile devam edin'),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLogin = true);

    await Future.delayed(const Duration(seconds: 2));

    setState(() => _isLogin = false);

    // check auth credential
    if (_emailCtrl.text == 'test@gmail.com' && _passwordCtrl.text == '123456') {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeView()));
    } else {
      // show error auth credential
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(backgroundColor: Colors.redAccent, content: Center(child: Text('Email veya şifre hatalı'))),
      );
    }
  }
}
