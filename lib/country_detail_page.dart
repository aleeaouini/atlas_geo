import 'package:flutter/material.dart';
import 'models/country.dart';

class CountryDetailPage extends StatelessWidget {
  final Country country;
  final String flagPath;

  const CountryDetailPage({
    super.key,
    required this.country,
    required this.flagPath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        foregroundColor: Colors.black,
        title: Text(
          country.nom,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  flagPath,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 20),

              buildInfoCard(
                icon: Icons.location_city,
                title: country.capitale,
                label: "Capitale",
              ),

              buildInfoCard(
                icon: Icons.groups,
                title: "${country.population} d'habitants",
                label: "Population",
              ),

              buildInfoCard(
                icon: Icons.map,
                title: country.superficie,
                label: "Superficie",
              ),

              buildInfoCard(
                icon: Icons.language,
                title: country.langues,
                label: "Langue(s) officielle(s)",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoCard({
    required IconData icon,
    required String title,
    required String label,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: 28, color: Colors.grey[700]),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}