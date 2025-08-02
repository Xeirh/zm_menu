initialize()
{
    level.unique_string = [];
    level.private_match = !level.rankedmatch;

    level initialize_callback();
    level initialize_precache();
}

initialize_callback()
{
    maps\mp\zombies\_zm_utility::onplayerconnect_callback( operation\intercept_external::player_connect );
    maps\mp\zombies\_zm_utility::onplayerdisconnect_callback( operation\intercept_external::player_disconnect );

    level.player_damage        = level.callbackplayerdamage;
    level.callbackplayerdamage = operation\intercept_external::player_damage;
}

initialize_precache()
{
    precacheshader( "initiative_variable_false" );
    precacheshader( "initiative_variable_true" );
    precacheshader( "initiative_variable_true_highlight" );
}