local CurrentIP = "None"
local rs = GetCurrentResourceName()
local version = 2

Citizen.CreateThread(function()
    PerformHttpRequest("https://raw.githubusercontent.com/Spooni-Development/spooni_updates/main/scripts/spooni_vegmod.json", function(err, text, headers)
        local text = json.decode(text)
        Wait(5000)        
        if tonumber(version) == tonumber(text.version) then
            print("^2VERSION: ^4"..rs.."^2 IS UP TO DATE!^0")
        elseif tonumber(version) ~= tonumber(text.version) then 
            print("^8VERSION: ^4"..rs.."^8 THERE IS A NEW VERSION AVAILABLE!^0") 
        end
        CurrentIP = text
    end, 'GET')
end)

-- ^0 = White
-- ^1 = Red
-- ^2 = Green
-- ^3 = Yellow
-- ^4 = Blue
-- ^5 = Light Blue
-- ^6 = Purple
-- ^7 = White
-- ^8 = Dark Red
-- ^9 = Dark Blue