import 'package:flutter/material.dart';

void main() {
  runApp(const MonAppli());
}

class MonAppli extends StatelessWidget {
  const MonAppli({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Magazine',
      debugShowCheckedModeBanner: false,
      home: pageAccueil(),
    );
  }
}

class pageAccueil extends StatelessWidget {
  const pageAccueil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Magazine Infos'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      // Modification : Utilisation de SingleChildScrollView pour rendre la page scrollable
      body: SingleChildScrollView(
        child: Column(
          children: const [
            // Image du magazine avec BoxFit pour l'adapter à l'écran
            Image(
              image: AssetImage('assets/images/magazineInfo.jpg'),
              fit: BoxFit.cover,  // Ajuste l'image pour qu'elle ne déborde pas
            ),
            PartieTitre(),
            PartieTexte(),
            PartieIcone(),
            PartieRubrique(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Tu as cliqué dessus'),
            ),
          );
        },
        child: const Text('Click'),
      ),
    );
  }
}

// PartieTitre : Classe pour afficher les titres
class PartieTitre extends StatelessWidget {
  const PartieTitre({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: const [
          Text(
            "Titre du premier niveau",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            "Titre du second niveau",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }
}

// PartieTexte : Classe pour afficher une brève description du magazine
class PartieTexte extends StatelessWidget {
  const PartieTexte({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text(
        "Ceci est une brève description du magazine.",
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}

// PartieIcone : Classe pour afficher les icônes (téléphone, e-mail, partage)
class PartieIcone extends StatelessWidget {
  const PartieIcone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          Column(
            children: [
              Icon(Icons.phone),
              SizedBox(height: 5),
              Text("TEL"),
            ],
          ),
          Column(
            children: [
              Icon(Icons.email),
              SizedBox(height: 5),
              Text("MAIL"),
            ],
          ),
          Column(
            children: [
              Icon(Icons.share),
              SizedBox(height: 5),
              Text("PARTAGE"),
            ],
          ),
        ],
      ),
    );
  }
}

// PartieRubrique : Classe pour afficher les images côte à côte avec des bords arrondis
class PartieRubrique extends StatelessWidget {
  const PartieRubrique({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: Image(
              image: AssetImage('assets/images/rubriq1.jpg'),
              width: 150,   // Augmenter la taille pour tester
              height: 150,  // Augmenter la taille pour tester
              fit: BoxFit.cover,  // Cela ajuste l'image pour remplir l'espace sans la déformer
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: Image(
              image: AssetImage('assets/images/rubriq2.jpg'),
              width: 150,   // Augmenter la taille pour tester
              height: 150,  // Augmenter la taille pour tester
              fit: BoxFit.cover,  // Cela ajuste l'image pour remplir l'espace sans la déformer
            ),
          ),
        ],
      ),
    );
  }
}
