import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'country_detail_page.dart';
import 'welcome_page.dart';
import 'models/country.dart';

class CountriesPage extends StatefulWidget {
  const CountriesPage({super.key});

  @override
  State<CountriesPage> createState() => _CountriesPageState();
}

class _CountriesPageState extends State<CountriesPage> {
  List<Country> countries = [];
  bool isLoading = true;

  final Map<String, String> countryFlags = {
    "France": "assets/images/france.png",
    "Tunisie": "assets/images/tunisia.png",
    "Brésil": "assets/images/brazil.png",
    "Italie": "assets/images/italy.png",
    "Canada": "assets/images/canada.png",
    "Australie": "assets/images/australia.jpg",
    "Allemagne": "assets/images/germany.png",
    "Espagne": "assets/images/spain.png",
    "Afrique du Sud": "assets/images/afrique.png",
  };

  @override
  void initState() {
    super.initState();
    loadCountriesFromJson();
  }

  Future<void> loadCountriesFromJson() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/data/pays_info.json');
      final List<dynamic> jsonData = json.decode(jsonString);
      
      setState(() {
        countries = jsonData.map((json) => Country.fromJson(json)).toList();
        isLoading = false;
      });
    } catch (e) {
      print("Erreur lors du chargement du JSON: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),

      appBar: AppBar(
        title: const Text(
          "Liste des Pays",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 2,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF3B82F6),
              ),
              child: Center(
                child: Icon(Icons.public, size: 80, color: Colors.white),
              ),
            ),

            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Accueil"),
              onTap: () {
                Navigator.pop(context); 
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const WelcomePage()),
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.info),
              title: const Text("À propos"),
              onTap: () {
                Navigator.pop(context);
                
              },
            ),

            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Quitter"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF3B82F6),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView.builder(
                itemCount: countries.length,
                itemBuilder: (context, index) {
                  final country = countries[index];
                  final flagPath = countryFlags[country.nom] ?? "assets/images/globe.png";

                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(flagPath),
                        radius: 22,
                      ),
                      title: Text(
                        country.nom,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CountryDetailPage(
                              country: country,
                              flagPath: flagPath,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
    );
  }
}