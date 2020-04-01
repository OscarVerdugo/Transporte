import 'package:flutter/material.dart';

import 'package:app/models/Status.dart';
//pages
import 'package:app/pages/AuthPages/phone_registration_page.dart';
import 'package:app/pages/AuthPages/phone_validation_page.dart';
import 'package:app/pages/AuthPages/signin_page.dart';
import 'package:app/pages/AuthPages/signup_page.dart';
import 'package:app/pages/home_page.dart';



final Routes = {
  "/":(BuildContext c) => SignIn(),
  "signin": (BuildContext c) => SignIn(),
  "signup": (BuildContext c) => SignUp(),
  "phoneRegistration" : (BuildContext c) => PhoneRegistration(),
  "phoneValidation":(BuildContext c) => PhoneValidation(),
  "home": (BuildContext c) => Home()
};

final RoutesByStatus = {
  Status.Authenticated : "home",
  Status.Authenticating: "",
  Status.Unauthenticated: "signin",
  Status.Uninitialized: "",
  Status.UnverifiedPhone: "phoneValidation",
  Status.WithoutPhone:"phoneRegistration"
};