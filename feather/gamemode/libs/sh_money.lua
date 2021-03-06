// FINISHED
local playerMeta = FindMetaTable("Player")

if (SERVER) then
	function playerMeta:GiveMoney(amount)
		amount = tonumber(amount)
		self:SetLocalVar("money", self:GetLocalVar("money", 0) + tonumber(amount or 0))
	end

	function playerMeta:TakeMoney(amount)
		amount = tonumber(amount)
		self:GiveMoney(-amount)
	end

	function playerMeta:SetMoney(amount)
		amount = tonumber(amount)
		self:SetLocalVar("money", amount)
	end

	function playerMeta:PayMoney(amount, fail, succ)
		amount = tonumber(amount)
		if self:GetMoney() >= amount then
			self:TakeMoney(amount)
			if succ then
				self:notify(succ)
			end
			return true
		end
		
		self:notify(fail or GetLang"cantafford")
		return false
	end

	function GM:CreateMoney(position, angles, amt)
		local money = ents.Create("feather_money")
		money:SetMoney(amt or 0)
		money:SetPos(position or Vector(0, 0, 0))
		money:SetAngles(angles or Angle(0, 0, 0))
		money:Spawn()
		return money
	end

	function GM:MoneyEntityCreated(self)
		if (feather.config.get("moneyModel"):lower() == "models/props/cs_assault/money.mdl") then
			if self:GetDTInt(0) <= 100 then
				self:SetModel("models/props/cs_assault/Dollar.mdl")
			end
		end
	end

	function GM:MoneyEntityChanged(self)
		if (feather.config.get("moneyModel"):lower() == "models/props/cs_assault/money.mdl") then
			if self:GetDTInt(0) <= 100 then
				self:SetModel("models/props/cs_assault/Dollar.mdl")
			end
		end
	end
end

function playerMeta:GetMoney()
	return self:GetLocalVar("money", 0)
end

function playerMeta:CanAfford(amt)
	return (amt > 0) and (self:GetMoney() >= amt)
end

GM:RegisterCommand({
	desc = "This command allows you to give money to someone.\nIf you write players name after the amount, you can give your money to specific player around you.",
	syntax = "<Amount to give> [Target Player]",
	category = "Market and Money",
	onRun = function(client, arguments)
		local ply = arguments[2]
		local amt = math.Clamp(tonumber(arguments[1]) or 0, 0, math.huge)

		local target
		if ply then
			target = FindPlayer(ply)
		else
			local trace = client:GetEyeTraceNoCursor()
			target = trace.Entity
		end

		if !target or !target:IsValid() then
			client:notify(GetLang("invalid", "player"), 4)
			return
		end

		if target == client then
			client:notify(GetLang"cantdo", 4)
			return
		end

		if target:GetPos():Distance(client:GetPos()) <= 128 then
			if !client:CanAfford(amt) then
				client:notify(GetLang"cantafford")
				return
			end

			if amt >= 5 then
				client:notify(GetLang("givemoney", MoneyFormat(amt), target:Name()))
				client:GiveMoney(-amt)
				target:GiveMoney(amt)
			else
				client:notify(GetLang("biggerthan", 5))
			end
		end
	end
}, "give")

GM:RegisterCommand({
	desc = "This command allows you to drop money on the ground.\nIf you provide second number, you'll throw the money away.",
	syntax = "<Amount to drop> [Force to Throw]",
	category = "Market and Money",
	onRun = function(client, arguments)
		local amt = math.Clamp(tonumber(arguments[1]) or 0, 0, math.huge)
		local force = math.Clamp(tonumber(arguments[2]) or 0, 0, 500)

		if !client:CanAfford(amt) then
			client:notify(GetLang"cantafford")
			return
		end

		if amt >= 5 then
			local data = {}
				data.start = client:GetShootPos()
				data.endpos = data.start + client:GetAimVector()*64
				data.filter = client
			local trace = util.TraceLine(data)
			local position = trace.HitPos

			local money = GAMEMODE:CreateMoney(position, Angle(0, 0, 0), amt)
			client:GiveMoney(-amt)

			if force and force > 0 then
				money:SetPos(client:GetShootPos() + client:GetAimVector() * 30)
				money:GetPhysicsObject():SetVelocity(client:GetAimVector() * force)
			end
		else
			client:notify(GetLang("biggerthan", 5))
		end
	end
}, "dropmoney")