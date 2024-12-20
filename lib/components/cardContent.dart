import 'package:flutter/material.dart';
import 'package:pet_nest/components/promptBox.dart';
import 'package:pet_nest/controllers/sessionController.dart';
import '../controllers/petDetailsController.dart';
import 'package:get/get.dart';

class cardContent extends StatelessWidget {
  final List<Pet> pets;
  final bool showButton;
  final height;
  final String addOrAdoptUsername;

  cardContent({
    super.key,
    required this.pets,
    required this.showButton,
    required this.height,
    required this.addOrAdoptUsername
  });

  final petDetailsController _petDetailsController = Get.put(petDetailsController());
  final sessionController _sessionController = Get.find<sessionController>();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: height,
      ),
      itemCount: pets.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final pet = pets[index];
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Section
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(15),
                ),

                // card image
                child: Image.network(
                  pet.imageUrl,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
                    );
                  },
                ),
              ),

              // card text and button section
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    //card text (pet name)
                    Text(
                      pet.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),

                    const SizedBox(height: 5),
                    //card text (pet category)
                    Text(
                      pet.category,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),

                    //add or adopt text
                    Text(
                      addOrAdoptUsername + pet.addedBy,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),

                    //adopt button
                    if(showButton)
                      Align(
                        alignment: Alignment.center,
                        child:
                        ElevatedButton(
                          onPressed: () {
                            promptBox.show(
                              context: context,
                              title: "Adopt Pet Confirmation",
                              content: "Are you sure you want to adopt this pet?",
                              onConfirm: () async {
                                await _petDetailsController.adoptPet(pet.id, pet.category, pet.name, pet.imageUrl, _sessionController.username.value);
                                //Get.off(() => landingScreen(selectedIndex: 1));
                                //print("pressed: " + pet.id.toString());
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepOrangeAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5
                            ),
                          ),
                          child: const Text(
                            "Adopt",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),

                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
