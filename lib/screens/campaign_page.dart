import 'package:flutter/material.dart';
import 'package:sub4subytbsrt/utils/colors.dart';
import 'package:sub4subytbsrt/utils/dimentions.dart';

class CampaignPage extends StatefulWidget {
  const CampaignPage({super.key});

  @override
  State<CampaignPage> createState() => _CampaignPageState();
}

class _CampaignPageState extends State<CampaignPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Campaign",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: followButton,
        elevation: 2.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(Dimentions.height15),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        leading: Container(
                          height: Dimentions.height50,
                          width: Dimentions.height50,
                          decoration: BoxDecoration(
                              color: followButton,
                              borderRadius: BorderRadius.circular(100)),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Id#27",
                              style: TextStyle(
                                  color: Colors.black38,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const LinearProgressIndicator(),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  "assets/images/ytlogo.png",
                                  height: 20,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Text("3/7",
                                    style: TextStyle(fontSize: 12)),
                                const SizedBox(
                                  width: 5,
                                ),
                                Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.blue),
                                    child: const Text(
                                      "Active",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 10),
                                    ))
                              ],
                            )
                          ],
                        ),
                        trailing: const Icon(
                          Icons.more_vert,
                          color: followButton,
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
