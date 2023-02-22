import 'package:amazon_clone/constants/constants.dart';
import 'package:flutter/material.dart';
import '../screens/results_screen.dart';

class CategoriesListView extends StatelessWidget {
  const CategoriesListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kAppBarHeight,
      width: double.infinity,
      color: Colors.white,
      child: ListView.builder(
        itemCount: categoriesList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ResultsScreen(query: categoriesList[index])));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      backgroundImage: NetworkImage(categoryLogos[index]),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(categoriesList[index]),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
