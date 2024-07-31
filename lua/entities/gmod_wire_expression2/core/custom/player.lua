__e2setcost(200)
e2function void entity:setWeaponColor(vector rgb)
	if not IsValid(this)  then return end
	if not this:IsPlayer() then return end
	if not isOwner(self, this) then return end

	local color = Vector(
		isNan(rgb[1]) and 0 or math.Clamp(rgb[1], 0, 255) / 255,
		isNan(rgb[2]) and 0 or math.Clamp(rgb[2], 0, 255) / 255,
		isNan(rgb[3]) and 0 or math.Clamp(rgb[3], 0, 255) / 255
	)

	this:SetWeaponColor(Vec)
end

e2function void entity:setPlayerColor(vector rgb)
	if not IsValid(this) then return end
	if not this:IsPlayer() then return end
	if not isOwner(self, this) then return end

	local color = Vector(
		isNan(rgb[1]) and 0 or math.Clamp(rgb[1], 0, 255) / 255,
		isNan(rgb[2]) and 0 or math.Clamp(rgb[2], 0, 255) / 255,
		isNan(rgb[3]) and 0 or math.Clamp(rgb[3], 0, 255) / 255
	)	

	this:SetPlayerColor(color)
end

e2function vector entity:getWeaponColor()
	if not IsValid(this) then return end
	if not this:IsPlayer() then return end

	local color = this:GetWeaponColor() * 255

	return {math.floor(color[1]), math.floor(color[2]), math.floor(color[3])}
end

e2function vector entity:getPlayerColor()
	if not IsValid(this)  then return end
	if not this:IsPlayer() then return end

	local color = this:GetPlayerColor() * 255

	return {math.floor(color[1]), math.floor(color[2]), math.floor(color[3])}
end

__e2setcost(20)

e2function void entity:playerFreeze()
	if not IsValid(this) then return end
	if not isOwner(self, this) then return end
	if not this:IsPlayer() then return end

	this:Lock()
end

e2function void entity:playerUnFreeze()
	if not IsValid(this) then return end
	if not isOwner(self, this) then return end
	if not this:IsPlayer() then return end

	this:UnLock()
end

e2function number entity:hasGodMode()
	if not IsValid(this) then return 0 end
	if not this:IsPlayer() then return 0 end

	return this:HasGodMode() and 1 or 0
end

e2function void entity:playerRemove()
	if not self.player:IsSuperAdmin() then return end
	if not IsValid(this) then return end
	if not this:IsPlayer() then return end

	this:Remove()
end

e2function void entity:playerSetAlpha(alpha)
	if not IsValid(this) then return end
	if not isOwner(self, this) then return end
	if not this:IsPlayer() then return end

	this:SetColor(ColorAlpha(this:GetColor(), math.Clamp(alpha, 0, 255)))
end

e2function void entity:playerNoclip(status)
	if not hasAccess(self) then return end
	if not IsValid(this) then return end
	if not isOwner(self, this) then return end
	if not this:IsPlayer() then return end

	if tobool(status) then
		this:SetMoveType( MOVETYPE_NOCLIP )
	else
		this:SetMoveType( MOVETYPE_WALK )
	end
end

e2function void entity:playerNoclipToggle()
	if not hasAccess(self) then return end
	if not IsValid(this) then return end
	if not isOwner(self, this) then return end
	if not this:IsPlayer() then return end

	if this:GetMoveType() ~= MOVETYPE_NOCLIP then
		this:SetMoveType( MOVETYPE_NOCLIP )
	else
		this:SetMoveType( MOVETYPE_WALK )
	end
end

e2function number entity:playerIsRagdoll()
	if not IsValid(this) then return 0 end
	if not this:IsPlayer() then return 0 end

	return IsValid(this.ragdoll) and 1 or 0
end

__e2setcost(100)

e2function void entity:playerModel(string model)
	if not IsValid(this) then return end
	if not isOwner(self, this) then return end
	if not this:IsPlayer() then return end

	local modelname = player_manager.TranslatePlayerModel(model)

	util.PrecacheModel(modelname)
	this:SetModel(modelname)
end

e2function vector entity:playerBonePos(Index)
	if not IsValid(this) then return {0,0,0} end
	if not this:IsPlayer() then return {0,0,0} end

	local bonepos, boneang = this:GetBonePosition(this:TranslatePhysBoneToBone(Index))

	if bonepos == nil then
		return {0,0,0}
	else
		return bonepos
	end
end

e2function angle entity:playerBoneAng(Index)
	if not IsValid(this) then return {0,0,0} end
	if not this:IsPlayer() then return {0,0,0} end

	local bonepos, boneang = this:GetBonePosition(this:TranslatePhysBoneToBone(Index))

	if boneang == nil then
		return {0,0,0}
	else
		return {boneang.Yaw,boneang.Pitch,boneang.Roll}
	end
end

e2function vector entity:playerBonePos(string boneName)
	if not IsValid(this) then return {0,0,0} end
	if not this:IsPlayer() then return {0,0,0} end

	local bonepos, boneang = this:GetBonePosition(this:LookupBone(boneName))

	if bonepos == nil then
		return {0,0,0}
	else
		return bonepos
	end
end

