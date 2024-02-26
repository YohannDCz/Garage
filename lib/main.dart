import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'bloc/authentication_bloc.dart';
import 'bloc/cars_bloc.dart';
import 'bloc/email_bloc.dart';
import 'bloc/ratings_bloc.dart';
import 'bloc/schedule_bloc.dart';
import 'screens/about.dart';
import 'screens/admin.dart';
import 'screens/cars.dart';
import 'screens/employee.dart';
import 'screens/home.dart';
import 'screens/services.dart';
import 'screens/signin.dart';
import 'screens/signup.dart';
import 'service/auth_service.dart';
import 'service/cars_service.dart';
import 'service/email_service.dart';
import 'service/ratings_service.dart';
import 'service/schedules_service.dart';
import 'service/services_service.dart';
import 'service/validator_service.dart';
import 'theme.dart';

void main() async {
  try {
    await dotenv.load();
  } catch (e) {
    debugPrint('$e');
  }
  Supabase.initialize(
    url: "https://pmuxdgydlrpgzmndnfon.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBtdXhkZ3lkbHJwZ3ptbmRuZm9uIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDQwMDU3OTYsImV4cCI6MjAxOTU4MTc5Nn0.5o8UCpvMstwPWz7VgSONFFxzW13Yqs2Yr5m6oT9TDYc",
  );
  runApp(const GarageApp());
}

class GarageApp extends StatelessWidget {
  const GarageApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => AuthenticationService()),
        RepositoryProvider(create: (context) => CarsService()),
        RepositoryProvider(create: (context) => ServicesService()),
        RepositoryProvider(create: (context) => ValidatorService()),
        RepositoryProvider(create: (context) => EmailService()),
        RepositoryProvider(create: (context) => RatingsService()),
        RepositoryProvider(create: (context) => SchedulesService()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => AuthenticationBloc(authenticationService: context.read<AuthenticationService>())),
          BlocProvider(create: (context) => CarsBloc(carService: context.read<CarsService>())),
          BlocProvider(create: (context) => RatingsBloc(ratingsService: context.read<RatingsService>())),
          BlocProvider(create: (context) => EmailBloc(emailService: context.read<EmailService>())),
          BlocProvider(create: (context) => SchedulesBloc(schedulesService: context.read<SchedulesService>())),
        ],
        child: MaterialApp(
          title: 'Garage V. Parrot',
          theme: appTheme,
          // initialRoute: '/signin',
          home: const About(),
          routes: {
            '/signin': (context) => const SignIn(),
            '/signup': (context) => const SignUp(),
            '/home': (context) => const Home(),
            '/services': (context) => const Services(),
            '/cars': (context) => const Cars(),
            '/about': (context) => const About(),
            '/employee': (context) => const Employee(),
            '/admin': (context) => const Admin(),
          },
        ),
      ),
    );
  }
}
