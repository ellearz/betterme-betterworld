import 'package:betterme/goals_page.dart';
import 'package:flutter/material.dart';
//import 'package:betterme/goals_page.dart';
import 'package:betterme/goals_details.dart';


class HomeCards extends StatefulWidget {
  const HomeCards({super.key});

  @override
  State<HomeCards> createState() => _HomeCardsState();
}

class _HomeCardsState extends State<HomeCards> {
final PageController _pageController = PageController(viewportFraction: 0.7);
  @override

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: PageView.builder(
        controller: _pageController,
        itemCount: 3,
        itemBuilder: (contex, index) {
          return _buildCard(index);
        },
      ),
    );
  }



  Widget _buildCard(int index) {
    final List<Widget> cards = [
              GestureDetector(
                onTap: () {},

                // Quote Card
                child: const Card(
                  color: Colors.greenAccent,
                  child: SizedBox(
                    width: 250,
                    height: 400,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "“The only way to do great work is to love what you do.” – Steve Jobs'",
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Goals Card
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const GoalsPage()));
                },
                child: const Card(
                  color: Colors.blueGrey,
                  child: SizedBox(
                    width: 250,
                    height: 400,
                    child: Center(
                      child: Text(
                        "Your List of Goals",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  print("pressed");
                },
                child: const Card(
                  color: Colors.indigo,
                  child: SizedBox(
                    width: 250,
                    height: 400,
                    child: Center(
                      child: Text("Breaking News on Habits"),
                    ),
                  ),
                ),
              ),
            ];

      return AnimatedBuilder(
        animation: _pageController, 
        builder: (context, child) {
          double value = 1.0;
          if (_pageController.position.haveDimensions) {
            value = (_pageController.page ?? 0.0)- index;
            value = (1-(value.abs() * 0.3)).clamp(0.0, 1.0);
          }
          return Center(
            child: Transform.scale(
              scale: Curves.easeOut.transform(value),
              child: cards[index],
            ),
          );
        },
        
        
        );     
  }
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
