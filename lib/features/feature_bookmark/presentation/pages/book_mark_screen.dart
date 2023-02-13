import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/features/feature_bookmark/domain/entities/city_entity.dart';
import 'package:weather/features/feature_bookmark/presentation/bloc/bookmark_bloc.dart';
import 'package:weather/features/feature_bookmark/presentation/bloc/get_all_city_status.dart';
import 'package:weather/features/feature_weather/presentation/bloc/home_bloc.dart';

class BookMarkScreen extends StatefulWidget {
  final PageController pageController;
  const BookMarkScreen({super.key, required this.pageController});

  @override
  State<BookMarkScreen> createState() => _BookMarkScreenState();
}

class _BookMarkScreenState extends State<BookMarkScreen> {
  @override
  void initState() {
    BlocProvider.of<BookmarkBloc>(context).add(GetAllCityEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return BlocBuilder<BookmarkBloc, BookmarkState>(
      buildWhen: (previous, current) {
        // if allCityStatus changed --> rebuild UI
        if (current.getAllCityStatus == previous.getAllCityStatus) {
          return false;
        } else {
          return true;
        }
      },
      builder: (context, state) {
        if (state.getAllCityStatus is GetAllCityLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        }
        if (state.getAllCityStatus is GetAllCityCompleted) {
          final GetAllCityCompleted getAllCityCompleted =
              state.getAllCityStatus as GetAllCityCompleted;
          final List<City> cities = getAllCityCompleted.cities;

          return SafeArea(
            child: Column(
              children: [
                SizedBox(height: height / 50),
                const Text(
                  'WatchList',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: height / 40,
                ),
                Expanded(
                  child: (cities.isEmpty)
                      ? const Center(
                          child: Text(
                            'there is no bookMark city',
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                        )
                      : ListView.builder(
                          itemCount: cities.length,
                          itemBuilder: (context, index) {
                            final City city = cities[index];
                            return GestureDetector(
                              onTap: () {
                                /// call for getting bookmarked city Data
                                BlocProvider.of<HomeBloc>(context)
                                    .add(LoadCwEvent(city.name));

                                /// animate to HomeScreen for showing Data
                                widget.pageController.animateToPage(
                                  0,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRect(
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 5.0,
                                      sigmaY: 5.0,
                                    ),
                                    child: Container(
                                      width: width,
                                      height: 60.0,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                        color: Colors.black.withOpacity(0.2),
                                      ),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              city.name,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                BlocProvider.of<BookmarkBloc>(
                                                  context,
                                                ).add(
                                                  DeleteCityEvent(
                                                    city.name,
                                                  ),
                                                );
                                                BlocProvider.of<BookmarkBloc>(
                                                  context,
                                                ).add(GetAllCityEvent());
                                              },
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Color.fromARGB(
                                                  255,
                                                  251,
                                                  11,
                                                  11,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        }
        if (state.getAllCityStatus is GetAllCityError) {
          final GetAllCityError getAllCityError =
              state.getAllCityStatus as GetAllCityError;
          return Text(
            getAllCityError.message,
            style: const TextStyle(color: Colors.white),
          );
        }
        return Container();
      },
    );
  }
}
