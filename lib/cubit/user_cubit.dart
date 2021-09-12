import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_market/models/models.dart';
import 'package:food_market/services/services.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  Future<void> loadUser() async {
    ApiReturnValue<User> result = await UserServices.loadUser();

    if (result.value != null) {
      emit(UserLoaded(result.value));
    } else {
      emit(UserInitial());
    }
  }

  Future<void> signIn(String email, String password) async {
    ApiReturnValue<User> result = await UserServices.signIn(email, password);

    if (result.value != null) {
      emit(UserLoaded(result.value));
    } else {
      emit(UserLoadingFailed(result.message));
    }
  }

  Future<void> signUp(User user, String password, {File pictureFile}) async {
    ApiReturnValue<User> result =
        await UserServices.signUp(user, password, pictureFile: pictureFile);

    if (result.value != null) {
      emit(UserLoaded(result.value));
    } else {
      emit(UserLoadingFailed(result.message));
    }
  }

  Future<bool> signOut() async {
    ApiReturnValue<bool> result = await UserServices.signOut();

    if (result.value != null) {
      emit(UserInitial());
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateProfile(User user, {File pictureFile}) async {
    ApiReturnValue<User> result =
        await UserServices.updateProfile(user, pictureFile: pictureFile);

    if (result.value != null) {
      emit(UserLoaded(result.value));
      return true;
    } else {
      emit(UserLoaded((state as UserLoaded).user, message: result.message));
      return false;
    }
  }

  Future<bool> updateAddress(User user) async {
    ApiReturnValue<User> result = await UserServices.updateAddress(user);

    if (result.value != null) {
      emit(UserLoaded(result.value));
      return true;
    } else {
      emit(UserLoaded((state as UserLoaded).user, message: result.message));
      return false;
    }
  }

  Future<void> uploadProfilePicture(File pictureFile) async {
    ApiReturnValue<String> result =
        await UserServices.uploadProfilePicture(pictureFile);

    if (result.value != null) {
      emit(UserLoaded(
          (state as UserLoaded).user.copyWith(picturePath: result.value)));
    } else {
      emit(UserLoadingFailed(result.message));
    }
  }
}
