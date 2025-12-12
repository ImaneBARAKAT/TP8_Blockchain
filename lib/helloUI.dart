import 'package:flutter/material.dart';
import 'contract_linking.dart';
import 'package:provider/provider.dart';

class HelloUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtenir l'objet ContractLinking
    var contractLink = Provider.of<ContractLinking>(context);
    
    TextEditingController yourNameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Hello World DApp"),
        centerTitle: true,
        backgroundColor: Colors.cyan[400],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: contractLink.isLoading
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: Colors.cyan[400],
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Chargement du contrat...",
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 16,
                      ),
                    ),
                  ],
                )
              : SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Hello ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 52,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            contractLink.deployedName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 52,
                              color: Colors.tealAccent[400],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 40),
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.cyan[400]!),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Adresse du contrat:",
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "0x...", // Vous pouvez afficher l'adresse tronquée ici
                              style: TextStyle(
                                color: Colors.cyan[300],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40),
                      TextFormField(
                        controller: yourNameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.cyan[400]!),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.cyan[400]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.deepOrange[200]!),
                          ),
                          labelText: "Your Name",
                          labelStyle: TextStyle(color: Colors.cyan[300]),
                          hintText: "What is your name?",
                          hintStyle: TextStyle(color: Colors.grey[500]),
                          icon: Icon(
                            Icons.drive_file_rename_outline,
                            color: Colors.cyan[400],
                          ),
                          filled: true,
                          fillColor: Colors.grey[900],
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          child: Text(
                            'Set Name',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[700],
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 5,
                          shadowColor: Colors.green[300],
                        ),
                        onPressed: () {
                          if (yourNameController.text.isNotEmpty) {
                            contractLink.setName(yourNameController.text);
                            yourNameController.clear();
                            
                            // Afficher un message de confirmation
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Transaction envoyée..."),
                                backgroundColor: Colors.green[700],
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Veuillez entrer un nom"),
                                backgroundColor: Colors.red[700],
                              ),
                            );
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          child: Text(
                            'Actualiser',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[700],
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          contractLink.getName();
                        },
                      ),
                    ],
                  ),
                ),
        ),
      ),
      backgroundColor: Colors.grey[850],
    );
  }
}