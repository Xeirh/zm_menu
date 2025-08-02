player_connect()
{
    printf( "*** Working ***" );
}

player_disconnect()
{}

player_damage( e_inflictor, e_attacker, n_damage, n_dflags, str_method, str_weapon, v_point, v_dir, str_hit_loc, n_offset_time, n_model_index )
{
    if( isdefined( self.god_mode ) && self.god_mode )
        return;

    [[ level.player_damage ]]( e_inflictor, e_attacker, n_damage, n_dflags, str_method, str_weapon, v_point, v_dir, str_hit_loc, n_offset_time, n_model_index );
}