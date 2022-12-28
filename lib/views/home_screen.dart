import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../controller/home_conroller.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _textEditingController = TextEditingController();

  List<TextSpan> highlightOccurrences(String source, String query) {
    if (query == null || query.isEmpty || !source.toLowerCase().contains(query.toLowerCase())) {
      return [ TextSpan(text: source) ];
    }
    final matches = query.toLowerCase().allMatches(source.toLowerCase());

    int lastMatchEnd = 0;

    final List<TextSpan> children = [];
    for (var i = 0; i < matches.length; i++) {
      final match = matches.elementAt(i);

      if (match.start != lastMatchEnd) {
        children.add(TextSpan(
          text: source.substring(lastMatchEnd, match.start),
        ));
      }

      children.add(TextSpan(
          text: source.substring(match.start, match.end),
          style:  TextStyle(
              fontWeight: FontWeight.w900,
              color: Colors.purple
          )
      ));

      if (i == matches.length - 1 && match.end != source.length) {
        children.add(TextSpan(
          text: source.substring(match.end, source.length),
        ));
      }

      lastMatchEnd = match.end;
    }
    return children;
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: Text('Products'),
            backgroundColor: Colors.purple,
          ),
          body: GetX<HomeController>(
              init: Get.put(HomeController()),
              builder: (homeCon) {
                return homeCon.productData.value == null
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
                      children: [
                        SizedBox(height: 10,),
                        SizedBox(
                          height: Get.height*0.065,
                          width: Get.width*0.89,
                          child:  TextField(
                              decoration:  InputDecoration(
                                prefixIcon: Icon(Icons.search),
                                // icon:  Icon(Icons.search),
                                hintText: "Search ",
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                              ),
                              controller: _textEditingController,
                              onChanged: (query){
                                final searchResult = homeCon.productsData.value.where((element) {
                                  final title = element.title?.toLowerCase();
                                  final queryLowerCase = query.toLowerCase();
                                  return title!.contains(queryLowerCase);
                                }).toList();
                                homeCon.productData.value = searchResult!;
                                setState(() {});
                              }
                          ),
                        ),
                        Expanded(
                          child: MasonryGridView.builder(
                              //crossAxisCount: 4,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              itemCount: homeCon.productData.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailScreen(
                                      name: homeCon.productData[index].title,
                                      description: homeCon.productData[index].description,
                                      image: homeCon.productData[index].image,
                                      price: homeCon.productData[index].price.toString(),
                                      rating: homeCon.productData[index].rating?.rate,
                                      category: homeCon.productData[index].category.toString()
                                    )));
                                  },
                                  child: Card(
                                    elevation: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Stack(
                                            children: [
                                              Container(
                                                height: 240,
                                                width: double.infinity,
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                child: Image.network(
                                                  homeCon.productData[index].image??"",
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Positioned(
                                                right: 0,
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  child: IconButton(
                                                    icon:  Icon(Icons.favorite_rounded,color: Colors.red,),
                                                    onPressed: () {
                                                    },
                                                  ),
                                                )
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 8),
                                          RichText(
                                            maxLines: 1,
                                            text: TextSpan(
                                              children: highlightOccurrences(homeCon.productData[index].title??'', _textEditingController.text),
                                              style: TextStyle(fontWeight:FontWeight.w700, fontFamily: 'avenir', color: Colors.black),
                                            ),
                                          ),
                                          // Text(
                                          //   homeCon.productData[index].title??"",
                                          //   maxLines:1,
                                          //   style:
                                          //   TextStyle(fontFamily: 'avenir', fontWeight: FontWeight.w800),
                                          //   overflow: TextOverflow.ellipsis,
                                          // ),
                                          SizedBox(height: 8),
                                          if (homeCon.productData[index].rating != null)
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    homeCon.productData[index].rating.toString(),
                                                    style: TextStyle(color: Colors.white),
                                                  ),
                                                  Icon(
                                                    Icons.star,
                                                    size: 16,
                                                    color: Colors.white,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          SizedBox(height: 8),
                                          Text('\$${homeCon.productData[index].price}',
                                              style: TextStyle(fontSize: 32, fontFamily: 'avenir')),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              gridDelegate:
                                  SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                            ),
                        ),
                      ],
                    );
              })),
    );
  }
}
