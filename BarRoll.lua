--~ Julio Ureta
--~ GAM218
--~ 02/12/2015
--~ Barrel Script

--~ Main data table for the entity
BarRoll =
{
	Properties =
	{
		--~ Calls the model for the object
		fileModel1 = "objects/props/industrial/barrels/barrel_c.cgf",
		fileModel2 = "objects/props/industrial/barrels/barrel_d.cgf",
	},

Editor =
	{
		Icon = "tagpoint.bmp",
		IconOnTop = 1,
	},

--~ State machine implementation. Currently two states between tall/short barrel
States =
	{
		"Tall",
		"Short",
		"Impulsed", -- Impulsed state added
		--~ "Damaged", -- Damaged state added
	},
}

function BarRoll:OnInit()
	self:OnReset();
end

--~ Reset function. Called from other functions in order to keep code
function BarRoll:OnReset()
	if (self.Properties.fileModel1 ~= "") then
		self:LoadObject(0, self.Properties.fileModel1);
	end

	self:PhysicalizeThis() --~ Function call to give the barrel physics
	self:GotoState("Tall") --~ Set initial state on reset
end

--~ Function called when editor changes properties
function BarRoll:OnPropertyChange()
	self:OnReset();
end

--~ Add physics to the barrel.
function BarRoll:PhysicalizeThis()
	local Physics = {
		bRigidBody=1,
		bRigidBodyActive = 0,
		bRigidBodyAfterDeath =1,
		bResting = 1,
		Density = -1,
		Mass = 5
	};
EntityCommon.PhysicalizeRigid( self, 0, Physics, 1 );
end

--~ Makes item usable Object
function BarRoll:IsUsable(user)
	return 2;
end

--~ Returns a message on possible usable object
function BarRoll:GetUsableMessage(index)
	if (self:GetState() == "Tall") then
		return "Tall Barrel. USE barrel to make it Short."

	elseif (self:GetState() == "Short") then
		return "Short Barrel. USE barrel to make it Tall."

	else
		Log("Message Error");
	end
	--~ return "Test Message"; -- default message was: self.Properties.sMessage
end

--~ Reaction on use of object
function BarRoll:OnUsed(userId, index)

	Log("Player used the Barrel")

	--~ Changes the barrel model from tall to short
	if (self:GetState() == "Tall") then
		if (self.Properties.fileModel2 ~= "") then
			self:LoadObject(0, self.Properties.fileModel2);
			self:GotoState("Short")
			self:PhysicalizeThis() --~ Reestablish the physics
		end
	--~ Changes the barrel model from short to tall
	elseif (self:GetState() == "Short") then
		if (self.Properties.fileModel1 ~= "") then
			self:LoadObject(0, self.Properties.fileModel1);
			self:GotoState("Tall")
			self:PhysicalizeThis() --~ Reestablish the physics
		end
	else
		Log("State Machine Error");
	end
end

--~ Reaction when object takes damage
--~ function BarRoll:OnHit(hit)

--~ 	Log("Player damaged the Barrel")

--~ end

--~ Events
function BarRoll:Event_MakeTall()

	--~ Changes the barrel model from short to tall
	if (self.Properties.fileModel1 ~= "") then
		self:LoadObject(0, self.Properties.fileModel1);
		self:GotoState("Tall")
		self:PhysicalizeThis() --~ Reestablish the physics
		BroadcastEvent(self, "MadeTall")
	end
end

function BarRoll:Event_MakeShort()

	--~ Changes the barrel model from tall to short
	if (self.Properties.fileModel2 ~= "") then
		self:LoadObject(0, self.Properties.fileModel2);
		self:GotoState("Short")
		self:PhysicalizeThis() --~ Reestablish the physics
		BroadcastEvent(self, "MadeShort")
	end
end

--~ Event for impulsing the barrel
function BarRoll:Event_TriggerImpulse()

		self:GotoState("Impulsed") -- Changes barrel's state to Impulsed
		BroadcastEvent(self, "TriggeredImpulse") -- Log the impulse

end

--~ Event for damaging the barrel
--~ function BarRoll:Event_DamageBarrel()

--~ 		self:GotoState("Damaged") -- Changes barrel's state to Damaged
--~ 		BroadcastEvent(self, "DamagedBarrel") -- Log the damage

--~ end

--~ Flow Graph
BarRoll.FlowEvents =
{
	Inputs =
	{
		--~ Made-up names for input
		MakeTall = {BarRoll.Event_MakeTall, "bool"},
		MakeShort = {BarRoll.Event_MakeShort, "bool"},
		TriggerImpulse = {BarRoll.Event_TriggerImpulse, "bool"},
		--~ DamagedBarrel = {BarRoll.Event_DamageBarrel, "bool"},

	},

	Outputs =
	{
		--~ Made-up names for output
		MadeTall = "bool",
		MadeShort = "bool",
		TriggeredImpulse = "bool",
		--~ DamagedBarrel = "bool",
	},
}
