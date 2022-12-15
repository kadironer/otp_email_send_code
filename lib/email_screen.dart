import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({Key? key}) : super(key: key);

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {

  var tfMail=TextEditingController();
  var tfSifre=TextEditingController();

  void kodGonder() async {
    EmailAuth emailAuth = EmailAuth(sessionName: "Doğrulama kodunuz");
    var mail = await emailAuth.sendOtp(recipientMail: tfMail.text);
    if (mail) {
      showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
              title: const Text("Başarılı"),
              content: Text("Kod Gönderildi"),
              actions: [
                TextButton(
                  child: const Text("Tamam"),
                  onPressed:(){
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                )
              ],
            );
          });
    }else{
      showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
              title: const Text("Başarısız"),
              content: Text("Kod Gönderilemedi"),
              actions: [
                TextButton(
                  child: const Text("Tamam"),
                  onPressed:(){
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                )
              ],
            );
          });
    }
  }
  void dogrulama() {
    EmailAuth emailAuth = EmailAuth(sessionName: "Doğrulama kodunuz");
    var res= emailAuth.validateOtp(recipientMail: tfMail.text, userOtp: tfSifre.text);

    if(res) {
      setState(() {
        showDialog(
            context: context,
            builder: (BuildContext context){
              return AlertDialog(
                title: const Text("Doğrulama Başarılı"),
                content: Lottie.network("https://assets2.lottiefiles.com/packages/lf20_s3tatv3q.json", width: 20),
                actions: [
                  TextButton(
                    child: const Text("Tamam"),
                    onPressed:(){
                      setState(() {
                        Navigator.pop(context);
                        tfMail.text="";
                        tfSifre.text="";
                      });
                    },
                  )
                ],
              );
            });
      });

    }
    else{
      setState(() {
        showDialog(
            context: context,
            builder: (BuildContext context){
              return AlertDialog(
                title: const Text("Uyarı!"),
                content: Lottie.network("https://assets5.lottiefiles.com/packages/lf20_ddxv3rxw.json", width: 20),
                actions: [
                  TextButton(
                    child: const Text("Yeniden Dene"),
                    onPressed:(){
                      setState(() {
                        Navigator.pop(context);

                      });
                    },
                  )
                ],
              );
            });
      });
    }

  }


  @override
  Widget build(BuildContext context) {

    var size= MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Mail Doğrulama"),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("resim/bubble-gum-otp-verification.png", width: size.width *0.8,),
              SizedBox(
                height: 50,
              ),
              SizedBox(
                width: size.width * 0.9,
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    suffixIcon: TextButton(
                      child: Text("Kodu Gönder"),
                      onPressed:() => kodGonder(),
                    ),
                    labelText: "Mail Adresi Giriniz",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    )
                  ),
                  controller: tfMail,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              SizedBox(
                width: size.width * 0.9,
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Gelen Kod",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    )
                  ),
                  controller: tfSifre,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              ElevatedButton(
                child: Text("Kodu Onayla"),
                onPressed: () => dogrulama(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
