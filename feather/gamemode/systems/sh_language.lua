// MAKE GET LANG DONE

GM.Languages = {}

function GetLang(name, ...)
	if GAMEMODE.Languages[GAMEMODE.Language] or GAMEMODE.Languages[GAMEMODE.Language][name] then
		return string.format( GAMEMODE.Languages[GAMEMODE.Language][name], ... )
	end

	return "Failed to get language ".. name	
end

local lang = "english"
GM.Languages[lang] = {}
local l = GM.Languages[lang]


l.hitrequest = "You requested hit %s for %s."
l.zerosalary = "You did not receive a salary because you are unemployed"
l.nopay = "You did not receive your pay."
l.payday = "You have received a pay of %s!"
l.canttalk = "You can't talk for now!"
l.noperm = "You don't have enough permission to do this."
l.cantbecomejob = "You cannot become job right now."
l.getjob = "%s has been %."
l.cantafford = "You can't afford it."
l.cantvote = "You can't vote right now."
l.yes = "Yes"
l.no = "No"
l.votetime = "Time: %s"
l.cantdo = "You can't do that."
l.givemoney = "You gave %s to %s."
l.biggerthan = "You must provide the number bigger than %s."
l.purchase = "You purchased %s for %s."
l.provide = "You must provide %s."
l.entinvalid = "That %s does not exists."
l.faceadjent = "You must face the entity that you can set the price."
l.modify_button = "Modify"
l.purchase_button = "Purchase"
l.close_button = "Close"
l.begoverment = "You should be in goverment to do this action."
l.bemayor = "You should be mayor to do this action."
l.moneyfound = "You found %s."
l.price = "Price : %s"
l.cookingfood = "Cooking Food%s"

l.wanted = "Player %s is now wanted by the police.\nReason: %s"
l.unwanted = "%s is no longer wanted by the police."
l.arrested = "%s is arrested by %s.\nArrest Time: %s."
l.arrestedby = "You're arrested by %s."
l.unarrested = "%s is unarrested by %s"
l.unarrestedfull = "You're now back to the life."
l.wantedgoverment = "You can't wanted govement player."
l.alreadywanted = "That player is already wanted."

l.unowned = "Unowned"
l.unownable = "Unownable"
l.itsunownable = "The door is unownable."
l.doorowner = "Owner: %s"
l.doornoowner = "This door has no owner."
l.dooroccupied = "You don't own this door."
l.doorsold = "You sold this door."
l.doorpurchase = "You purchased this door for %s."
l.setdoorownable = "You set this door ownable."
l.setdoorunownable = "You set this door unownable."
l.setdoorhidden = "You set this door hidden."
l.setdoorunhidden = "You set this not hidden."
l.setdoortitle = "You changed this door's title."
l.lockdoor = "You locked the door."
l.unlockdoor = "You unlocked the door."

l.invalid = "That %s does not exists."
l.invalidplayer = "That player does not exists."
l.invalidentity = "Can't find target entity."
l.invalidreason = "You must provide the reaosn."

l.licenseexist = "This license already exists"
l.thishaslicense = "this player already has this license"
l.haslicense = "You already have this license"
l.closertomachine = "You must get closer to the machine."
l.arrestlicense = "You can't grant license to arrested personel."
l.grantlicense = "You granted %s to %s."
l.getgrantlicense = "%s granted %s to you."
l.revokelicense = "You revoked %s from %s."
l.getrevokelicense = "%s revoked %s from you."
l.lockdown = "Mayor declared Lockdown. All Citizens in the street will be punished. Reason: %s"
l.declarelockdown = "Mayor declared Lockdown."
l.finishlockdown = "Mayor declared Lockdown."
l.newjailpos = "You added new Jail Position."
l.setjailpos = "You cleared all Jail Positions and set this position as new Jail Position."

l.broadcast = "(BROADCAST) "
l.ooc = "(OOC) "
l.advert = "(ADVERT) "
l.yell = "(YELL) "
l.looc = "(LOOC) "

l.hudarrest = "Press <ATTACK> to arrest the player."
l.hudarresttarget = "Arrest %s for %s."
l.hudarresttargetback = "Put %s back to the jail."

l.hudunarrest = "Press <ATTACK> to unarrest the player."
l.hudunarresttarget = "Make %s Free."

l.hudsearch = "Press <ATTACK> to search the player."
l.hudsearchtarget = "Search %s's weapons."
l.hudsearchname = "Searching for the Weapons"
l.searchwindow = "Search Result"