auto_archive()
{
    if( !isdefined( self.element_result ) )
        self.element_result = 0;

    return isdefined( self.element_result ) && self.element_result >= 20;
}

create_text( text, font, font_scale, point, relative_point, x_offset, y_offset, color, alpha, sort )
{
    element = self maps\mp\gametypes_zm\_hud_util::createfontstring( font, font_scale );
    element maps\mp\gametypes_zm\_hud_util::setpoint( point, relative_point, x_offset, y_offset );

    element.color          = color;
    element.alpha          = alpha;
    element.sort           = sort;
    element.anchor         = self;
    element.hidewheninmenu = true;
    element.archived       = self auto_archive();
    if( isint( text ) || isfloat( text ) )
        element setvalue( text );
    else
        element set_text( text );

    self.element_result++;
    return element;
}

set_text( text )
{
    if( !isdefined( self ) || !isdefined( text ) )
        return;

    self settext( text );
}

create_shader( shader, point, relative_point, x_offset, y_offset, width, height, color, alpha, sort )
{
    element                = newclienthudelem( self );
    element.elemtype       = "icon";
    element.children       = [];
    element.color          = color;
    element.alpha          = alpha;
    element.sort           = sort;
    element.anchor         = self;
    element.hidewheninmenu = true;
    element.archived       = self auto_archive();

    element maps\mp\gametypes_zm\_hud_util::setparent( level.uiparent );
    element maps\mp\gametypes_zm\_hud_util::setpoint( point, relative_point, x_offset, y_offset );
    element set_shader( shader, width, height );

    self.element_result++;
    return element;
}

set_shader( shader, width, height )
{
    if( !isdefined( self ) )
        return;

    if( !isdefined( shader ) )
    {
        if( !isdefined( self.shader ) )
            return;

        shader = self.shader;
    }

    if( !isdefined( width ) )
    {
        if( !isdefined( self.width ) )
            return;

        width = self.width;
    }

    if( !isdefined( height ) )
    {
        if( !isdefined( self.height ) )
            return;

        height = self.height;
    }

    self.shader = shader;
    self.width  = width;
    self.height = height;
    self setshader( shader, width, height );
}

destroy_element()
{
    if( !isdefined( self ) )
        return;

    self destroy();
    if( isdefined( self.anchor ) )
        self.anchor.element_result--;
}

destroy_structure()
{
    for( index = 0; index < self.option_limit; index++ )
    {
        if( isdefined( self.initiative_option ) && self.initiative_option.size )
            self.initiative_option destroy_element();

        if( isdefined( self.initiative_shader ) && self.initiative_shader.size )
            self.initiative_shader destroy_element();
    }
}

destroy_all( array )
{
    if( !isdefined( array ) || !isarray( array ) )
        return;

    foreach( index, key in getarraykeys( array ) )
    {
        if( isdefined( array[ key ] ) )
            array[ key ] destroy_element();
    }
}