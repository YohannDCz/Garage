import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../service/services_service.dart';
import '../theme.dart';
import 'service_container.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard({
    super.key,
    required this.title,
    required this.description,
    required this.category,
  });

  final String title;
  final String description;
  final String category;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500.0,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(title, style: Theme.of(context).textTheme.titleLarge!.copyWith(decoration: TextDecoration.underline)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(description, style: Theme.of(context).textTheme.bodyMedium),
          ),
          const Spacer(),
          FutureBuilder(
            future: context.read<ServicesService>().getServices(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                final services = snapshot.data as Map<String, List<dynamic>>;
                return SizedBox(
                  height: 230.0,
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: services[category]!.length,
                    itemBuilder: (context, index) {
                      final service = services[category]![index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: ServiceContainer(service: service),
                      );
                    },
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
