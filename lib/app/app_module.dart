import 'package:course_app/app/app_controller.dart';
import 'package:course_app/app/repositories/recurso_api.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:course_app/app/app_widget.dart';
import 'package:course_app/app/modules/home/home_module.dart';

import 'modules/categoria/categoria_page.dart';
import 'modules/home/splash.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AppController()),
        Bind((i) => RecursoAPI()),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, _args) => SplashScreen()),
        Router('/home', module: HomeModule()),
        Router('/categoria/:tipo',
            child: (_, args) => CategoriaPage(tipo: args.params['tipo'])),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
