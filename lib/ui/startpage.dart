import 'package:facebook_clone/constants/colors.dart';
import 'package:facebook_clone/viewmodel/startviewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<StartViewModel>.withConsumer(
      viewModelBuilder: () => StartViewModel(),
      onModelReady: (model) => model.hasActiveLogin(),
      builder: (context, model, _) => Scaffold(
        backgroundColor: backgroundLight,
        body: Center(
          child: SizedBox(
            height: 80,
            width: 80,
            child: CircularProgressIndicator(
              strokeWidth: 5,
              valueColor: AlwaysStoppedAnimation(blue),
            ),
          ),
        ),
      ),
    );
  }
}
