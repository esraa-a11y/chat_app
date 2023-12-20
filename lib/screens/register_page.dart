import 'package:chat_app/constant.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/screens/chat_page.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterPage extends StatefulWidget {
   RegisterPage({Key? key}) : super(key: key);
   static String id = 'RegisterPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

 String? email;

 String? password;

 bool isLoading = false;

GlobalKey<FormState> formKey= GlobalKey();

   @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor:kprimaryColor ,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                Image.asset('assets/scholar.png',height: 100,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Scholar Chat',style: TextStyle(
                      color: Colors.white,
                      fontSize:30 ,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'pacifico',
                    ),),
                  ],
                ),

                Row(
                  children: [
                    Text('Register',style: TextStyle(color: Colors.white,fontSize: 18),),
                  ],
                ),
                const SizedBox(height: 20,),
                CustomTextField(
                  onChanged: (data){
                    email=data;
                  },
                  hintText: 'Email',),
                const SizedBox(height: 10,),

                CustomTextField(
                  obsecureText: true,

                  onChanged: (data){
                    password=data;
                  },
                  hintText: 'Password',),
                const SizedBox(height: 20,),

                CustomButton (
                  buttonName: 'Register',
                  onTap:() async{
                  var auth=  FirebaseAuth.instance;
                  if (formKey.currentState!.validate()) {
                    isLoading=true;
                    setState(() {

                    });
                    try {
                      await registerUser(auth);
                      Navigator.pushNamed(context, ChatPage.id,arguments: email);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        showSnackBar(context,'The password provided is too weak.');
                      } else if (e.code == 'email-already-in-use') {
                        showSnackBar(context,'email-already-in-use');
                      } }
                    catch(e){
                      showSnackBar(context,'error');

                    }
                    isLoading=false;
                    setState(() {

                    });
                    showSnackBar(context,'success');
                  }
                 else{}
                  }
                ),
                const  SizedBox(height: 10,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('already have an account?',style: TextStyle(
                      color: Colors.white,
                      fontSize:12 ,
                    ),),
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Text(' Login',style: TextStyle(
                        color: Color(0xffC7EDE6),
                        fontSize:12 ,
                      ),),
                    ),

                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

   // void showSnackBar(BuildContext context, String message) {
   //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
   // }

   Future<void> registerUser(FirebaseAuth auth) async {
     UserCredential user =await auth.createUserWithEmailAndPassword(email: email!, password: password!);
   }
}
