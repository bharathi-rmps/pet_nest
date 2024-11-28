import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_nest/components/cardContent.dart';
import 'package:pet_nest/controllers/petDetailsController.dart';

class petHistoryScreen extends StatelessWidget {
  petHistoryScreen({super.key});

  final petDetailsController _petDetailsController = Get.put(petDetailsController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: Text("Adopt History"),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey[300],
      body: SafeArea(child:
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SafeArea(
            child: Obx(() {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  // history banner pic
                  SizedBox(height: 1,),
                  Container(
                    height: 220,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.indigoAccent,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(1),
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.asset(
                      "lib/assets/pet history banner.png",
                      fit: BoxFit.cover,
                    ),
                  ),

                  if(_petDetailsController.soldPetList.isEmpty) ... [
                    SizedBox(height: 120),
                    Icon(Icons.pets, size: 50, color: Colors.grey),
                    SizedBox(height: 10,),
                    Center(
                      child:
                      Text(
                        "Sorry, No Pets were Adopted",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                        ),
                      ),
                    ),
                    //return Center(child: CircularProgressIndicator(),);
                  ]
                  else ... [
                    //pet details
                    const SizedBox(height: 30,),
                    cardContent(pets: _petDetailsController.soldPetList, showButton: false, height: .85, addOrAdoptUsername: "Adopted By : ",),
                  ]

                ],
              );
            }),

          ),
        ),
      ),
      ),
    );
  }
}
