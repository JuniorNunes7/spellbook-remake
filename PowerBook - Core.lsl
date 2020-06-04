integer BroadcastChannel666 = -666666;
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
    list menu = ["Fireball", "Freeze", "Dark", "<< Stop >>"];
    llDialog(owner, "Select the Spell...", menu, menuChannel);
}

makeSpell (string name) {
    if (name == "Fireball") {
       doFireball();
    } else if (name == "Freeze") {
        doFreeze();
    } else if (name == "Dark") {
        doDark();
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
    llRezObject("Freeze", llGetPos() + <0,0,-10>, <0,0,0>, <0,0,0,0>, 0);
}

doDark() {
    llRezObject("Dark", llGetPos() + <0,0,-10>, <0,0,0>, <0,0,0,0>, 0);
}

doStop() {
    llRegionSay(BroadcastChannel666, "Delete>>Spells|" + (string)llGetOwner());    
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
        if (owner != llDetectedKey(0)) {
            llOwnerSay("Intruso: " + llDetectedName(0));
            return;
        }

        openBook();
        openMainMenu();
    }
    
    listen(integer chan, string name, key id, string msg)
    {
        makeSpell(msg);
    }
}
