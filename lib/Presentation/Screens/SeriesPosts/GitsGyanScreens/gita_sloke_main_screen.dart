 

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; 
import 'package:gita/Presentation/Widgets/drawer.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:logger/logger.dart';
import 'package:overlay_support/overlay_support.dart';

import '../../../../Constants/locations.dart';
import '../../../../Data/model/api/SeriesPostResponse/gita_post_response.dart';
import '../../../../Data/services/secure_storage.dart';
import '../../../../Logic/Cubit/SeriesPostCubit/series_post_cubit.dart';
import '../../../../Logic/Cubit/locale_cubit/locale_cubit.dart';
import '../../../../Utility/next_screen.dart';
import '../../Notification/notification_screen.dart';
import 'gita_sloke_specific_post_screen.dart';

class GitagyanMainScreen extends StatefulWidget {
  const GitagyanMainScreen({super.key});

  @override
  State<GitagyanMainScreen> createState() => _GitagyanMainScreenState();
}

class _GitagyanMainScreenState extends State<GitagyanMainScreen> {
  final List<GitaAdhyay> gitaChapters = const [
    GitaAdhyay(
      chapterNo: 1,
      hindiTitle: "अध्याय 1",
      englishTitle: "Adhyay 1",
      hindiTopic: "अर्जुन विषाद योग",
      englishTopic: "Arjuna Vishada Yoga",
    ),
    GitaAdhyay(
      chapterNo: 2,
      hindiTitle: "अध्याय 2",
      englishTitle: "Adhyay 2",
      hindiTopic: "सांख्य योग",
      englishTopic: "Sankhya Yoga",
    ),
    GitaAdhyay(
      chapterNo: 3,
      hindiTitle: "अध्याय 3",
      englishTitle: "Adhyay 3",
      hindiTopic: "कर्म योग",
      englishTopic: "Karma Yoga",
    ),
    GitaAdhyay(
      chapterNo: 4,
      hindiTitle: "अध्याय 4",
      englishTitle: "Adhyay 4",
      hindiTopic: "ज्ञान कर्म संन्यास योग",
      englishTopic: "Jnana Karma Sanyasa Yoga",
    ),
    GitaAdhyay(
      chapterNo: 5,
      hindiTitle: "अध्याय 5",
      englishTitle: "Adhyay 5",
      hindiTopic: "कर्म संन्यास योग",
      englishTopic: "Karma Sanyasa Yoga",
    ),
    GitaAdhyay(
      chapterNo: 6,
      hindiTitle: "अध्याय 6",
      englishTitle: "Adhyay 6",
      hindiTopic: "आत्म संयम योग",
      englishTopic: "Atma Samyama Yoga",
    ),
    GitaAdhyay(
      chapterNo: 7,
      hindiTitle: "अध्याय 7",
      englishTitle: "Adhyay 7",
      hindiTopic: "ज्ञान विज्ञान योग",
      englishTopic: "Jnana Vijnana Yoga",
    ),
    GitaAdhyay(
      chapterNo: 8,
      hindiTitle: "अध्याय 8",
      englishTitle: "Adhyay 8",
      hindiTopic: "अक्षर परब्रह्म योग",
      englishTopic: "Aksara ParaBrahma Yoga",
    ),
    GitaAdhyay(
      chapterNo: 9,
      hindiTitle: "अध्याय 9",
      englishTitle: "Adhyay 9",
      hindiTopic: "राज विद्या राज गुह्य योग",
      englishTopic: "Raja Vidya Raja Guhya Yoga",
    ),
    GitaAdhyay(
      chapterNo: 10,
      hindiTitle: "अध्याय 10",
      englishTitle: "Adhyay 10",
      hindiTopic: "विभूति योग",
      englishTopic: "Vibhooti Yoga",
    ),
    GitaAdhyay(
      chapterNo: 11,
      hindiTitle: "अध्याय 11",
      englishTitle: "Adhyay 11",
      hindiTopic: "विश्वरूप दर्शन योग",
      englishTopic: "Vishwaroopa Darshana Yoga",
    ),
    GitaAdhyay(
      chapterNo: 12,
      hindiTitle: "अध्याय 12",
      englishTitle: "Adhyay 12",
      hindiTopic: "भक्ति योग",
      englishTopic: "Bhakti Yoga",
    ),
    GitaAdhyay(
      chapterNo: 13,
      hindiTitle: "अध्याय 13",
      englishTitle: "Adhyay 13",
      hindiTopic: "क्षेत्र-क्षेत्रज्ञ विभाग योग",
      englishTopic: "Ksetra Ksetrajna Vibhaaga Yoga",
    ),
    GitaAdhyay(
      chapterNo: 14,
      hindiTitle: "अध्याय 14",
      englishTitle: "Adhyay 14",
      hindiTopic: "गुणत्रय विभाग योग",
      englishTopic: "Gunatraya Vibhaga Yoga",
    ),
    GitaAdhyay(
      chapterNo: 15,
      hindiTitle: "अध्याय 15",
      englishTitle: "Adhyay 15",
      hindiTopic: "पुरुषोत्तम योग",
      englishTopic: "Purushottama Yoga",
    ),
    GitaAdhyay(
      chapterNo: 16,
      hindiTitle: "अध्याय 16",
      englishTitle: "Adhyay 16",
      hindiTopic: "दैवासुर सम्पद विभाग योग",
      englishTopic: "Daivasura Sampad Vibhaga Yoga",
    ),
    GitaAdhyay(
      chapterNo: 17,
      hindiTitle: "अध्याय 17",
      englishTitle: "Adhyay 17",
      hindiTopic: "श्रद्धात्रय विभाग योग",
      englishTopic: "Sraddhatraya Vibhaga Yoga",
    ),
    GitaAdhyay(
      chapterNo: 18,
      hindiTitle: "अध्याय 18",
      englishTitle: "Adhyay 18",
      hindiTopic: "मोक्ष सन्यास योग",
      englishTopic: "Moksha Sanyaasa Yoga",
    ),
  ];
  FlutterTts flutterTts = FlutterTts();
  static const platform = MethodChannel('com.aeonian.gita/alarm_permission');

