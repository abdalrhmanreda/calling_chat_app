import 'package:calling_chat_app/config/routes/routes_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'config/routes/router.dart';
import 'config/themes/themes.dart';
class CallingChatApp extends StatelessWidget {
  const CallingChatApp({super.key, required this.appRouter});
  final AppRouter appRouter  ;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 813),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          top: true,
          bottom: true,
          child: MaterialApp(
            locale: const Locale('ar', 'EG'),
            debugShowCheckedModeBanner: false,
            onGenerateRoute: appRouter.generateRoute,
            theme: Style.lightTheme,
            themeMode: ThemeMode.light,
            initialRoute: RoutePath.login,
          ),
        ),
      ),
    );
  }
}
