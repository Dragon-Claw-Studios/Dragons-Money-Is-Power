local item = ScriptManager.instance:getItem("Money")    
if item then 
    item:DoParam("Weight	=	-0.0002")
end

function Recipe.OnCreate.SearchForMoney(items, result, player)
    local luck = ZombRand(0,55)+1
    local islucky = 0
    if player:HasTrait("Lucky") then
        islucky = 1
        luck = luck + 4
        if luck > 55 then
            luck = 55
        end
    end
    if luck == 55 then
        local jackpot = ZombRand(25,75)+1
        player:Say("Awesome! $"..tostring(jackpot).."!")
        while jackpot > 0 do
            player:getInventory():AddItem("Money")
            jackpot = jackpot - 1
        end
    end
    if luck <= 10 then
        player:Say("There's nothing here.")
    end
    if luck <= 30 and luck >= 11 then
        local getMoney = ZombRand(1,2)+1 + ZombRand((islucky),(islucky*2))+1
        player:Say("$"..tostring(getMoney)..".")
        while getMoney > 0 do
            player:getInventory():AddItem("Money")
            getMoney = getMoney - 1
        end
    end
    if luck <= 45 and luck >= 31 then
        local getMoney = ZombRand(4,8)+1 + ZombRand((islucky*2),(islucky*4))+1
        player:Say("$"..tostring(getMoney)..", cool.")
        while getMoney > 0 do
            player:getInventory():AddItem("Money")
            getMoney = getMoney - 1
        end
    end
    if luck <= 50  and luck >= 46 then
        local getMoney = ZombRand(10,15)+1 + ZombRand((islucky*4),(islucky*8))+1
        player:Say("$"..tostring(getMoney)..", nice.")
        while getMoney > 0 do
            player:getInventory():AddItem("Money")
            getMoney = getMoney - 1
        end
    end
    if luck <= 54  and luck >= 51 then
        local getMoney = ZombRand(18,25)+1 + ZombRand((islucky*8),(islucky*16))+1
        player:Say("$"..tostring(getMoney).." sweet!")
        while getMoney > 0 do
            player:getInventory():AddItem("Money")
            getMoney = getMoney - 1
        end
    end
end
    