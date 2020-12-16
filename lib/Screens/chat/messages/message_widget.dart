import 'package:enactusnca/Helpers/constants.dart';
import 'package:enactusnca/Models/messages_model.dart';
import 'package:enactusnca/Screens/Profile/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  MessageWidget({this.message, this.group});

  final MessageModel message;
  final bool group;
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          user.uid == message.userId ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        user.uid == message.userId
            ? Container(
                padding: EdgeInsets.all(12.0),
                height: 64,
                width: 64,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(34.0),
                  child: message.userImg != null
                      ? Image.network(
                          message.userImg,
                          fit: BoxFit.contain,
                          loadingBuilder: (context, child, loadingProgress) {
                            return loadingProgress == null
                                ? child
                                : Center(child: CircularProgressIndicator());
                          },
                        )
                      : Image.asset('assets/images/enactus.png'),
                ),
              )
            : Container(),
        Container(
          width: MediaQuery.of(context).size.width * 0.75,
          decoration: BoxDecoration(
            color: user.uid != message.userId ? Constants.lightBlue : Constants.midBlue,
            borderRadius: user.uid == message.userId
                ? BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    bottomLeft: Radius.circular(15.0),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  ),
          ),
          margin: user.uid == message.userId
              ? EdgeInsets.only(top: 8.0, bottom: 8.0)
              : EdgeInsets.only(top: 8.0, bottom: 8.0),
          padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // group == true
              //     ? Text(
              //         message.userName,
              //         style: TextStyle(
              //           fontSize: 16.0,
              //           fontWeight: FontWeight.w400,
              //           color: Colors.blueGrey.shade100,
              //         ),
              //       )
              //     : Container(),
              Text(
                message.message,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.blueGrey.shade100,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                '${message.userName} - ${message.timestamp.toDate().hour.toString()}:${message.timestamp.toDate().minute.toString()}',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w200,
                  color: Colors.grey.shade100,
                ),
              ),
            ],
          ),
        ),
        user.uid != message.userId
            ? InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Profile(
                        isAppBarEnabled: true,
                        userId: message.userId,
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(12.0),
                  height: 64,
                  width: 64,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(34.0),
                    child: message.userImg != null
                        ? Image.network(
                            message.userImg,
                            fit: BoxFit.contain,
                            loadingBuilder: (context, child, loadingProgress) {
                              return loadingProgress == null
                                  ? child
                                  : Center(child: CircularProgressIndicator());
                            },
                          )
                        : Image.asset('assets/images/enactus.png'),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}