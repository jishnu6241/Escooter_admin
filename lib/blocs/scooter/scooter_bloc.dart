import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'scooter_event.dart';
part 'scooter_state.dart';

class ScooterBloc extends Bloc<ScooterEvent, ScooterState> {
  ScooterBloc() : super(ScooterInitialState()) {
    on<ScooterEvent>((event, emit) async {
      emit(ScooterLoadingState());
      SupabaseClient supabaseClient = Supabase.instance.client;
      SupabaseQueryBuilder queryTable = supabaseClient.from('scooter');
      SupabaseQueryBuilder hubTable = supabaseClient.from('hub');
      try {
        if (event is GetAllScooterEvent) {
          List<dynamic> temp = [];

          if (event.query != null) {
            temp = await queryTable
                .select('*')
                .ilike('plate_no', '%${event.query}%')
                .eq('status', event.status)
                .order("plate_no", ascending: true);
          } else {
            temp = await queryTable
                .select('*')
                .eq('status', event.status)
                .order("plate_no", ascending: true);
          }

          List<Map<String, dynamic>> scooters =
              temp.map((e) => e as Map<String, dynamic>).toList();

          for (int i = 0; i < scooters.length; i++) {
            Map<String, dynamic>? hub = await hubTable
                .select('*')
                .eq('id', scooters[i]['parked_hub_id'])
                .single();
            if (hub != null) {
              scooters[i]['hub'] = hub;
            }
          }
          emit(
            ScooterSuccessState(
              scooters: scooters,
            ),
          );
        } else if (event is AddScooterEvent) {
          await queryTable.insert({
            'plate_no': event.plateNo,
            'parked_hub_id': event.parkedHubId,
            'key': generateRandom5DigitInt(),
          });
          add(GetAllScooterEvent(status: event.status!));
        } else if (event is EditScooterEvent) {
          await queryTable.update({
            'plate_no': event.plateNo,
            'parked_hub_id': event.parkedHubId,
            'key': generateRandom5DigitInt(),
          }).eq('id', event.scooterId);

          add(GetAllScooterEvent(status: 'hold'));
        } else if (event is DeleteScooterEvent) {
          await queryTable.delete().eq('id', event.id);
          add(GetAllScooterEvent());
        }
      } catch (e, s) {
        Logger().wtf('$e,$s');
        emit(ScooterFailureState());
      }
    });
  }
}

int generateRandom5DigitInt() {
  Random random = Random();
  int min = 10000; // minimum 5 digit integer
  int max = 99999; // maximum 5 digit integer
  return min + random.nextInt(max - min);
}
