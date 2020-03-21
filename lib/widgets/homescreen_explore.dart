import 'package:cuhk_treasure_hunt/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:cuhk_treasure_hunt/utilities/size_config.dart';

String searchinput;

class HomescreenExplore extends StatefulWidget {
  @override
  _HomescreenExploreState createState() => _HomescreenExploreState();
}

class _HomescreenExploreState extends State<HomescreenExplore> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context); //initialize the size config object so all sizes can be adjusted
    return Column(
      children: <Widget>[
        Container(child:
        Center(child: Text("TOLO Dynamic", style: khomescreen_title_textstyle,),),
          height: SizeConfig.safeBlockVertical*10,),
        Container(
          height: SizeConfig.safeBlockVertical*10,
            width: SizeConfig.safeBlockHorizontal*80,
            child: TextField(

              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              maxLines: 1,
              decoration: InputDecoration(
                  hintText: 'Search'
              ),
              onChanged: (value){
                searchinput = value;
                print(searchinput);
              },
            ),
        ),
        ExploreBody(),
      ],
    );
  }
}

// the body of the explore section: a scrollable list
class ExploreBody extends StatefulWidget {
  @override
  _ExploreBodyState createState() => _ExploreBodyState();
}

class _ExploreBodyState extends State<ExploreBody> {
  PageController _controller = PageController(
    initialPage: 0,
    viewportFraction: 1,  // to be changed later
  );
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: PageView(
          controller: _controller,
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ItemGridView(),
                    SizedBox(
                      width: SizeConfig.safeBlockHorizontal*10,
                    ),
                    ItemGridView(),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ItemGridView(),
                    SizedBox(
                      width: SizeConfig.safeBlockHorizontal*10,
                    ),
                    ItemGridView(),
                  ],
                ),

              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ItemGridView(),
                    SizedBox(
                      width: SizeConfig.safeBlockHorizontal*10,
                    ),
                    ItemGridView(),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ItemGridView(),
                    SizedBox(
                      width: SizeConfig.safeBlockHorizontal*10,
                    ),
                    ItemGridView(),
                  ],
                ),

              ],
            ),
          ],
        ));
  }
}


class ItemGridView extends StatefulWidget {
  @override
  _ItemGridViewState createState() => _ItemGridViewState();
}

class _ItemGridViewState extends State<ItemGridView> {
  @override

  //determine if the item is favored or not
  bool isFavorite = false;

  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.safeBlockVertical*30,
      width: SizeConfig.safeBlockHorizontal*40,
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                color: Colors.amber,
                height: SizeConfig.safeBlockVertical*20,
                width: SizeConfig.safeBlockHorizontal*40,
              ),
              Container(
                child: Text("Title"),
                height: SizeConfig.safeBlockVertical*2,
              ),
              Container(
                child: Text("Price"),
                height: SizeConfig.safeBlockVertical*2,
              ),
              Container(
                child: Text("New Asia"),
                height: SizeConfig.safeBlockVertical*2,
              ),

            ],
          ),
          Positioned(
            right: SizeConfig.safeBlockHorizontal*3,
              top: SizeConfig.safeBlockVertical*22,
              child: GestureDetector(
                onTap: (){
                  isFavorite = !isFavorite;
                  setState(() {
                  });
                },
                  child: isFavorite?Icon(Icons.favorite, color: Colors.pink,)
                      :Icon(Icons.favorite_border, color: Colors.pink,)),
          ),
        ],
      ),
    );
  }
}
