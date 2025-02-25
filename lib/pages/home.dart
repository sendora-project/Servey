import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:servey/components/box.dart';
import 'package:servey/components/button.dart';
import 'package:servey/components/container.dart';
import 'package:servey/components/field.dart';
import 'package:servey/components/form.dart';
import 'package:servey/components/page.dart';
import 'package:servey/misc/validations.dart';
import 'package:servey/utils/style.dart';
import 'package:servey/utils/theme.dart';

import 'package:passkeys/authenticator.dart';
import 'package:passkeys/availability.dart';
import 'package:passkeys/exceptions.dart';
import 'package:passkeys/types.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PasskeyAuthenticator passkey = PasskeyAuthenticator();
  final Dio dio = Dio();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _HomePageState() {
    dio.options.baseUrl = 'mail.noideaindustry.com';
  }

  @override
  Widget build(BuildContext context) {
    return PageComponent(
      name: 'Home',
      content: [
        ContainerComponent(
          width: 450,
          backgroundColor: ThemeUtils.kDark,
          content: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset("assets/images/logo.png", width: 300),
              BoxComponent.smallHeight,
              FormComponent(
                handle: _formKey,
                components: [
                  FieldComponent(
                    validation: GeneralValidation.kDefault,
                    controller: _usernameController,
                    backgroundColor: ThemeUtils.kSecondary,
                    hintText: 'Username',
                  ),
                  BoxComponent.smallHeight,
                  FieldComponent(
                    validation: GeneralValidation.kPassword,
                    controller: _passwordController,
                    isSecure: true,
                    backgroundColor: ThemeUtils.kSecondary,
                    hintText: 'Password',
                  ),
                ],
                buttons: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ButtonComponent(
                        padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                        backgroundColor: ThemeUtils.kPrimary,
                        hoverColor: ThemeUtils.kPrimaryHover,
                        content: Text(
                          'Login',
                          style: StyleUtils.highLightStyle,
                        ),
                        onPressed: () async {
                          bool isValid = _formKey.currentState!.validate();
                          if (!isValid) return;

                          await _sendLoginRequest(
                            _usernameController.text,
                            _passwordController.text,
                          );
                        },
                      ),
                      BoxComponent.smallWidth,
                      ButtonComponent(
                        padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                        backgroundColor: ThemeUtils.kPrimary,
                        hoverColor: ThemeUtils.kPrimaryHover,
                        content: Text(
                          'FIDO2/WebAuth Login',
                          style: StyleUtils.highLightStyle,
                        ),
                        onPressed: () async {
                          await _sendFido2Request();
                        },
                      ),
                      const Spacer(),
                      IconButtonComponent(
                        tip: 'Forgot password?',
                        icon: Icon(
                          FontAwesomeIcons.key,
                          color: ThemeUtils.kPrimary,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _sendLoginRequest(String username, String password) async {
    final response = await dio.get('/api/v1/get/fido2-get-args');
    if (response.statusCode != 200) return;

    final content = jsonDecode(response.data);
  }

  Future<void> _sendFido2Request() async {
    try {
      final fidoRequest = await dio.get('/api/v1/get/fido2-get-args');
      if (fidoRequest.statusCode != 200) return;

      final content = jsonDecode(fidoRequest.data);

      final passkeyRequest = AuthenticateRequestType(
        relyingPartyId: content['rpId'],
        challenge: base64Url.encode(base64.decode(content['challenge'])),
        timeout: int.parse(content['timeout']),
        userVerification: content['userVerification'],
        mediation: MediationType.Optional,
        preferImmediatelyAvailableCredentials: true,
      );

      final authRequest = await passkey.authenticate(passkeyRequest);

      print("Authentication successful");
    } catch (e) {
      print("Authentication failed");
    }
  }
}
