#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes_zm\_hud_util;
#include maps\mp\gametypes_zm\_hud_message;

main()
{
	precachemodel("zombie_teddybear");
}

init()
{
    level thread setteddybears();
    level.teddybears = 0;
    
    level thread onPlayerConnect();
}

onPlayerConnect()
{
    for(;;)
    {
        level waittill("connected", player);
        player thread onPlayerSpawned();
    }
}

onPlayerSpawned()
{
    self endon("disconnect");
	level endon("game_ended");
    for(;;)
    {
        self waittill("spawned_player");
		
		// Will appear each time when the player spawn, that's just an exemple.
		self iprintln("^4Secret Music Easter Egg in Survival maps ^7created by ^1techboy04gaming");
    }
}

spawnTeddyBear(x,y,z,angle)
{
	TeddyTrigger = spawn( "trigger_radius", ((x,y,z)), 1, 50, 50 );
	TeddyModel = spawn( "script_model", ((x,y,z)), 1, 50, 50 );
	TeddyModel setmodel("zombie_teddybear");
	TeddyModel rotateto((0,angle,0),.1);

	while(1)
	{
		TeddyTrigger waittill( "trigger", i );
		if ( i usebuttonpressed() )
		{
			level.teddybears += 1;
			i playsound( "zmb_meteor_activate" );
			
			if (level.teddybears == 3) 
			{
				foreach (player in level.players)
				{
					player playsound("mus_zmb_secret_song");
				}
			}
			
			break;
		}
	}
}

setteddybears()
{
	if ( getDvar( "g_gametype" ) == "zstandard" )
	{
		if(getDvar("mapname") == "zm_transit") //transit grief and survival
		{
			if(getDvar("ui_zm_mapstartlocation") == "town")
			{
				thread spawnTeddyBear(430,-570,-61,26);
				thread spawnTeddyBear(2312,579,-55,-137);
				thread spawnTeddyBear(699,-1387,128,-48);
			}
			else if (getDvar("ui_zm_mapstartlocation") == "transit")
			{
				thread spawnTeddyBear(-7645,5377,-58,-177);
				thread spawnTeddyBear(-6656,4408,-63,-120);
				thread spawnTeddyBear(-6380,5625,-45,-132);
			}
			else if (getDvar("ui_zm_mapstartlocation") == "farm")
			{
				thread spawnTeddyBear(8512,-5913,52,-134);
				thread spawnTeddyBear(8449,-5350,48,127);
				thread spawnTeddyBear(8125,-6730,117,19);
			}
		}
	}
}