e2function angle entity:playerBoneAng(string boneName)
	if not IsValid(this) then return {0,0,0} end
	if not this:IsPlayer() then return {0,0,0} end

	local bonepos, boneang = this:GetBonePosition(this:LookupBone(boneName))

	if boneang == nil then 
		return {0,0,0}
	else 
		return {boneang.Yaw,boneang.Pitch,boneang.Roll} 
	end
end

e2function number entity:lookUpBone(string boneName)
	if not IsValid(this) then return -1 end
	return this:LookupBone(boneName) or -1
end

e2function void entity:playerSetBoneAng(Index, angle ang)
	if !IsValid(this) then return end
	if !this:IsPlayer() then return end
	if !isOwner(self, this) then end
	if isNan(ang[1]) or isNan(ang[2]) or isNan(ang[3]) then return end

	this:ManipulateBoneAngles(Index, Angle(ang[1], ang[2], ang[3]))
end

e2function void entity:playerSetBoneAng(string boneName, angle ang)
	if not IsValid(this) then return end
	if not this:IsPlayer() then return end
	if not isOwner(self, this) then end
	if isNan(ang[1]) or isNan(ang[2]) or isNan(ang[3]) then return end

	this:ManipulateBoneAngles(this:LookupBone(boneName), Angle(ang[1],ang[2],ang[3]))
end

e2function void playerSetBoneAng(Index, angle ang)
	self.player:ManipulateBoneAngles(Index, Angle(ang[1], ang[2], ang[3]))
end

e2function void playerSetBoneAng(string boneName, angle ang)
	local selfply = self.player

	selfply:ManipulateBoneAngles(selfply:LookupBone(boneName), Angle(ang[1], ang[2], ang[3]))
end

__e2setcost(15000)

e2function entity entity:playerRagdoll()
	if not IsValid(this) then return end
	if not isOwner(self, this) then return end
	if not this:IsPlayer() then return end
	if this:Health() <= 0 then return end
	if this:InVehicle() then this:ExitVehicle()	end

	if not IsValid(this.ragdoll) then
		local ragdoll = ents.Create("prop_ragdoll")

		ragdoll.ragdolledPly = this
		ragdoll:SetPos( this:GetPos() )
		ragdoll:SetAngles( this:GetAngles() )
		ragdoll:SetModel( this:GetModel() )
		ragdoll:Spawn()
		ragdoll:Activate()
		this:SetParent( ragdoll )

		local velocity = this:GetVelocity()

		for i = 1, ragdoll:GetPhysicsObjectCount() - 1 do
			local phys_obj = ragdoll:GetPhysicsObjectNum(i)

			if phys_obj then
				phys_obj:SetVelocity(velocity)
			else
				break
			end
		end

		this:Spectate( OBS_MODE_CHASE )
		this:SpectateEntity( ragdoll )
		this:StripWeapons()

		this.ragdoll = ragdoll

		return ragdoll
	else
		this:SetParent()
		this:UnSpectate()

		local ragdoll = this.ragdoll
		this.ragdoll = nil

		if IsValid(ragdoll) then
			local pos = ragdoll:GetPos()
			pos.z = pos.z + 10

			this:Spawn()
			this:SetPos(pos)
			this:SetVelocity(ragdoll:GetVelocity())

			local yaw = ragdoll:GetAngles().yaw
			this:SetAngles(Angle( 0, yaw, 0 ))

			ragdoll:Remove()
		end

		return self.player
	end
end

__e2setcost(20)

e2function void entity:plyRunSpeed(number speed)
	if not IsValid(this)  then return end
	if not isOwner(self, this)  then return end
	if not this:IsPlayer() then return end

	speed = math.Clamp(speed, 0, 90000)
	if speed > 0 then
		this:SetRunSpeed(speed)
	else
		this:SetRunSpeed(500)
	end
end

e2function void entity:plyWalkSpeed(number speed)
	if not IsValid(this)  then return end
	if not isOwner(self, this)  then return end
	if not this:IsPlayer() then return end

	speed = math.Clamp(speed, 0, 90000)
	if speed > 0 then
		this:SetWalkSpeed(speed)
	else
		this:SetWalkSpeed(250)
	end
end

e2function void entity:plyJumpPower(number power)
	if not IsValid(this)  then return end
	if not isOwner(self, this)  then return end
	if not this:IsPlayer() then return end

	power = math.Clamp(power, 0, 90000)
	if power > 0 then
		this:SetJumpPower(power)
	else
		this:SetJumpPower(160)
	end
end

e2function void entity:plyCrouchWalkSpeed(number speed)
	if not IsValid(this)  then return end
	if not isOwner(self, this)  then return end
	if not this:IsPlayer() then return end

	speed = math.Clamp(speed, 0.01, 10)
	this:SetCrouchedWalkSpeed(speed)
end

e2function number entity:plyGetRunSpeed()
	if not IsValid(this) then return end
	if not this:IsPlayer() then return end

	return this:GetRunSpeed()
end

e2function number entity:plyGetWalkSpeed()
	if not IsValid(this) then return end
	if not this:IsPlayer() then return end

	return this:GetWalkSpeed()
end

e2function number entity:plyGetMaxSpeed()
	if not IsValid(this) then return end
	if not this:IsPlayer() then return end

	return this:GetMaxSpeed()
end

e2function number entity:plyGetJumpPower()
	if not IsValid(this) then return end
	if not this:IsPlayer() then return end

	return this:GetJumpPower()
end
