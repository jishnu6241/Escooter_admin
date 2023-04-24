import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'hub_event.dart';
part 'hub_state.dart';

class HubBloc extends Bloc<HubEvent, HubState> {
  HubBloc() : super(HubInitialState()) {
    on<HubEvent>((event, emit) async {
      emit(HubLoadingState());
      SupabaseClient supabaseClient = Supabase.instance.client;
      SupabaseQueryBuilder queryTable = supabaseClient.from('hub');
      try {
        if (event is GetAllHubEvent) {
          List<dynamic> temp = event.query != null
              ? await queryTable
                  .select('*')
                  .ilike('name', '%${event.query}%')
                  .order("name", ascending: true)
              : await queryTable.select('*').order('created_at');

          List<Map<String, dynamic>> hubs =
              temp.map((e) => e as Map<String, dynamic>).toList();

          emit(
            HubSuccessState(
              hubs: hubs,
            ),
          );
        } else if (event is AddHubEvent) {
          await queryTable.insert({
            'name': event.name,
            'address': event.address,
            'latitude': event.latLng.latitude,
            'longitude': event.latLng.longitude,
          });
          add(GetAllHubEvent());
        } else if (event is EditHubEvent) {
          if (event.latLng != null) {
            await queryTable.update({
              'name': event.name,
              'address': event.address,
              'latitude': event.latLng!.latitude,
              'longitude': event.latLng!.longitude,
            }).eq('id', event.hubId);
          } else {
            await queryTable.update({
              'name': event.name,
              'address': event.address,
            }).eq('id', event.hubId);
          }

          add(GetAllHubEvent());
        } else if (event is DeleteHubEvent) {
          await queryTable.delete().eq('id', event.id);
          add(GetAllHubEvent());
        }
      } catch (e, s) {
        Logger().wtf('$e,$s');
        emit(HubFailureState());
      }
    });
  }
}
