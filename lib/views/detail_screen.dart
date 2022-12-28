import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  String? name;
  String? description;
  String? image;
  String? price;
  double? rating;
  String? category;
  DetailScreen(
      {Key? key,
      this.category,
      this.rating,
      this.price,
      this.image,
      this.description,
      this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Detail'),
          backgroundColor: Colors.purple,
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              Text(name??"",
                style:
                TextStyle(fontFamily: 'avenir', fontWeight: FontWeight.w800, fontSize: 18),),
              SizedBox(height: 10,),

              Center(
                child: SizedBox(
                  height: 250,
                  child: Image.network(
                    image??"",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Text(price??"",
                style:
                TextStyle(fontFamily: 'avenir', fontWeight: FontWeight.w700, fontSize: 38),),
              SizedBox(height: 10,),
              // Row(
              //   children: [
              //     Text('Rating : ',
              //       style:
              //       TextStyle(fontFamily: 'avenir', fontWeight: FontWeight.w800, fontSize: 18),),
              //     SizedBox(width: 10,),
              //     Text(rating.to,
              //       style:
              //       TextStyle(fontFamily: 'avenir', fontWeight: FontWeight.w800, fontSize: 18),),
              //   ],
              // ),
              //SizedBox(height: 10,),
              //SizedBox(height: 10,),
              Text('Description',
                style:
                TextStyle(fontFamily: 'avenir', fontWeight: FontWeight.w800, fontSize: 18),),
              SizedBox(height: 7,),
              Text(description??"",
                style:
                TextStyle(fontFamily: 'avenir', fontWeight: FontWeight.w400, fontSize: 16),)
            ],
          ),
        )
      ),
    );
  }
}
