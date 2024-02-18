import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../service/services_service.dart';
import '../theme.dart';
import '../widgets/scaffold/appbar.dart';
import '../widgets/scaffold/drawer.dart';
import '../widgets/service_card.dart';
import '../widgets/title.dart';

class Services extends StatefulWidget {
  const Services({super.key});

  @override
  State<Services> createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  Map<String, List<dynamic>> services = {};

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      services = await context.read<ServicesService>().getServices();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: context.read<ServicesService>().snackbarStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(snapshot.data!), backgroundColor: AppColors.primaryText));
          });
        }
        return Scaffold(
          key: scaffoldKey,
          appBar: MyAppBar(scaffoldKey: scaffoldKey),
          drawer: const MyDrawer(),
          body: Container(
            width: double.infinity,
            decoration: BoxDecoration(gradient: AppColors.gradient),
            child: SafeArea(
              child: SingleChildScrollView(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth > 1200) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 350.0, vertical: 8.0),
                        child: Column(
                          children: [
                            const BigTitle(title: 'Services'),
                            Column(
                              children: [
                                const ServiceCard(
                                  title: "Carrosserie",
                                  description:
                                      "Redonnez à votre véhicule son éclat d'origine avec nos services de réparation de carrosserie. Que ce soit pour des réparations mineures comme le débosselage sans peinture ou pour des interventions plus importantes telles que le remplacement de pièces endommagées, notre équipe utilise les dernières technologies pour assurer un résultat impeccable. Nous nous engageons également à fournir des finitions de peinture de qualité supérieure, adaptées à la couleur et au style de votre voiture.",
                                  category: "carrosserie",
                                ),
                                height16,
                                const ServiceCard(
                                  title: "Réparation",
                                  description:
                                      "La performance de votre véhicule est notre priorité. Nos experts en mécanique sont équipés pour diagnostiquer et réparer tout problème de moteur, de transmission ou de système de freinage. Nous nous occupons également de l'entretien et des réparations des systèmes de suspension et de direction, garantissant ainsi la sécurité et le confort de votre conduite.",
                                  category: "reparation",
                                ),
                                height16,
                                const ServiceCard(
                                  title: "Entretien",
                                  description:
                                      "Maintenez votre véhicule en excellent état avec notre gamme complète de services d'entretien régulier. De la vidange d'huile au remplacement des filtres, en passant par le contrôle des liquides et le remplacement des bougies d'allumage, nous nous assurons que chaque aspect de votre voiture fonctionne de manière optimale. Nous offrons également des services de contrôle et d'équilibrage des pneus pour une performance et une sécurité accrues.",
                                  category: "entretien",
                                ),
                                height16,
                                const ServiceCard(
                                  title: "Contrôle technique",
                                  description:
                                      "Sécurité et fiabilité sont au cœur de nos préoccupations. Nos contrôles de performance et de sécurité comprennent une vérification approfondie des systèmes d'éclairage, des indicateurs, de la batterie, ainsi que d'autres éléments essentiels tels que les ceintures de sécurité et les essuie-glaces. Ces inspections régulières sont essentielles pour garantir une conduite sûre et sereine.",
                                  category: "controle",
                                ),
                                height16,
                              ],
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        child: Column(
                          children: [
                            const BigTitle(title: 'Services'),
                            Column(
                              children: [
                                const ServiceCard(
                                  title: "Carrosserie",
                                  description:
                                      "Redonnez à votre véhicule son éclat d'origine avec nos services de réparation de carrosserie. Que ce soit pour des réparations mineures comme le débosselage sans peinture ou pour des interventions plus importantes telles que le remplacement de pièces endommagées, notre équipe utilise les dernières technologies pour assurer un résultat impeccable. Nous nous engageons également à fournir des finitions de peinture de qualité supérieure, adaptées à la couleur et au style de votre voiture.",
                                  category: "carrosserie",
                                ),
                                height16,
                                const ServiceCard(
                                  title: "Réparation",
                                  description:
                                      "La performance de votre véhicule est notre priorité. Nos experts en mécanique sont équipés pour diagnostiquer et réparer tout problème de moteur, de transmission ou de système de freinage. Nous nous occupons également de l'entretien et des réparations des systèmes de suspension et de direction, garantissant ainsi la sécurité et le confort de votre conduite.",
                                  category: "reparation",
                                ),
                                height16,
                                const ServiceCard(
                                  title: "Entretien",
                                  description:
                                      "Maintenez votre véhicule en excellent état avec notre gamme complète de services d'entretien régulier. De la vidange d'huile au remplacement des filtres, en passant par le contrôle des liquides et le remplacement des bougies d'allumage, nous nous assurons que chaque aspect de votre voiture fonctionne de manière optimale. Nous offrons également des services de contrôle et d'équilibrage des pneus pour une performance et une sécurité accrues.",
                                  category: "entretien",
                                ),
                                height16,
                                const ServiceCard(
                                  title: "Contrôle technique",
                                  description:
                                      "Sécurité et fiabilité sont au cœur de nos préoccupations. Nos contrôles de performance et de sécurité comprennent une vérification approfondie des systèmes d'éclairage, des indicateurs, de la batterie, ainsi que d'autres éléments essentiels tels que les ceintures de sécurité et les essuie-glaces. Ces inspections régulières sont essentielles pour garantir une conduite sûre et sereine.",
                                  category: "controle",
                                ),
                                height16,
                              ],
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
