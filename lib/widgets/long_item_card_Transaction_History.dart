import 'package:cuhk_treasure_hunt/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:cuhk_treasure_hunt/screens/chatroom_screen.dart';

class LongItemCardTransactionHistory extends StatefulWidget {
  String price;
  String name;
  String time;
  LongItemCardTransactionHistory({this.name,this.price,this.time});
  @override
  _LongItemCardTransactionHistoryState createState() => _LongItemCardTransactionHistoryState();
}

class _LongItemCardTransactionHistoryState extends State<LongItemCardTransactionHistory> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.safeBlockVertical * 15,
      width: SizeConfig.screenWidth,
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.safeBlockHorizontal * 2,
          vertical: SizeConfig.safeBlockVertical * 1),
      child: Row(
        children: <Widget>[
          Container(
            height: SizeConfig.safeBlockVertical * 13,
            width: SizeConfig.safeBlockHorizontal * 20,
            color: Colors.amber,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text(widget.name),
                  ),
                  Container(
                    child: Text(widget.price),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: SizeConfig.safeBlockVertical * 13,
            width: SizeConfig.safeBlockHorizontal * 15,
              child: Center(
                child: Text(widget.time),
              )
          ),
        ],
      ),
    );
  }
}