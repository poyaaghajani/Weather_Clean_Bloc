import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/core/widgets/main_wrapper.dart';
import 'package:weather/di/dependency_injection.dart';
import 'package:weather/features/feature_bookmark/presentation/bloc/bookmark_bloc.dart';
import 'package:weather/features/feature_weather/presentation/bloc/home_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///  init locator
  await setUp();

  runApp(
    MaterialApp(
      theme: ThemeData(textTheme: GoogleFonts.aBeeZeeTextTheme()),
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => locator<HomeBloc>()),
          BlocProvider(create: (_) => locator<BookmarkBloc>()),
        ],
        child: MainWrapper(),
      ),
    ),
  );
}