  @override
  void initState() {
    // requestNotificationPermissions();
    // requestExactAlarmPermission();
    fetchData();
    _setTtsParameters();
    checkForUpdates();
    super.initState();
  }

  Future<void> requestExactAlarmPermission() async {
    try {
      await platform.invokeMethod('requestExactAlarmPermission');
    } on PlatformException catch (e) {
      print("Failed to request exact alarm permission: ${e.message}");
    }
  }

  Future<void> _setTtsParameters() async {
    await flutterTts.setLanguage("hi-IN");
    await flutterTts.setPitch(1); // Set pitch
    await flutterTts.setSpeechRate(0.5); // Set speech rate
    await flutterTts.setVolume(1.0); // Set volume
    // await flutterTts.se(1.0); // Set volume
  }

  void checkForUpdates() {
    try {
      InAppUpdate.checkForUpdate().then((info) {
        setState(() {
          if (info.updateAvailability == UpdateAvailability.updateAvailable) {
            update();
          }
        });
      });
    } catch (e) {}
  }

  Future<void> update() async {
    await InAppUpdate.startFlexibleUpdate();
    InAppUpdate.completeFlexibleUpdate().then((value) {});
  }

  fetchData({bool fetchAllChapters = false}) {
    try {
      if (BlocProvider.of<SeriesPostCubit>(context)
              .state
              .allGitaSlokeList
              .length <
          18) {
        for (int i = 1; i <= 18; ++i) {
          if (fetchAllChapters) {
            BlocProvider.of<SeriesPostCubit>(context)
                .fetchGitaPosts(chapter: i.toString());
          } else {
            if (!BlocProvider.of<SeriesPostCubit>(context)
                .state
                .allGitaSlokeList
                .containsKey(i)) {
              BlocProvider.of<SeriesPostCubit>(context)
                  .fetchGitaPosts(chapter: i.toString());
            }
          }
        }
      }
    } catch (e) {}
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // pathTracker.remove("gita_screen");
    super.dispose();
  }

