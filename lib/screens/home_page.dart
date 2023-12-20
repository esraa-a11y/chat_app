import 'package:chat_app/constant.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/screens/chat_page.dart';
import 'package:chat_app/screens/register_page.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
class HomePage extends StatefulWidget {
   HomePage({Key? key}) : super(key: key);
   static String id ='HomePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  String? email,password;
  GlobalKey<FormState> formKey= GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kprimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
            Image.asset('assets/scholar.png',
            height: 100,),
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
                    Text('LOGIN',style: TextStyle(color: Colors.white,fontSize: 18),),
                  ],
                ),
                const SizedBox(height: 20,),
                 CustomTextField(hintText: 'Email',onChanged: (data){email=data;},
                 ),
               const SizedBox(height: 10,),

                CustomTextField(
                    obsecureText: true,
                    hintText: 'Password',onChanged: (data){password=data;}),
                const SizedBox(height: 20,),

                CustomButton (
                    buttonName: 'LOGIN',
                    onTap:() async{
                      //var auth=  FirebaseAuth.instance;
                      if (formKey.currentState!.validate()) {
                        isLoading=true;
                        setState(() {

                        });
                        try {
                          await loginUser();
                          Navigator.pushNamed(context, ChatPage.id,arguments: email);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            showSnackBar(context,'No user found for that email.');
                          } else if (e.code == 'wrong-password') {
                            showSnackBar(context,'Wrong password provided for that user.');
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
                    Text('don\'t have an account?',style: TextStyle(
                      color: Colors.white,
                      fontSize:12 ,
                    ),),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder:(context){
                          return RegisterPage();
                        }
                        ));
                      },
                      child: Text(' Register',style: TextStyle(
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

  Future<void> loginUser() async {
    UserCredential user =await FirebaseAuth.instance.signInWithEmailAndPassword(email: email!, password: password!);
  }
}
