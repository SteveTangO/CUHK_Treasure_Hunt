import 'package:cuhk_treasure_hunt/classes/User.dart';
import 'package:cuhk_treasure_hunt/database/Database.dart';
import 'package:cuhk_treasure_hunt/screens/browsing_history_screen.dart';
import 'package:cuhk_treasure_hunt/screens/favorite_screen.dart';
import 'package:cuhk_treasure_hunt/screens/login_screen.dart';
import 'package:cuhk_treasure_hunt/screens/posted_item_screen.dart';
import 'package:cuhk_treasure_hunt/screens/transaction_history_screen.dart';
import 'package:cuhk_treasure_hunt/utilities/size_config.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';

class HomescreenProfile extends StatefulWidget {
  const HomescreenProfile({Key key}) : super(key: key);
  @override
  _HomescreenProfileScreenState createState() =>
      _HomescreenProfileScreenState();
}

class _HomescreenProfileScreenState extends State<HomescreenProfile> {
  String username;
  String studentID;
  String reputation = "0.0000";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    Future<Response> get_favotite()async{
      var favorites;
      favorites =await Database.get("/data/favourites.php", "");
      return favorites;
    }

    Future<Response> get_items()async{
      var items;
      items =await Database.get("/data/itemsPosted.php", "");
      return items;
    }

    Future<Response> get_user()async{
      var user;
      user = await Database.get("/data/profile.php", "");
      return user;
    }

    void set_user() async{
      Response user = await get_user();
      setState(() {
        username = json.decode(user.body)[0]['username'];
        studentID = json.decode(user.body)[0]['student_id'];
        reputation = json.decode(user.body)[0]['reputation'];
      }
      );
    }
    set_user();



    return Scaffold(
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 1,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //user icon, user's email and reputation
              Container(
                height: SizeConfig.safeBlockHorizontal * 25,
                width: SizeConfig.safeBlockHorizontal * 25,
                decoration: new BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ), //user icon
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical * 1,
              ),
              Container(
                child: Text(
                  "$username",
                  style: TextStyle(fontSize: 24),
                ), //user name
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical * 1,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text(
                      "email: $studentID@link.cuhk.edu.hk",
                    ), //user email
                  ),
                  Container(
                    child: Text("reputation: ${reputation.substring(0,4)}/5.00"), //user reputation
                  ),
                ],
              ),
              // user email and reputation
              // Location, Posted items, Favourites, Transaction history, Browsing History
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // all 4 rows
//                  Row(
//                    // location
//                    children: <Widget>[
//                      Container(
//                          height: SizeConfig.safeBlockVertical * 10,
//                          width: SizeConfig.safeBlockVertical * 15,
//                          child: Icon(
//                            Icons.location_on,
//                            color: Colors.black,
//                          )),
//                      FlatButton(
//                        onPressed: () {}, //go to location
//                        child: Container(
//                          child: Text(
//                            "Location",
//                            style: TextStyle(fontSize: 24),
//                          ),
//                        ),
//                      ),
//                    ],
//                  ),
                  Row(
                    // Posted items
                    children: <Widget>[
                      Container(
                          height: SizeConfig.safeBlockVertical * 10,
                          width: SizeConfig.safeBlockVertical * 15,
                          child: Icon(
                            Icons.shopping_basket,
                            color: Colors.black,
                          )),
                      FlatButton(
                        onPressed: () async{
                          var item_list;
                          try{
                            Response items = await get_items();
                            if (items.body!=null)
                            {
                              print("the body is not null");

                              item_list = json.decode(items.body);
                              print(json.decode(items.body),);
                              print("decode complete");
                            }
                            else
                              print("the body is null");
                          }
                          catch(e){
                            print("fail to acquire the list");
                          }
                          //FavoriteScreen(favorite_list: favorite_list,)),
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder:
                                (context) => PostedItemsScreen(itemList: item_list,)),
                          );
                        }, //go to posted items
                        child: Container(
                          child: Text(
                            "Posted items",
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    // Favourites
                    children: <Widget>[
                      Container(
                          height: SizeConfig.safeBlockVertical * 10,
                          width: SizeConfig.safeBlockVertical * 15,
                          child: Icon(Icons.favorite_border)),
                      GestureDetector(
                        onTap: () async{
                          var favorite_list;
                          try{
                            Response favorites = await get_favotite();
                            if (favorites.body!=null)
                              {
                                print("the body is not null");

                                favorite_list = json.decode(favorites.body);
                                print(json.decode(favorites.body),);
                                print("decode complete");
                              }
                            else
                              print("the body is null");
                          }
                          catch(e){
                            print("fail to acquire the list");
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FavoriteScreen(favorite_list: favorite_list,)),
                          );
                        }, //go to Favourites
                        child: Container(
                          child: Text(
                            "Favourites",
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    // Transaction history
                    children: <Widget>[
                      Container(
                          height: SizeConfig.safeBlockVertical * 10,
                          width: SizeConfig.safeBlockVertical * 15,
                          child: Icon(
                            Icons.shopping_cart,
                            color: Colors.black,
                          )),
                      FlatButton(
                        onPressed:() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder:
                                (context) => TransactionHistoryScreen(),),
                          );
                        }, //go to Transaction history
                        child: Container(
                          child: Text(
                            "Transaction history",
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                      ),
                    ],
                  ),
//                  Row(
//                    // Browsing History
//                    children: <Widget>[
//                      Container(
//                          height: SizeConfig.safeBlockVertical * 10,
//                          width: SizeConfig.safeBlockVertical * 15,
//                          child: Icon(
//                            Icons.history,
//                            color: Colors.black,
//                          )),
//                      FlatButton(
//                        onPressed: () {
//                          Navigator.push(
//                            context,
//                            MaterialPageRoute(builder:
//                                (context) => BrowsingHistoryScreen(),),
//                          );
//                        }, //go to Browsing History
//                        child: Container(
//                          child: Text(
//                            "Browsing History",
//                            style: TextStyle(fontSize: 24),
//                          ),
//                        ),
//                      ),
//                    ],
//                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 1,
                  ),
                  Container(
                    // Log out
                    child: FlatButton(
                      onPressed:() {
                        User.logout();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                        );
                      }, //Lot out
                      child: Container(
                        height: SizeConfig.safeBlockVertical * 5,
                        width: SizeConfig.safeBlockVertical * 25,
                        child: Center(
                          child: Text(
                            "Log Out",
                            style: TextStyle(fontSize: 24),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        color: Colors.red[200],
                      ),
                    ),
                  ),
                  SizedBox(height: SizeConfig.safeBlockVertical*10,),
                ],
              ),
            ],
          ),
          );
        },
      ),
    );
  }
}
