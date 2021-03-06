import 'package:flutter/material.dart';
import '../res/palette.dart';
import '../utils/database.dart';

class EachTrackPage extends StatefulWidget {
  final String trackName;
  final String trackDescription;
  final int numberOfPoses;

  const EachTrackPage({
    @required this.trackName,
    @required this.trackDescription,
    @required this.numberOfPoses,
  });

  @override
  _EachTrackPageState createState() => _EachTrackPageState();
}

class _EachTrackPageState extends State<EachTrackPage> {
  final Database _database = Database();

  String trackName;
  String trackDescription;
  int totalNumberOfPoses;

  @override
  void initState() {
    super.initState();
    trackName = widget.trackName;
    trackDescription = widget.trackDescription;
    totalNumberOfPoses = widget.numberOfPoses;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 16.0, left: 16.0, right: 16.0, bottom: 16.0),
                  child: Text(
                    trackName[0].toUpperCase() + trackName.substring(1),
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      color: Palette.black,
                    ),
                  ),
                ),
                // ShaderMask(
                //   shaderCallback: (rect) {
                //     return LinearGradient(
                //       begin: Alignment.center,
                //       end: Alignment.bottomCenter,
                //       colors: [Colors.black, Colors.black, Colors.transparent],
                //     ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                //   },
                //   blendMode: BlendMode.dstIn,
                //   child: Image.asset(
                //     'assets/images/${trackName[0].toUpperCase() + trackName.substring(1)}.jpg',
                //   ),
                // ),
                Image.asset(
                    'assets/images/${trackName[0].toUpperCase() + trackName.substring(1)}.jpg'),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 16.0,
                    left: 16.0,
                    right: 16.0,
                  ),
                  child: Text(
                    trackDescription,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.6,
                      color: Palette.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 16.0,
                    left: 16.0,
                    right: 16.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: screenWidth / 2.2,
                        child: Center(
                          child: Text(
                            '$totalNumberOfPoses asanas',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1,
                              color: Palette.black,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        color: Palette.black.withOpacity(0.4),
                        height: 40,
                        width: 2,
                      ),
                      Container(
                        width: screenWidth / 2.2,
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.access_time,
                                color: Palette.black.withOpacity(0.8),
                              ),
                              SizedBox(width: 8.0),
                              Text(
                                '15 minutes',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 1,
                                  color: Palette.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.0),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: FutureBuilder(
                    future: _database.retrievePoses(trackName: trackName),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: snapshot.data.length,
                          separatorBuilder: (context, index) => SizedBox(
                            height: 32.0,
                          ),
                          itemBuilder: (_, index) {
                            String poseTitle = snapshot.data[index]['title'];
                            String poseSubtitle = snapshot.data[index]['sub'];

                            return InkWell(
                              onTap: () {
                                // Navigator.of(context).push(
                                //   MaterialPageRoute(
                                //     builder: (context) => EachTrackPage(
                                //       trackName: trackName,
                                //       trackDescription: trackDescription,
                                //     ),
                                //   ),
                                // );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Palette.mediumShade,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 16.0, top: 24.0),
                                              child: Text(
                                                poseTitle[0].toUpperCase() +
                                                    poseTitle.substring(1),
                                                // maxLines: 1,
                                                softWrap: true,
                                                overflow: TextOverflow.fade,
                                                style: TextStyle(
                                                  fontSize: 22.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Palette.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Palette.lightDarkShade,
                                              borderRadius: BorderRadius.only(
                                                  topRight:
                                                      Radius.circular(8.0),
                                                  bottomLeft:
                                                      Radius.circular(8.0)),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(
                                                Icons.play_arrow,
                                                color: Colors.white,
                                                size: 36.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16.0, top: 4.0),
                                        child: Text(
                                          poseSubtitle[0].toUpperCase() +
                                              poseSubtitle.substring(1),
                                          maxLines: 1,
                                          softWrap: false,
                                          overflow: TextOverflow.fade,
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w400,
                                            color: Palette.black,
                                          ),
                                        ),
                                      ),
                                      // SizedBox(height: 24.0),
                                      // TODO: Add the description when the descriptions
                                      // are updated to firebase.
                                      SizedBox(height: 8.0),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 16.0,
                                          right: 16.0,
                                          bottom: 24.0,
                                        ),
                                        child: Text(
                                          trackDescription,
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 1,
                                            color: Palette.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                      return Container();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
