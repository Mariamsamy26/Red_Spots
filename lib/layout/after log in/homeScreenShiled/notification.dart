import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(219, 203, 227, 1.0),
      appBar: AppBar(
        title: const Text('Notification'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.notifications_active),
            onPressed: () {},
          ),
        ],
        shape: RoundedRectangleBorder(),
        backgroundColor: Color.fromRGBO(219, 203, 227, 1.0),
        elevation: 50,
      ),
      body: NotificationList(),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      title: Text('Notification'),
    );
  }

  Widget NotificationList() {
    return ListView.separated(
        itemBuilder: (context, index) {
          return ListViewItem(index);
        },
        separatorBuilder: (context, index) {
          return Divider(height: 0);
        },
        itemCount: 15);
  }

  Widget ListViewItem(int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 13, vertical: 10),
      child: Row(
        children: [
          prefixIcon(),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [massage(index), timeAndData(index)],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget prefixIcon() {
    return Container(
      height: 50,
      width: 50,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.transparent,
      ),
      child: Icon(Icons.watch_later_outlined, size: 25, color: Colors.black),
    );
  }

  Widget massage(int index) {
    double textSize = 14;
    return Container(
      child: RichText(
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
              text: 'Massage',
              style: TextStyle(
                  fontSize: textSize,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                    text: 'MassageDiscraption',
                    style: TextStyle(fontWeight: FontWeight.w400))
              ])),
    );
  }

  Widget timeAndData(int index) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '07:10 am',
            style: TextStyle(
              fontSize: 10,
            ),
          )
        ],
      ),
    );
  }
}
