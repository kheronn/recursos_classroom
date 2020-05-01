import 'package:course_app/app/model/recurso.dart';
import 'package:course_app/app/modules/categoria/categoria_controller.dart';
import 'package:course_app/app/widgets/chapter_card.dart';
import 'package:course_app/app/widgets/course.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants.dart';

class CategoriaPage extends StatefulWidget {
  final String tipo;
  const CategoriaPage({Key key, this.tipo}) : super(key: key);

  @override
  _CategoriaPageState createState() => _CategoriaPageState();
}

class _CategoriaPageState
    extends ModularState<CategoriaPage, CategoriaController> {
  @override
  void initState() {
    this.controller.tipo = widget.tipo;
    controller.filtrar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFF5F4EF),
            image: DecorationImage(
              image: AssetImage("assets/images/playlist.png"),
              alignment: Alignment.topCenter,
            ),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 20, top: 70, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 90),
                    Text(controller.tipo.toUpperCase(),
                        style: kHeadingextStyle),
                    SizedBox(height: 10),
                    Observer(builder: (_) {
                      if (controller.recursos == null ||
                          controller.recursos.length < 1) {
                        return Container();
                      } else {
                        return Row(
                          children: <Widget>[
                            SvgPicture.asset("assets/icons/person.svg"),
                            SizedBox(width: 5),
                            Text(controller.recursos.length.toString())
                          ],
                        );
                      }
                    }),
                  ],
                ),
              ),
              Observer(builder: (_) {
                List<Recurso> list = controller.recursos;
                if (list == null || list.isEmpty) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: list.length,
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      Recurso model = list[index];
                      return ChapterCard(
                          name: model.titulo,
                          chapterNumber: (index + 1),
                          tag: model.autoria,
                          link: model.link);
                    },
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