  bool isEnglish = false;
  final SecureStorage _secureStorage = SecureStorage();
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required String imageUrl,
    required DateTime scheduledDate,
  }) async {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: 'basic_channel',
        title: title,
        body: body,
        bigPicture: imageUrl,
        // notificationLayout: NotificationLayout.BigText,
      ),
      schedule: NotificationCalendar.fromDate(date: scheduledDate),
    );
  }

  Future<void> requestNotificationPermissions() async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
      await AwesomeNotifications().requestPermissionToSendNotifications();
    }
  }

  @override
  Widget build(BuildContext context) {
    isEnglish = (tr("_a_") == "A");

    final mq = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          title: Text(
            tr("gita_title"),
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
          actions: [
            // IconButton(
            //     onPressed: () async {
            //       // try {
            //       //   for (int i = 1; i < 10; i++) {
            //       //     await scheduleNotification(
            //       //         body: 'hi hi',
            //       //         id: 21 + i,
            //       //         imageUrl: AppImages.gitaMainBanner,
            //       //         scheduledDate: DateTime.now()
            //       //             .add(Duration(seconds: (1 * i) + 5)),
            //       //         title: 'Test Notitication $i');
            //       //   }
            //       // } catch (e) {
            //       //   Logger().i(e);
            //       // }
            //       // nextScreen(context, const NotificationScreen());
            //     },
            //     icon: const Icon(
            //       Icons.person,
            //       size: 20,
            //     )),
            // IconButton(
            //   icon: const Icon(
            //     FontAwesomeIcons.bell,
            //     color: Color(0xffFFD700),
            //   ),
            //   tooltip: 'Notification',
            //   onPressed: () async {
                
            //     nextScreen(context, const NotificationScreen());
            //   },
            // ),
            PopupMenuButton<String>(
              elevation: 10,
              position: PopupMenuPosition.under,
              onSelected: ((value) async {
                if (value == "English") {
                  const Locale value = Locale("en");
                  await context.setLocale(value);
                  BlocProvider.of<LocaleCubit>(context).updateLocale(value);
                  var localeString = value.languageCode +
                      (value.countryCode != null
                          ? '_${value.countryCode}'
                          : '');
                  await _secureStorage.persistLocale(localeString);
                  toast("Language Changed");
                } else {
                  const Locale value = Locale("hi");
                  await context.setLocale(value);
                  BlocProvider.of<LocaleCubit>(context).updateLocale(value);
                  var localeString = value.languageCode +
                      (value.countryCode != null
                          ? '_${value.countryCode}'
                          : '');
                  await _secureStorage.persistLocale(localeString);
                  toast("Language Changed");
                }
              }),
              itemBuilder: (BuildContext context) {
                return {
                  'English',
                  'हिन्दी',
                }.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
              child: const Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Icon(FontAwesomeIcons.language, color: Colors.black)),
            ),
          ],

          // title: const Text('Rishteyy:- Gita Gyan'),
        ),
        drawer: const CustomDrawer(),
        body: SingleChildScrollView(
          child: BlocBuilder<SeriesPostCubit, SeriesPostState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: AspectRatio(
                      aspectRatio: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          image: const DecorationImage(
                              image: AssetImage(AppImages.gitaMainBanner),
                              fit: BoxFit.fitHeight),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    child: ListView.builder(
                        itemCount: gitaChapters.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (ctx, index) {
                          GitaAdhyay adhyayName = gitaChapters[index];
                          return InkWell(
                            onTap: () {
                              Logger().i("Mil gaya sala 0");
                              // Map<int, List<GitaSloke>> tempSlokeList = {};
                              // tempSlokeList.addAll(state.allGitaSlokeList);
                              // Logger().i(tempSlokeList);
                              final String key = (index + 1).toString();
                              // return;
                              if (state.allGitaSlokeList
                                  .containsKey(index + 1)) {
                                Logger().i("Mil gaya sala 1");
                                List<GitaSloke> list =
                                    state.allGitaSlokeList[index + 1] ?? [];
                                BlocProvider.of<SeriesPostCubit>(context)
                                    .updateVariables(
                                  chapter: key,
                                  gitaSlokeList: list,
                                  totalSloke: list.length,
                                );
                                if (list.isNotEmpty) {
                                  Logger().i("Mil gaya sala");
                                  Logger().i(list);
                                  nextScreenWithFadeAnimation(
                                      context,
                                      GitaGyanSpecificSlokeScreen(
                                        chaperNo: key,
                                        flutterTts: flutterTts,
                                        isDataPresent: true,
                                      ));
                                } else {
                                  Logger().i("Mil gaya sala 2");
                                  nextScreenWithFadeAnimation(
                                      context,
                                      GitaGyanSpecificSlokeScreen(
                                        flutterTts: flutterTts,
                                        chaperNo: key,
                                        isDataPresent: false,
                                      ));
                                }
                              } else {
                                nextScreenWithFadeAnimation(
                                    context,
                                    GitaGyanSpecificSlokeScreen(
                                      chaperNo: key,
                                      flutterTts: flutterTts,
                                      isDataPresent: false,
                                    ));
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Container(
                                height: mq.height * 0.1,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  image: const DecorationImage(
                                      image: AssetImage(
                                        AppImages.gitaBanner,
                                      ),
                                      fit: BoxFit.fill),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        isEnglish
                                            ? adhyayName.englishTitle
                                            : adhyayName.hindiTitle,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        isEnglish
                                            ? adhyayName.englishTopic
                                            : adhyayName.hindiTopic,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: Color(0xfffede57),
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  const SizedBox(height: 100),
                ],
              );
            },
          ),
        ));
  }
}

class GitaAdhyay extends Equatable {
  final int chapterNo;
  final String hindiTitle;
  final String englishTitle;
  final String hindiTopic;
  final String englishTopic;
  const GitaAdhyay({
    required this.chapterNo,
    required this.hindiTitle,
    required this.englishTitle,
    required this.hindiTopic,
    required this.englishTopic,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [chapterNo];
}
