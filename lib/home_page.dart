import 'package:flutter/material.dart';
import 'package:gif_view/gif_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final ScrollController _scrollController = ScrollController();
  final GifController _gifController = GifController(loop: false);
  List<String> listRecents = [
    'Atassi', 'Igname pilé', 'Wassa Wassa', 'Pate rouge', 'Pate noir',
    'Riz', 'Agbéli', 'Cassoulet', 'Voandzou', 'Haricot'
  ];
  List<Map<String, dynamic>> listFoods = [
    {'name': 'Food1','price': '1000F', 'imagePath': 'assets/images/img1.png'},
    {'name': 'Food2','price': '500F', 'imagePath': 'assets/images/img2.png'},
    {'name': 'Food3','price': '3500F', 'imagePath': 'assets/images/img3.png'},
    {'name': 'Food4','price': '4500F', 'imagePath': 'assets/images/img4.png'},
    {'name': 'Food5','price': '4000F', 'imagePath': 'assets/images/img5.png'},
    {'name': 'Food6','price': '300F', 'imagePath': 'assets/images/img6.png'},
    {'name': 'Food7','price': '1500F', 'imagePath': 'assets/images/img7.png'},
    {'name': 'Food8','price': '2000F', 'imagePath': 'assets/images/img8.png'},
  ];
  final bool _imageVisibilty = true;

  void animate(){
    _scrollController.animateTo(
      200.0,
      duration: const Duration(milliseconds: 2000),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    
    Future.delayed(const Duration(milliseconds: 4500), () {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        animate();
        Future.delayed(const Duration(milliseconds: 2000), () {
        _gifController.stop();
        });
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset == 200.0) {
      _gifController.stop();
    }
    if (_scrollController.offset == 0.0) {
      // If the SliverAppBar reaches size 0.0,
      // we wait 2 seconds to scroll it up
      _gifController.play();
      Future.delayed(const Duration(milliseconds: 2000), () {
        animate();
      });
    } 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD8D8D8),
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                pinned: true,
                floating: true,
                snap: true,
                backgroundColor: Colors.transparent,
                expandedHeight: 240,
                flexibleSpace: FlexibleSpaceBar(
                  background: Visibility(
                    visible: _imageVisibilty,
                    child: GifView.asset(
                      'assets/images/hand.gif',
                      controller: _gifController,
                      frameRate: 10, // default is 15 FPS
                    )
                  ),
                  title: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 2),
                        child: Icon(Icons.location_on),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Cotonou", style: TextStyle(color: Colors.black),),
                          Text("Bénin", style: TextStyle(color: Colors.black, fontSize: 10),),
                        ],
                      ),
                    ],
                  ),
                
                ),
                leading: IconButton(
                  icon: const Icon(
                    Icons.search,
                    size: 20,
                  ), onPressed: () {  },
                ),
                centerTitle: true,
                actions: [
                  IconButton(
                  icon: const Icon(
                    Icons.account_circle,
                    size: 30,
                    color: Color.fromARGB(255, 114, 123, 159),
                  ), onPressed: () {  },
                )
                ],
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("Récents", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                )
              ),
              
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 40.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: listRecents.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(listRecents[index]),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    height: 130.0,
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                          child: Stack(
                            children: [
                              Image.asset(
                                  'assets/images/paysage.jpg',
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("Mi Kwabô", style: TextStyle(
                                          fontSize: 30, 
                                          color: Colors.grey[300],
                                        ),),
                                        Text("Bienvenue", style: TextStyle(
                                          fontWeight: FontWeight.w100,
                                          fontSize: 18, color: Colors.grey[400]),),
                                      ],
                                    ),
                                  )
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 20, bottom: 5),
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text("Aurlic :)", style: TextStyle(
                                      fontSize: 10, color: Colors.grey),),
                                  ),
                                ),
                            ],
                          ),
                      ),
                    ),
          
                ),
              ),
              SliverToBoxAdapter(
                child: OrientationBuilder(
                builder: (context, orientation) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                    child: GridView.count(
                      primary: false,
                      crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
                      childAspectRatio: 1,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: listFoods.map((food) {
                        String name = food['name'];
                        String imagePath = food['imagePath'];
                        String price = food['price'];
                        return GridTile(
                          child: Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          color: Colors.white,
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(imagePath, height: 120, width: 120,),
                                  ),
                                Text(name, style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),
                                Text(price, style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                              ],
                            ),
                          )
                        );
                      }).toList(),
                    )
                  );
                }
              )
              )
            ],
          )
        ],
      )
    );
  }
}