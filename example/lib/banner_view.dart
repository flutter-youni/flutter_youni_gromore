import 'package:flutter/material.dart';
import 'ads_config.dart';
import 'package:flutter_youni_gromore/view/gromore_banner_widget.dart';
/// @Author liuxiong
/// @Date 2024/3/9 10:27
/// @Description TODO
class BannerView extends StatefulWidget {
  const BannerView({Key? key}) : super(key: key);

  @override
  State<BannerView> createState() => _BannerViewState();
}

class _BannerViewState extends State<BannerView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Banner广告",style: TextStyle(color:Colors.white,fontSize: 18),),
        centerTitle: true,
        leading:const BackButton(
          color: Colors.tealAccent,
        ),
      ),
      body: Container(
          width: double.infinity,
          height: 140,
          color: Colors.grey[200],
          alignment: Alignment.center,
          child: Column(
            children: [
              const SizedBox(height: 30),
              GromoreBannerWidget(
                codeId: AdsConfig.bannerId,
                width: 300,
                height: 75,
              ),
            ],
          )),
    );
  }
}
