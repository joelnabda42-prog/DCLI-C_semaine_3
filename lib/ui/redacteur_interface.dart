import 'package:flutter/material.dart';
import '../database/database_manager.dart';
import '../modele/redacteur.dart';

class RedacteurInterface extends StatefulWidget {
  const RedacteurInterface({super.key});

  @override
  State<RedacteurInterface> createState() => _RedacteurInterfaceState();
}

class _RedacteurInterfaceState extends State<RedacteurInterface> {
  final dbManager = DatabaseManager();
  late Future<List<Redacteur>> redacteursFuture;

  final _nomController = TextEditingController();
  final _prenomController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _refreshRedacteurs();
  }

  // 🔹 Libération mémoire
  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _refreshRedacteurs() {
    setState(() {
      redacteursFuture = dbManager.getAllRedacteurs();
    });
  }

  void _clearControllers() {
    _nomController.clear();
    _prenomController.clear();
    _emailController.clear();
  }

  Future<void> _showRedacteurDialog({Redacteur? redacteur}) async {
    // AMÉLIORATION
    if (redacteur == null) {
      // Ajout → champs vides
      _clearControllers();
    } else {
      // Modification → champs préremplis
      _nomController.text = redacteur.nom;
      _prenomController.text = redacteur.prenom;
      _emailController.text = redacteur.email;
    }

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            redacteur == null
                ? 'Ajouter un rédacteur'
                : 'Modifier un rédacteur',
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nomController,
                decoration: const InputDecoration(labelText: 'Nom'),
              ),
              TextField(
                controller: _prenomController,
                decoration: const InputDecoration(labelText: 'Prénom'),
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                // 🔹 Validation simple
                if (_nomController.text.isEmpty ||
                    _prenomController.text.isEmpty ||
                    _emailController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Tous les champs sont obligatoires'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                if (redacteur == null) {
                  await dbManager.insertRedacteur(
                    Redacteur(
                      nom: _nomController.text,
                      prenom: _prenomController.text,
                      email: _emailController.text,
                    ),
                  );
                } else {
                  await dbManager.updateRedacteur(
                     Redacteur.withId(
                      id: redacteur.id,
                      nom: _nomController.text,
                      prenom: _prenomController.text,
                      email: _emailController.text,
                   ),
                 );
                }

                _clearControllers();
                _refreshRedacteurs();
                Navigator.of(context).pop();
              },
              child: Text(redacteur == null ? 'Ajouter' : 'Modifier'),
            ),
          ],
        );
      },
    );
  }

  void _deleteRedacteur(int id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content:
              const Text('Voulez-vous vraiment supprimer ce rédacteur ?'),
          actions: [
            TextButton(
              onPressed: () async {
                await dbManager.deleteRedacteur(id);
                _refreshRedacteurs();
                Navigator.of(context).pop();
              },
              child: const Text('Supprimer'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Annuler'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Magazine Infos'),
        backgroundColor: Colors.pink,
      ),
      body: FutureBuilder<List<Redacteur>>(
        future: redacteursFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final redacteurs = snapshot.data ?? [];

          return ListView.builder(
            itemCount: redacteurs.length,
            itemBuilder: (context, index) {
              final redacteur = redacteurs[index];
              return Card(
                child: ListTile(
                  leading:
                      const Icon(Icons.person, color: Colors.pink),
                  title:
                      Text('${redacteur.prenom} ${redacteur.nom}'),
                  subtitle: Text(redacteur.email),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () =>
                            _showRedacteurDialog(redacteur: redacteur),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () =>
                            _deleteRedacteur(redacteur.id!),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        onPressed: () => _showRedacteurDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
