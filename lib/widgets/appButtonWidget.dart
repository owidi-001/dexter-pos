import 'package:dexter/theme/theme.dart';
import 'package:flutter/material.dart';

class AppButtonWidget extends StatelessWidget {
  final String title;
  final Color? background;
  final Function() onPressedCallBack;
  const AppButtonWidget(
      {super.key,
      required this.title,
      required this.onPressedCallBack,
      this.background});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      color: background ?? AppTheme.secondary,
      child: MaterialButton(
        onPressed: onPressedCallBack,
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: double.infinity,
        child: Text(
          title.toUpperCase(),
          style: const TextStyle(
              color: AppTheme.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
    );
  }
}

class ButtonLoading extends StatelessWidget {
  final String title;
  final Function() function;
  const ButtonLoading({super.key, required this.title, required this.function});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      color: AppTheme.secondary,
      child: MaterialButton(
          onPressed: function,
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                    color: AppTheme.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              const CircularProgressIndicator(
                color: AppTheme.white,
              ),
            ],
          )),
    );
  }
}
