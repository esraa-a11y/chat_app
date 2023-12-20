import 'package:chat_app/constant.dart';
import 'package:chat_app/models/message.dart';
import 'package:flutter/material.dart';
class ChatBuble extends StatelessWidget {
   const ChatBuble({
    super.key,
    required this.message,
  });
 final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(

        padding: EdgeInsets.only(left: 16,top: 32,bottom: 32,right: 32 ),
        margin: EdgeInsets.symmetric(horizontal:16,vertical: 8),
        decoration: BoxDecoration(
          color: kprimaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
        ),
        child: Text(message.message,
          style: TextStyle(
            color: Colors.white,
          ),),
      ),
    );
  }
}
class ChatBubleForFriend extends StatelessWidget {
   ChatBubleForFriend({
    super.key,
    required this.message,
  });
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(

        padding: EdgeInsets.only(left: 16,top: 32,bottom: 32,right: 32 ),
        margin: EdgeInsets.symmetric(horizontal:16,vertical: 8),
        decoration: BoxDecoration(
          color: Color(0xff006D84),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomLeft: Radius.circular(32),
          ),
        ),
        child: Text(message.message,
          style: TextStyle(
            color: Colors.white,
          ),),
      ),
    );
  }
}
