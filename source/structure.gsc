// structure resources

    // setting

    set_menu( menu )
    {
        self.menu = menu;
    }

    set_title( title )
    {
        self.menu_title = title;
    }

    set_cursor( index )
    {
        self.cursor[ self get_menu() ] = index;
    }

    set_state( bool )
    {
        self.menu_init = bool;
    }

    set_locked( bool )
    {
        self.menu_locked = bool;
    }

    // getting

    get_menu()
    {
        return self.menu;
    }

    get_title()
    {
        return self.menu_title;
    }

    get_cursor()
    {
        return self.cursor[ self get_menu() ];
    }

    get_summary()
    {
        return self.structure[ self get_cursor() ].summary;
    }

    // additional

    has_access()
    {
        return isdefined( self.access ) && self.access != "None";
    }

    in_menu()
    {
        return isdefined( self.menu_init ) && self.menu_init;
    }

    is_locked()
    {
        return isdefined( self.menu_locked ) && self.menu_locked;
    }

    correct_cursor()
    {
        if( self get_cursor() >= self.structure.size )
            self set_cursor( ( self.structure.size - 1 ) );
    }

    empty_option()
    {
        return "Oops, Nothing Here Yet!";
    }

    empty_operation()
    {}

    execute_operation( operation, parameter_1, parameter_2 )
    {
        self endon( "disconnect" );
        if( !isdefined( operation ) )
            return;

        if( isdefined( parameter_2 ) )
            return self thread [[ operation ]]( parameter_1, parameter_2 );

        if( isdefined( parameter_1 ) )
            return self thread [[ operation ]]( parameter_1 );

        self thread [[ operation ]]();
    }

//

add_menu( title )
{
    self.structure = [];
    if( !isdefined( self get_cursor() ) )
        self set_cursor( 0 );

    self set_title( title );
}

add_option( title = ::empty_option, summary, operation = ::empty_operation, parameter_1, parameter_2 )
{
    option             = spawnstruct();
    option.title       = title;
    option.summary     = summary;
    option.operation   = operation;
    option.parameter_1 = parameter_1;
    option.parameter_2 = parameter_2;

    self.structure[ self.structure.size ] = option;
}

new_menu( menu )
{
    self notify( "new_menu" );
    if( !isdefined( menu ) )
    {
        menu                                        = self.previous[ ( self.previous.size - 1 ) ]
        self.previous[ ( self.previous.size - 1 ) ] = undefined;
    }
    else
    {
        if( self get_menu() == "All Players" )
        {
            player               = level.players[ self get_cursor() ];
            self.selected_player = player;
        }

        self.previous[ self.previous.size ] = self get_menu();
    }

    self set_menu( menu );
}