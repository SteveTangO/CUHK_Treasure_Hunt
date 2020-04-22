import 'package:cuhk_treasure_hunt/classes/Item.dart';
import 'package:cuhk_treasure_hunt/screens/detail_screen.dart';
import 'package:cuhk_treasure_hunt/screens/search_screen.dart';
import 'package:cuhk_treasure_hunt/utilities/constants.dart';
import 'package:cuhk_treasure_hunt/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:cuhk_treasure_hunt/database/Database.dart';
import 'package:http/http.dart';

class ItemGridView extends StatefulWidget {
  final Item item;
  Set<String> tagset = new Set();
  Future<List<Response>> _posterandtags;
  Future<List<Response>> getPosterAndTags() async {
    print("try getting poster and tags info!");
    Response posterinfo;
    posterinfo = await Database.get("/data/checkProfile.php?check_id=" + item.poster_id, "");
    print(posterinfo.body);
    Response tagsinfo;
    tagsinfo = await Database.get("/data/tags.php?item_id=" + item.item_id, "");
    print(tagsinfo.body);
    return <Response>[posterinfo, tagsinfo];
  }
  ItemGridView(this.item) {
    _posterandtags = getPosterAndTags();
  }
  @override
  _ItemGridViewState createState() => _ItemGridViewState();
}


class _ItemGridViewState extends State<ItemGridView> {
  
  bool isFavorite = false;

  //determine if the item is favored or not
  
  @override
  Widget build(BuildContext context) {
    
    SizeConfig().init(context);

    return FutureBuilder<List<Response>>(
      future: widget._posterandtags,
      builder: (BuildContext context, AsyncSnapshot<List<Response>> snapshot) {
        String college = "Loading...";
        if (snapshot.hasData) {
          var resultlist = json.decode(snapshot.data[0].body);
          var taglist = json.decode(snapshot.data[1].body);
          print("targetlist runtimetype " + taglist.runtimeType.toString());
          print("is targetlist a list?" + (taglist is List<String>).toString());
          print("targetlist tostring" + taglist.toString());
          print("targetlist content type " + taglist[0].runtimeType.toString());
          widget.tagset = new Set();
          taglist.forEach((tag) {
            widget.tagset.add(tag);
          });
          print("widget.tagset tostring" + widget.tagset.toString());
          
          college = resultlist[0]["college"];
          return GestureDetector(
          child: Container(
          height: SizeConfig.safeBlockVertical * 30,
          width: SizeConfig.safeBlockHorizontal * 40,
          child: Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Image.network(widget.item.image, width: SizeConfig.safeBlockHorizontal * 40, height: SizeConfig.safeBlockVertical * 20),
                    height: SizeConfig.safeBlockVertical * 20,
                    width: SizeConfig.safeBlockHorizontal * 40,
                  ),
                  Container(
                    child: Text(widget.item.name),
                    height: SizeConfig.safeBlockVertical * 2,
                  ),
                  Container(
                    child: Text("\$" + widget.item.price, style: ksmall_red_textstyle),
                    height: SizeConfig.safeBlockVertical * 2,
                  ),
                  Container(
                    child: Text(college),
                    height: SizeConfig.safeBlockVertical * 2,
                  ),
                ],
              ),
              Positioned(
                right: SizeConfig.safeBlockHorizontal * 3,
                top: SizeConfig.safeBlockVertical * 22,
                child: GestureDetector(
                    onTap: () {
                      isFavorite = !isFavorite;
                      setState(() {});
                    },
                    child: isFavorite
                        ? Icon(
                            Icons.favorite,
                            color: Colors.pink,
                          )
                        : Icon(
                            Icons.favorite_border,
                            color: Colors.pink,
                          )),
              ),
            ],
          ),
        ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DetailScreen(item: widget.item, userinfo: resultlist[0], tagset: widget.tagset)),
            );
          });
        }
        else {
          return Container(
          height: SizeConfig.safeBlockVertical * 30,
          width: SizeConfig.safeBlockHorizontal * 40,
          child: Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Image.network(widget.item.image, width: SizeConfig.safeBlockHorizontal * 40, height: SizeConfig.safeBlockVertical * 20),
                    height: SizeConfig.safeBlockVertical * 20,
                    width: SizeConfig.safeBlockHorizontal * 40,
                  ),
                  Container(
                    child: Text(widget.item.name),
                    height: SizeConfig.safeBlockVertical * 2,
                  ),
                  Container(
                    child: Text("\$" + widget.item.price, style: ksmall_red_textstyle),
                    height: SizeConfig.safeBlockVertical * 2,
                  ),
                  Container(
                    child: Text(college),
                    height: SizeConfig.safeBlockVertical * 2,
                  ),
                ],
              ),
              Positioned(
                right: SizeConfig.safeBlockHorizontal * 3,
                top: SizeConfig.safeBlockVertical * 22,
                child: GestureDetector(
                    onTap: () {
                      isFavorite = !isFavorite;
                      setState(() {});
                    },
                    child: isFavorite
                        ? Icon(
                            Icons.favorite,
                            color: Colors.pink,
                          )
                        : Icon(
                            Icons.favorite_border,
                            color: Colors.pink,
                          )),
              ),
            ],
          ),
        );
        }
      }
    );
  }
}

// To return a widget that scrolls down the page to view the items
class ItemListView extends StatefulWidget {
  final List<Item> itemlist;
  List<String> tags = Item.tags;
  ItemListView(this.itemlist, this.tags);
  @override
  _ItemListView createState() => _ItemListView();
}

class _ItemListView extends State<ItemListView> {
  Widget build(BuildContext context) {
    List<ItemGridView> itemGridList;
    itemGridList = [];
    widget.itemlist.forEach((item) {
      ItemGridView toadd = ItemGridView(item);
      bool hastag = true;
      toadd.tagset.forEach((tag) {
        if (!widget.tags.contains(tag)) hastag = false;
      });
      if (hastag) itemGridList.add(toadd);
    });
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: (widget.itemlist.length ~/ 2 + widget.itemlist.length % 2),
        itemBuilder: (context, index) {
          List<Widget> children = [
            itemGridList[index * 2],
            SizedBox(
              width: SizeConfig.safeBlockHorizontal * 10,
            ),
          ];
          if (index + 1 <= widget.itemlist.length ~/ 2) {
            children.add(
              itemGridList[index * 2 + 1],
            );
          }
          else {
            children.add(
              SizedBox(
                width: SizeConfig.safeBlockHorizontal * 40,
              )
            );
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: children,
          );
        });
  }
}
