integer broadcastChannel = -666666;
integer menuChannel = -9947;
key owner;

openBook () {
    llStartAnimation("Bookopen");
    llMessageLinked(LINK_SET, 0, "open", llDetectedKey(0));
}

closeBook () {
    llStopAnimation("Bookopen");
    llMessageLinked(LINK_SET, 0, "close", llDetectedKey(0));
}

openMainMenu () {
    list menu = ["Fireball", "Freeze", "Dark", "Meteor Rain", "Spike Trap", "Attract", "Levitate", "Explosion", "<< Stop >>"];
    llDialog(owner, "Select the Spell...", menu, menuChannel);
}

makeSpell (string name) {
    if (name == "Fireball") {
       doFireball();
    } else if (name == "Freeze") {
        doFreeze();
    } else if (name == "Dark") {
        doDark();
    } else if (name == "Meteor Rain") {
        doMeteorRain();
    } else if (name == "Mind Control") {
        doMindControl();
    } else if (name == "Spike Trap") {
        doSpikeTrap();
    } else if (name == "Attract") {
        doAttract();
    } else if (name == "Levitate") {
        doLevitate();
    } else if (name == "Explosion") {
        doExplosion();
    } else if (name == "<< Stop >>") {
        doStop();
    }

    closeBook();
}

doFireball() {
    float bulletspeed = 150;
    rotation rot = llGetRot();
    vector fwd = llRot2Fwd(rot);
    vector pos = llGetPos();
    pos = pos + fwd;
    pos.z +=  2;
    fwd = fwd * bulletspeed;
    llRezObject("Fireball", pos, fwd, rot, 0);
}

doFreeze() {
    llRezObject("Freeze", llGetPos() + <0,0,10>, <0,0,0>, <0,0,0,0>, 0);
}

doDark() {
    llRezObject("Dark", llGetPos() + <0,0,10>, <0,0,0>, <0,0,0,0>, 0);
}

doMeteorRain() {
    llRezObject("Meteor Rain", llGetPos() + <0,0,10>, <0,0,0>, <0,0,0,0>, 0);
}

doMindControl() {
    llRezObject("Mind Control", llGetPos() + <0,0,10>, <0,0,0>, <0,0,0,0>, 0);
}
 
doSpikeTrap() {
    llRezObject("Spike Trap", llGetPos() + <0,0,10>, <0,0,0>, <0,0,0,0>, 0);
}
 
doAttract() {
    llRezObject("Attract", llGetPos() + <0,0,10>, <0,0,0>, <0,0,0,0>, 0);
}
 
doLevitate() {
    llRezObject("Levitate", llGetPos() + <0,0,10>, <0,0,0>, <0,0,0,0>, 0);
}

doExplosion() {
    llRezObject("Explosion", llGetPos() + <0,0,10>, <0,0,0>, <0,0,0,0>, 0);
}

doStop() {
    llRegionSay(broadcastChannel, "Delete>>Spells|" + (string)llGetOwner());    
}

default
{
    state_entry()
    {
        owner = llGetOwner();
        llListen(menuChannel, "", owner, "");
        llRequestPermissions(owner, PERMISSION_TRIGGER_ANIMATION);
    }

    touch_start(integer total_number)
    {
        if (owner == llDetectedKey(0)) {
            openBook();
            openMainMenu();
        }
    }
    
    listen(integer chan, string name, key id, string msg)
    {
        makeSpell(msg);
    }
}
