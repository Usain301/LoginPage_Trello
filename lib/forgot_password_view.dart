import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  bool _isSendMail = false;

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
                  child: Column(
                    children: [
                      const Text('Oturum açamıyor musunuz?', style: TextStyle(fontSize: 20.0)),
                      const SizedBox(height: 40.0),
                      Form(
                        key: _formKey,
                        child: TextFormField(
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
                      ),
                      const SizedBox(height: 20.0),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF59AC44),
                          minimumSize: const Size(double.infinity, 50.0),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                        ),
                        onPressed: () => _sendMail(),
                        child: _isSendMail
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text('Kurtama maili gönder'),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _sendMail() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSendMail = true);

    await Future.delayed(const Duration(seconds: 2));

    setState(() => _isSendMail = false);

    if (_emailCtrl.text == 'test@gmail.com') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(backgroundColor: Colors.green, content: Center(child: Text('Email gönderildi'))),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(backgroundColor: Colors.redAccent, content: Center(child: Text('Email bulunamadı'))),
      );
    }
  }
}
