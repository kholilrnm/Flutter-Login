// ignore_for_file: implementation_imports

// import 'package:absensi/services/baseurl_service.dart';
// import 'package:absensi/ui/shared/theme.dart';
// import 'package:absensi/ui/pages/login/components/background_login.dart';
// import 'package:absensi/ui/pages/main_page.dart';
import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:get/get.dart';

class BodyLogin extends StatefulWidget {
  const BodyLogin({
    Key? key,
  }) : super(key: key);

  @override
  State<BodyLogin> createState() => _BodyLoginState();
}

class _BodyLoginState extends State<BodyLogin> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  bool _isVisible = false;
  bool _loader = false;
  bool _validateUser = false;
  bool _validatePwd = false;

  void updateStatIcons() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  _cekLogin() async {
    setState(() => _loader = true);
    setState(() {
      _namaController.text.isEmpty
          ? _validateUser = true
          : _validateUser = false;
      _pwdController.text.isEmpty ? _validatePwd = true : _validatePwd = false;
    });

    print(">>>>>>>>>>>>>>> :" + _namaController.text);
    print(">>>>>>>>>>>>>>> :" + _pwdController.text);
    _showAlertDialog(context, _namaController.text, _pwdController.text);

    // final String sUrl = baseUrlApiSiapo + "api/login?";
    // final prefs = await SharedPreferences.getInstance();
    // var params =
    //     "username=" + _namaController.text + "&password=" + _pwdController.text;
    // var res = await http.post(Uri.parse(sUrl + params));

    // try {
    //   if (res.statusCode == 200) {
    //     var response = json.decode(res.body);
    //     if (response['message'] == "Success") {
    //       prefs.setBool('slogin', true);
    //       prefs.setString('username', response['data']['username']);
    //       prefs.setString('nama', response['data']['profil']['namalengkap']);
    //       prefs.setString('satkerid', response['data']['profil']['satker_id']);
    //       prefs.setString(
    //           'jnskelamin', response['data']['profil']['jenis_kelamin']);
    //       Get.off(() => const MainPage());
    //     } else {
    //       _showAlertDialog(context, response['data']);
    //     }
    //   } else {
    //     _showAlertDialog(context, 'Mohon maaf, data Anda tidak ditemukan !');
    //   }
    // } catch (e) {
    //   _showAlertDialog(context, 'Mohon maaf, system error : $e');
    // }
    // setState(() {
    //   _loader = false;
    // });
  }

  _showAlertDialog(BuildContext context, String info) {
    Widget okButton = TextButton(
      child: Text("OK", style: TextStyle(color: kPrimary)),
      onPressed: () => Navigator.pop(context),
    );

    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Row(
        children: [
          const Text("Peringatan"),
          const SizedBox(
            width: 7,
          ),
          Icon(
            Icons.info_outline,
            color: kPrimary,
          )
        ],
      ),
      content: Text(info),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BackgroundLogin(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Visibility(
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              visible: _loader,
              child: const SizedBox(
                width: 1,
                height: 1,
                child: Text(''),
              )),
          // Image.asset(
          //   'assets/images/login_bg.png',
          //   width: size.width * 0.4,
          // ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 5, 15),
                child: Icon(
                  Icons.account_circle_outlined,
                  size: 40,
                  color: Colors.green[900],
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                  child: SizedBox(
                    width: 260,
                    height: 70,
                    child: TextField(
                      controller: _namaController,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Username',
                          hintText: 'Enter valid username',
                          errorText: _validateUser
                              ? 'Username Can\'t Be Empty !'
                              : null),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 5, 15),
                child: Icon(
                  Icons.lock_clock_outlined,
                  size: 40,
                  color: Colors.green[900],
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                  child: SizedBox(
                    width: 260,
                    height: 70,
                    child: TextField(
                      controller: _pwdController,
                      obscureText: _isVisible ? false : true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Password',
                        hintText: 'Enter valid password',
                        errorText:
                            _validatePwd ? 'Password Can\'t Be Empty ! ' : null,
                        suffixIcon: IconButton(
                          onPressed: () => updateStatIcons(),
                          icon: Icon(_isVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: Center(
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                child: ElevatedButton.icon(
                  icon: _loader
                      ? Container(
                          width: 25,
                          height: 25,
                          padding: const EdgeInsets.all(2.0),
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ),
                        )
                      : const Icon(Icons.login),
                  label: const Text(
                    'Login',
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () => _loader ? null : _cekLogin(),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      minimumSize: const Size(200, 50),
                      primary: kPrimary),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 35,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Container(
          //       margin: const EdgeInsets.fromLTRB(9, 9, 9, 9),
          //       height: 40,
          //       width: 40,
          //       decoration: const BoxDecoration(
          //         image: DecorationImage(
          //           image: AssetImage('assets/images/splash_bottom.png'),
          //           fit: BoxFit.cover,
          //         ),
          //       ),
          //     ),
          //     const Text('Diskominfo Kabupaten Mojokerto'),
          //   ],
          // ),
          const SizedBox(height: 30)
        ],
      ),
    );
  }
}
