
import 'package:chat_app/models/message.dart';
import 'package:chat_app/widgets/chat_buble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constant.dart';
class ChatPage extends StatelessWidget {
static String id ='ChatPage';
CollectionReference messages =FirebaseFirestore.instance.collection(kMessagesCollection);
TextEditingController controller =TextEditingController();
final _controller=ScrollController();
  @override
  Widget build(BuildContext context) {
    var email =ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreatedAt,descending:true).snapshots(),
      builder: (context,snapshot){
        if(snapshot.hasData){
          List<Message> messagesList=[];
          for(int i =0;i<snapshot.data!.docs.length;i++){
            messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
          }
          print(snapshot.data!.docs[0]['message']);

          return Scaffold(
            appBar:AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: kprimaryColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(kLogo,
                    height: 50,),
                  Text('Scholar Chat'),
                ],
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller:  _controller ,
                    itemCount: messagesList.length,
                      itemBuilder: (context,index){

                    return messagesList[index].id==email?
                    ChatBuble(message: messagesList[index],): ChatBubleForFriend(message: messagesList[index]);
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data){
                      messages.add({
                       kMessage:data,
                       kCreatedAt: DateTime.now(),
                        'id':email,
                      });
                      controller.clear();
                      _controller.animateTo(
                        0,
                          duration: Duration(seconds: 1,), curve: Curves.easeIn,);
                    },
                    decoration: InputDecoration(
                      hintText: 'Send Message',
                      suffixIcon: Icon(Icons.send,color: kprimaryColor,),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),

                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: kprimaryColor,
                        ),
                      ),

                    ),
                  ),
                ),
              ],
            ),
          );
        }
        else{
          return Text('Loading....');
        }
      },
     
    );
  }
}

