import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hmc_map/main.dart';

class Join extends StatelessWidget {
  String? emailID;
  String? pw;
  String? rePw;
  Join({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Join us"),
        ),
        body: Column(
          children: [
            CustomTextField(label: "email address", onChangedFunc: (String text){emailID = text;} , isPassword: false, ),
            CustomTextField(label: "password", onChangedFunc: (String text){pw = text;} , isPassword: true, ),
            CustomTextField(label: "re-password", onChangedFunc: (String text){rePw = text;} , isPassword: true, ),
            ElevatedButton(onPressed: () async {
              if(pw != rePw) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                          title: const Text("비밀번호 유효성체크"),
                          content: const Text("확인용 비밀번호가 일치하지 않습니다."),
                          actions: [TextButton(onPressed: (){Navigator.of(context).pop();}, child: const Text("OK"))]

                      );
                    }

                );
              } else {
                if (emailID != null && pw != null) {
                  try {
                    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: emailID!,
                      password: pw!,
                    );

                    if (context.mounted) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                                title: const Text("회원 가입 안내"),
                                content: const Text("회원 가입이 완료되었습니다."),
                                actions: [TextButton(onPressed: (){Navigator.popUntil(context, (route) => route.isFirst);}, child: const Text("OK"))]
                            );
                          }
                      );
                    }
                  }on FirebaseAuthException catch(e) {
                    if (e.code == "weak-password") {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                                title: const Text("비밀번호 유효성 체크"),
                                content: const Text("비밀번호가 너무 짧습니다."),
                                actions: [TextButton(onPressed: () {
                                  Navigator.of(context).pop();
                                }, child: const Text("OK"))
                                ]
                            );
                          }
                      );
                    } else if (e.code == "email-already-in-use") {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                                title: const Text("이메일 유효성 체크"),
                                content: const Text("기존에 가입된 이메일 입니다."),
                                actions: [TextButton(onPressed: () {
                                  Navigator.of(context).pop();
                                }, child: const Text("OK"))
                                ]
                            );
                          }
                      );
                    }
                  } catch(e) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                              title: const Text("예기치 못한 에러"),
                              content: Text(e.toString()),
                              actions: [TextButton(onPressed: () {
                                Navigator.of(context).pop();
                              }, child: const Text("OK"))
                              ]
                          );
                        }
                    );
                  }
                }
              }
            },
                child: Container(
                    width: 200,
                    height: 50,
                    alignment: Alignment.center,
                    child: const Text("Join", textAlign: TextAlign.center,)
                )
            )
          ],
        )

    );
  }
}