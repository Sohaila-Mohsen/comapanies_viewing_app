import 'package:authentication_app/services/dio_helper.dart';
import 'package:authentication_app/utils/sp_helper/cache_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../models/user.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);

  UserResponse? userResponse;

  void register(User user) {
    DioHelper.postData(url: "api/register", data: user.toJson()).then((value) {
      print("here1");
      print(value.data);
      print("here2");
      userResponse = UserResponse.fromJson(value.data);
      if (userResponse!.status!) {
        print("here3");
        //SharedPreferencesHelper.saveData(
        // key: "token", value: userResponse!.user!.token);
        emit(RegisterSuccessState());
      } else {
        print("here33");
        emit(RegisterErrorState());
      }
    }).catchError((error) {
      print("erroe $error");
      emit(RegisterErrorState());
    });
  }
}
