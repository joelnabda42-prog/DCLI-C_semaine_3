import 'ui/redacteur_interface.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MonApplication());
}


class MonApplication extends StatelessWidget {
  const MonApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PageAccueil(),
    );
  }
}

class PageAccueil extends StatelessWidget {
  const PageAccueil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Magazine Infos'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Image(
              image: AssetImage('assets/images/magazineInfo.jpg'),
            ),
            const PartieTitre(),
            const PartieTexte(),
            const PartieIcone(),
            const PartieRubrique(),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RedacteurInterface(),
                  ),
                );
              },
              child: const Text('Gestion des rédacteurs'),
            ),
          ],
        ),
      ),
    );
  }
}

//Classe PartieTitre
class PartieTitre extends StatelessWidget {
  const PartieTitre({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Magazine Infos',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Toute l’actualité en un clic',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

//Classe PartieTexte
class PartieTexte extends StatelessWidget {
  const PartieTexte({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: const Text(
        'Magazine Infos est un magazine numérique moderne qui '
        'propose des articles variés sur l’actualité, la culture, '
        'la mode et les nouvelles tendances. Il offre à ses lecteurs '
        'une information fiable, accessible et mise à jour régulièrement.',
      ),
    );
  }
}

//Classe PartieIcone
class PartieIcone extends StatelessWidget {
  const PartieIcone({super.key});

  Widget _buildAction(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.pink),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(color: Colors.pink),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildAction(Icons.phone, 'TEL'),
          _buildAction(Icons.email, 'MAIL'),
          _buildAction(Icons.share, 'PARTAGE'),
        ],
      ),
    );
  }
}

//Classe PartieRubrique
class PartieRubrique extends StatelessWidget {
  const PartieRubrique({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/images/rubriq2.jpg',
              width: 150,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/images/rubriq1.jpg',
              width: 150,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
