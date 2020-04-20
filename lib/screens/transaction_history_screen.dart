import 'package:cuhk_treasure_hunt/utilities/constants.dart';
import 'package:cuhk_treasure_hunt/utilities/size_config.dart';
import 'package:cuhk_treasure_hunt/widgets/long_item_card_Transaction_History.dart';
import 'package:flutter/material.dart';

import '../utilities/constants.dart';

class TransactionHistoryScreen extends StatefulWidget {
  @override
  _TransactionHistoryScreenState createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TransactionHistory History'),),
      body: SafeArea(
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index){
              return LongItemCardTransactionHistory();
            }),
      ),
    );
  }
}