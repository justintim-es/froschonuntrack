import 'package:redux_epics/redux_epics.dart';
import 'package:frontend/redux/combiner.dart';
import 'package:dio/dio.dart';
import 'package:frontend/redux/register/reducer.dart';
import 'dart:async';
import 'package:frontend/redux/combiner.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
Stream<dynamic> register(Stream<dynamic> actions, EpicStore<AppState> store) {
	return actions
		.where((action) => action is RegisterFetch)
		.asyncMap<dynamic>((action) => Dio().post('${store.state.url.url}/register', data: {
			'nickname': action.nickname,
			'password': action.password
		}).then<dynamic>((res) => NavigateToAction('/login')).catchError((error) => RegisterFetchError(error.response.data['error'])));
}
