local lastX = -1;
local lastY = -1;

local moneyEquipmentSquares = {}

---------------------------------------- Common ----------------------------------------

-- Check if player position changed with accuracy of 1/100 of a square
-- Need this cause game spam OnTest events like hell
function MoneyRecipes_IsPlayerMoved(player)
	local newX = math.floor(player:getX()*100);
	local newY = math.floor(player:getY()*100);
	if newX == lastX and newY == lastY then
		return false;
	end--if
	lastX = newX;
	lastY = newY;
	return true;
end--function

-- Look if there is GroupName object near Square
function MoneyRecipes_LookForNearEquipment(square, equipment, custom)
	local px = square:getX();
	local py = square:getY();
	local pz = square:getZ();
	for y = py-1, py+1 do
		for x = px-1, px+1 do
			local squareTest = getCell():getGridSquare(x, y, pz);
			if squareTest then
				for i = 0, squareTest:getObjects():size()-1 do
					local sp = squareTest:getObjects():get(i):getSprite():getName();
					if equipment and sp == equipment then
						return squareTest;
					end--if
				end--for
			end--if
		end--for
	end--for
	return nil;
end--function

-- Check for player movement and look for given equipment
function MoneyRecipes_IsNearMoneyEquip(equipment)
	local player = getPlayer();
	moneyEquipmentSquares.SkipCheck = not(MoneyRecipes_IsPlayerMoved(player)) and moneyEquipmentSquares.LastEquipment == equipment;
	if moneyEquipmentSquares.SkipCheck then
		return moneyEquipmentSquares[equipment];
	end--if
	moneyEquipmentSquares.LastEquipment = equipment;
	moneyEquipmentSquares[equipment] = MoneyRecipes_LookForNearEquipment(player:getCurrentSquare(),equipment, nil);
	return moneyEquipmentSquares[equipment];
end--function



-- sprite names and gid
-- location_business_bank_01_64		gid 38064
-- location_business_bank_01_65		gid 38065
-- location_business_bank_01_66		gid 38066
-- location_business_bank_01_67		gid 38067

-- Checks if there is ATM nearby using the spritename
function MoneyRecipes_IsNearATM64(sourceItem, result)
	if MoneyRecipes_IsNearMoneyEquip("location_business_bank_01_64") ~= nil then
		return true;
	elseif MoneyRecipes_IsNearMoneyEquip("location_business_bank_01_65") ~= nil then
		return true;
	elseif MoneyRecipes_IsNearMoneyEquip("location_business_bank_01_66") ~= nil then
		return true;
	elseif MoneyRecipes_IsNearMoneyEquip("location_business_bank_01_67") ~= nil then
		return true;
	end
end--function


-- Pull money from ATM
function Recipe.OnCreate.ATMWithdraw(items, result, player)
    local luck = ZombRand(0,100)+1
    local islucky = 0
    if player:HasTrait("Lucky") then
        islucky = 1
        luck = luck + 10
        if luck > 100 then
            luck = 110
        end
    end
    if luck >= 101 then
        local jackpot = ZombRand(250,500)+1
        player:Say("Awesome! $"..tostring(jackpot).."!")
        while jackpot > 0 do
            player:getInventory():AddItem("Money")
            jackpot = jackpot - 1
        end
    end
    if luck <= 10 then
        local getMoney = ZombRand(1,15)+1 + ZombRand((islucky),(islucky*4))+1
        player:Say("$"..tostring(getMoney)..", better than nothing...")
        while getMoney > 0 do
            player:getInventory():AddItem("Money")
            getMoney = getMoney - 1
        end
    end
    if luck <= 26 and luck >= 11 then
        local getMoney = ZombRand(10,50)+1 + ZombRand((islucky*2),(islucky*8))+1
        player:Say("$"..tostring(getMoney)..", neat.")
        while getMoney > 0 do
            player:getInventory():AddItem("Money")
            getMoney = getMoney - 1
        end
    end
    if luck <= 54 and luck >= 27 then
        local getMoney = ZombRand(40,100)+1 + ZombRand((islucky*4),(islucky*16))+1
        player:Say("$"..tostring(getMoney)..", cool.")
        while getMoney > 0 do
            player:getInventory():AddItem("Money")
            getMoney = getMoney - 1
        end
    end
    if luck <= 80  and luck >= 55 then
        local getMoney = ZombRand(80,160)+1 + ZombRand((islucky*8),(islucky*32))+1
        player:Say("$"..tostring(getMoney)..", nice.")
        while getMoney > 0 do
            player:getInventory():AddItem("Money")
            getMoney = getMoney - 1
        end
    end
    if luck <= 100  and luck >= 81 then
        local getMoney = ZombRand(140,300)+1 + ZombRand((islucky*16),(islucky*64))+1
        player:Say("$"..tostring(getMoney).." sweet!")
        while getMoney > 0 do
            player:getInventory():AddItem("Money")
            getMoney = getMoney - 1
        end
    end
end