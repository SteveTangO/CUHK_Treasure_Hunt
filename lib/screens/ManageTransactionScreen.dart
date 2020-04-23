/*
  For managing transactions.
  Options: Complete, Delete
 */

import 'package:cuhk_treasure_hunt/database/Database.dart';
import 'package:cuhk_treasure_hunt/utilities/constants.dart';
import 'package:cuhk_treasure_hunt/utilities/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ManageTransactionScreen extends StatefulWidget{

  var transactionItem;
  var isSell;

  ManageTransactionScreen({this.transactionItem,this.isSell});

  @override
  ManageTransactionScreenState  createState() {
    return ManageTransactionScreenState();
  }
}

class ManageTransactionScreenState extends State<ManageTransactionScreen>{

  String rating = "";
  bool canComplete = true;

  Future<bool> completeTransaction()async{
    bool result = await Database.post(
        "/data/manageTransactions.php",
        {
          "action":"update",
          "rating":"$rating",
          "type" : "${widget.isSell?'s':'b'}",
          'transaction_id':'${widget.transactionItem['transaction_id']}'
        }
    );
    return result;
  }

  Future<bool> cancelTransaction()async{
    bool result = await Database.post(
        "/data/manageTransactions.php",
        {
          "action":"delete",
          "rating":"$rating",
          "type" : "${widget.isSell?'s':'b'}",
          'transaction_id':'${widget.transactionItem['transaction_id']}'
        }
    );
    return result;
  }

  Future<bool> showMessageDialog(String type, bool result)async{
    await showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
              title: Text("$type Transaction"),
              content: Text("${result?"Success":"Fail"}")
          );
        }
    );
    return true;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    print(widget.transactionItem);
    EdgeInsets padding = EdgeInsets.only(left: SizeConfig.safeBlockHorizontal*5, right: SizeConfig.safeBlockHorizontal*5);

    if (widget.isSell){
      if (widget.transactionItem['status_s'] == '1'){
        canComplete = false;
      }
    }
    else {
      if (widget.transactionItem['status_b'] == '1'){
        canComplete = false;
      }
    }


    return Scaffold(
      appBar: AppBar(title: Text("Manage Transaction"),),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: SizeConfig.safeBlockHorizontal*2, right: SizeConfig.safeBlockHorizontal*2),
          child: ListView(
            children: <Widget>[
              Container(
                height: SizeConfig.safeBlockVertical*50,
                width: SizeConfig.safeBlockHorizontal*100,
                child:
                Image.network(Database.hostname+"/data/images/"+widget.transactionItem['image'], height: SizeConfig.safeBlockVertical * 50, width: SizeConfig.safeBlockVertical * 100),
              ),
              Container(
                height: SizeConfig.safeBlockVertical*5,
                padding: padding,
                alignment: Alignment.bottomLeft,
                child: Text(widget.transactionItem['name'], style: kmiddle_black_textstyle),
              ),
              Container(
                height: SizeConfig.safeBlockVertical*5,
                padding: padding,
                alignment: Alignment.bottomLeft,
                child: Text("\$" + widget.transactionItem['price'], style: kmiddle_red_textstyle),
              ),
              Container(
                height: SizeConfig.safeBlockVertical*5,
                padding: padding,
                alignment: Alignment.bottomLeft,
                child: Text("Quantity: ${widget.transactionItem['quantity']}", style: kmiddle_black_textstyle),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    padding: padding,
                    height: SizeConfig.safeBlockVertical*5,
                    alignment: Alignment.centerLeft,
                    child: Text('Seller: ${widget.transactionItem['seller']}', style: ksmall_black_textstyle),
                  ),
                  Container(
                    padding: padding,
                    height: SizeConfig.safeBlockVertical*5,
                    alignment: Alignment.centerLeft,
                    child: Text('Status: ${widget.transactionItem['status_s']=='1'?"Complete":"Pending"}',
                        style: ksmall_black_textstyle),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    padding: padding,
                    height: SizeConfig.safeBlockVertical*5,
                    alignment: Alignment.centerLeft,
                    child: Text('Buyer: ${widget.transactionItem['buyer']}', style: ksmall_black_textstyle),
                  ),
                  Container(
                    padding: padding,
                    height: SizeConfig.safeBlockVertical*5,
                    alignment: Alignment.centerLeft,
                    child: Text('Status: ${widget.transactionItem['status_b']=='1'?"Complete":"Pending"}',
                        style: ksmall_black_textstyle),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    height: SizeConfig.safeBlockVertical * 5,
                    alignment: Alignment.bottomLeft,
                    child: Text('Title', style: ksmall_black_textstyle),
                  ),
                  Container(
                    height: SizeConfig.safeBlockVertical * 5,
                    width: SizeConfig.safeBlockHorizontal * 50,
                    child: TextField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      maxLines: 1,
                      decoration: InputDecoration(hintText: 'Rating out of 5'),
                      onChanged: (value) {
                        setState(() {
                          rating = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Divider(height: SizeConfig.safeBlockVertical*5,),
              FlatButton(
                color: Colors.amber,
                textColor: Colors.white,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                padding: EdgeInsets.all(8.0),
                splashColor: Colors.blueAccent,
                onPressed: rating != "" && canComplete? () async {
                  bool result = await completeTransaction();
                  result = await showMessageDialog("Complete", result);
                  Navigator.pop(context,true);
                }:null,
                child: Text(
                  "Complete Transaction",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              Divider(),
              FlatButton(
                color: Colors.amber,
                textColor: Colors.white,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                padding: EdgeInsets.all(8.0),
                splashColor: Colors.blueAccent,
                onPressed: () async {
                  bool result = await cancelTransaction();
                  result = await showMessageDialog("Cancel", result);
                  Navigator.pop(context,true);
                },
                child: Text(
                  "Cancel Transaction",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}