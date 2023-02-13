import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:weather/core/params/forecast_params.dart';
import 'package:weather/core/utils/date_converter.dart';
import 'package:weather/core/widgets/dot_loading.dart';
import 'package:weather/core/widgets/part_of_day.dart';
import 'package:weather/core/widgets/sett_icon.dart';
import 'package:weather/di/dependency_injection.dart';
import 'package:weather/features/feature_bookmark/presentation/bloc/bookmark_bloc.dart';
import 'package:weather/features/feature_weather/data/models/suggest_city_model.dart';
import 'package:weather/features/feature_weather/domain/entities/current_city_entity.dart';
import 'package:weather/features/feature_weather/domain/entities/forecast_days_entity.dart';
import 'package:weather/features/feature_weather/domain/usecases/get_suggestion_city.dart';
import 'package:weather/features/feature_weather/presentation/bloc/cw_status.dart';
import 'package:weather/features/feature_weather/presentation/bloc/fw_status.dart';
import 'package:weather/features/feature_weather/presentation/bloc/home_bloc.dart';
import 'package:weather/features/feature_weather/presentation/widgets/bookmark_icon.dart';
import 'package:weather/features/feature_weather/presentation/widgets/forecast_days_weather.dart';
import 'package:weather/features/feature_weather/presentation/widgets/line.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(LoadCwEvent('Tehran'));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final PageController pageController = PageController(initialPage: 0);

    final TextEditingController textEditingController = TextEditingController();

    final GetSuggestionCityUsecase getSuggestionCityUsecase =
        GetSuggestionCityUsecase(locator());

    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: height / 38),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width / 50),
            child: Row(
              children: [
                Expanded(
                  child: TypeAheadField(
                    textFieldConfiguration: TextFieldConfiguration(
                      onSubmitted: (String prefix) {
                        textEditingController.text = prefix;
                        BlocProvider.of<HomeBloc>(context)
                            .add(LoadCwEvent(prefix));
                      },
                      controller: textEditingController,
                      style: DefaultTextStyle.of(context).style.copyWith(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 10,
                        ),
                        hintText: "Enter a City...",
                        hintStyle: TextStyle(color: Colors.grey.shade400),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                    suggestionsCallback: (prefix) {
                      return getSuggestionCityUsecase(prefix);
                    },
                    itemBuilder: (context, Data model) {
                      return ListTile(
                        leading: const Icon(Icons.location_on),
                        title: Text(model.name!),
                        subtitle: Text('${model.region}, ${model.country}'),
                      );
                    },
                    onSuggestionSelected: (Data model) {
                      textEditingController.text = model.name!;
                      BlocProvider.of<HomeBloc>(context)
                          .add(LoadCwEvent(model.name!));
                    },
                  ),
                ),
                const SizedBox(width: 5),
                BlocBuilder<HomeBloc, HomeState>(
                  buildWhen: (previous, current) {
                    if (previous.cwStatus == current.cwStatus) {
                      return false;
                    } else {
                      return true;
                    }
                  },
                  builder: (context, state) {
                    if (state.cwStatus is CwLoading) {
                      return const CircularProgressIndicator(
                        color: Colors.white,
                      );
                    }
                    if (state.cwStatus is CwError) {
                      return IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.error,
                          color: Colors.white,
                          size: 35,
                        ),
                      );
                    }
                    if (state.cwStatus is CwCompleted) {
                      final CwCompleted cwCompleted =
                          state.cwStatus as CwCompleted;

                      BlocProvider.of<BookmarkBloc>(context).add(
                        GetCityByNameEvent(
                          cwCompleted.currentCityEntity.name!,
                        ),
                      );
                      return BookmarkIcon(
                        name: cwCompleted.currentCityEntity.name!,
                      );
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ),
          BlocBuilder<HomeBloc, HomeState>(
            // rebuild just when CwStatus chenged
            buildWhen: (previous, current) {
              if (previous.cwStatus == current.cwStatus) {
                return false;
              } else {
                return true;
              }
            },
            builder: (context, state) {
              if (state.cwStatus is CwLoading) {
                return const Expanded(
                  child: DotLoading(),
                );
              }
              if (state.cwStatus is CwCompleted) {
                // cast
                final CwCompleted cwCompleted = state.cwStatus as CwCompleted;
                final CurrentCityEntity currentCityEntity =
                    cwCompleted.currentCityEntity;

                // get lat and lon fore 7 forecastDays request
                final ForeCastParams forecastParams = ForeCastParams(
                  currentCityEntity.coord!.lat!,
                  currentCityEntity.coord!.lon!,
                );

                BlocProvider.of<HomeBloc>(context)
                    .add(LoadFwEvent(forecastParams));

                // change times to hour --5:50 AM/PM--
                final sunrise = DateConverter.changeDtToDateTimeHour(
                  currentCityEntity.sys!.sunrise,
                  currentCityEntity.timezone,
                );

                final sunset = DateConverter.changeDtToDateTimeHour(
                  currentCityEntity.sys!.sunrise,
                  currentCityEntity.timezone,
                );

                return Expanded(
                  child: ListView(
                    children: [
                      SizedBox(height: height / 20),
                      SizedBox(
                        width: width,
                        height: height / 2,
                        child: PageView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: 2,
                          controller: pageController,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return Column(
                                children: [
                                  Text(
                                    currentCityEntity.name!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: width / 11,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(height: height / 40),
                                  Text(
                                    currentCityEntity.weather![0].description!,
                                    style: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontSize: width / 22,
                                    ),
                                  ),
                                  SizedBox(height: height / 18),
                                  Transform.scale(
                                    scale: 1.4,
                                    child: SetIcon.setIconForMain(
                                      currentCityEntity.weather![0].description,
                                    ),
                                  ),
                                  SizedBox(height: height / 35),
                                  Text(
                                    '${currentCityEntity.main!.temp.toString()}\u00B0',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: width / 8,
                                    ),
                                  ),
                                  SizedBox(height: height / 35),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            'max',
                                            style: TextStyle(
                                              color: Colors.grey.shade500,
                                              fontSize: width / 24,
                                            ),
                                          ),
                                          SizedBox(height: height / 200),
                                          Text(
                                            '${currentCityEntity.main!.tempMax!.toString()}\u00B0',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: width / 25,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: width / 40),
                                      Container(
                                        width: 2,
                                        height: height / 15,
                                        color: Colors.grey.shade500,
                                      ),
                                      SizedBox(width: width / 40),
                                      Column(
                                        children: [
                                          Text(
                                            'min',
                                            style: TextStyle(
                                              color: Colors.grey.shade500,
                                              fontSize: width / 24,
                                            ),
                                          ),
                                          SizedBox(height: height / 200),
                                          Text(
                                            '${currentCityEntity.main!.tempMin!.toString()}\u00B0',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: width / 25,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            } else {
                              return SizedBox(
                                child: Column(
                                  children: [
                                    Text(
                                      PartOfDay.getPart(),
                                      style: TextStyle(
                                        fontSize: width / 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: height / 15),
                                    Column(
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              "wind speed",
                                              style: TextStyle(
                                                fontSize: width / 24,
                                                color: Colors.amber.shade300,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 10.0,
                                              ),
                                              child: Text(
                                                "${currentCityEntity.wind!.speed!} m/s",
                                                style: TextStyle(
                                                  fontSize: width / 30,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: height / 40),
                                    const Line(),
                                    SizedBox(height: height / 100),
                                    Column(
                                      children: [
                                        Text(
                                          "sunrise",
                                          style: TextStyle(
                                            fontSize: width / 24,
                                            color: Colors.amber.shade300,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
                                          child: Text(
                                            sunrise,
                                            style: TextStyle(
                                              fontSize: width / 30,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: height / 40),
                                    const Line(),
                                    SizedBox(height: height / 100),
                                    Column(
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              "sunset",
                                              style: TextStyle(
                                                fontSize: width / 24,
                                                color: Colors.amber.shade300,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 10.0,
                                              ),
                                              child: Text(
                                                sunset,
                                                style: TextStyle(
                                                  fontSize: width / 30,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: height / 40),
                                    const Line(),
                                    SizedBox(height: height / 100),
                                    Column(
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              "hiumadity",
                                              style: TextStyle(
                                                fontSize: width / 24,
                                                color: Colors.amber.shade300,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 10.0,
                                              ),
                                              child: Text(
                                                "${currentCityEntity.main!.humidity} %",
                                                style: TextStyle(
                                                  fontSize: width / 30,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      Center(
                        child: SmoothPageIndicator(
                          controller: pageController,
                          count: 2,
                          effect: ExpandingDotsEffect(
                            dotColor: Colors.grey.shade400,
                            activeDotColor: Colors.white,
                            dotHeight: 10,
                            dotWidth: 10,
                          ),
                          onDotClicked: (index) {
                            pageController.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          },
                        ),
                      ),
                      SizedBox(height: height / 18),
                      Container(
                        width: width,
                        height: 1.5,
                        color: Colors.grey.shade500,
                      ),
                      SizedBox(height: height / 50),
                      SizedBox(
                        width: double.infinity,
                        height: height / 5,
                        child: Padding(
                          padding: EdgeInsets.only(left: width / 50),
                          child: Center(
                            child: BlocBuilder<HomeBloc, HomeState>(
                              builder: (BuildContext context, state) {
                                /// show Loading State for Fw
                                if (state.fwStatus is FwLoading) {
                                  return const DotLoading();
                                }

                                /// show Completed State for Fw
                                if (state.fwStatus is FwCompleted) {
                                  /// casting
                                  final FwCompleted fwCompleted =
                                      state.fwStatus as FwCompleted;
                                  final ForecastDaysEntity forecastDaysEntity =
                                      fwCompleted.forecastDaysEntity;

                                  return ListView.builder(
                                    itemCount: 8,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return DaysWeatherView(
                                        daily: forecastDaysEntity.daily![index],
                                      );
                                    },
                                  );
                                }

                                /// show Error State for Fw
                                if (state.fwStatus is FwError) {
                                  final FwError fwError =
                                      state.fwStatus as FwError;
                                  return Center(
                                    child: Text(fwError.message!.toString()),
                                  );
                                }

                                /// show Default State for Fw
                                return Container();
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              if (state.cwStatus is CwError) {
                return const Expanded(
                  child: SizedBox(
                    child: Center(
                      child: Text(
                        'some networks problems, please try again...',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }

  // when return to home screen it dosn't rebuild
  @override
  bool get wantKeepAlive => true;
}
