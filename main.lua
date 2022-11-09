--Usage
--Hold down or click left mouse button to draw distance.

local	aimingAt = nil
local	to2D = nil
local playerPosition = nil

local function drawInWorld()
  
	-- Start line screen calculation.
	local refdef = engine.getRefDef()
	local width = refdef.width / 2
	local height = refdef.height - 1

	-- Get aim position each click.
	if(mouse.isDown(0)) then
		aimingAt = player.getCrosshairWorldPosition()
		playerPosition = player.getPosition()
	end
  
to2D = aimingAt:screenPosition()
  
	-- Drawing.
draw.line(playerPosition:screenPosition(), to2D, Vec4:new(0,0,0,255), 2)
draw.circle(playerPosition:screenPosition(), 8, Vec4:new(201, 201, 201,255),4)
draw.circle(to2D, 8, Vec4:new(201, 201, 201,255),4)

  -- Get distance.
local distance = playerPosition:distanceTo(aimingAt)
local stringDistance = string.format("%.2f", distance)

  -- Vector math for middle line text.
local differenceVector = Vec3:new(0, 0, 0)
differenceVector.x = aimingAt.x - playerPosition.x
differenceVector.y = aimingAt.y - playerPosition.y
differenceVector.z = aimingAt.z - playerPosition.z

  -- Text Drawing.
local scaledPos = aimingAt:add(differenceVector:scale(-.5)):screenPosition()
scaledPos.y = scaledPos.y + 10
scaledPos.x = scaledPos.x + 10
draw.text(stringDistance, scaledPos, Vec4:new(0,0,0,255), 18, "Verdana")

end

engine.addEventListener("render", drawInWorld)
