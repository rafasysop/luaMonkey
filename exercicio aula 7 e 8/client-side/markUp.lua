print("---------------------------")
print("Inicio da depuração")
print("---------------------------")

local listPosicoes = {
    [1] = { ['x'] = 160.67, ['y'] = -1029.48, ['z'] = 29.34},
    [2] = { ['x'] = 239.92, ['y'] = -1007.0, ['z'] = 28.84},
    [3] = { ['x'] = 279.75, ['y'] = -881.02, ['z'] = 28.73 },
    [4] = { ['x'] = 230.69, ['y'] = -833.8, ['z'] = 29.75},
    [5] = { ['x'] = 152.79, ['y'] = -855.39, ['z'] = 30.4 },
    [6] = { ['x'] = 111.33, ['y'] = -968.42, ['z'] = 28.96 },
    [7] = { ['x'] = 123.26, ['y'] = -992.85, ['z'] = 28.82 }
}

local pos = 1
local inService = false
local blips = nil

Citizen.CreateThread(function()
    while true do
        local timeWaiting = 1000
        local pedPalyer = PlayerPedId()
        local coordsPlayer = GetEntityCoords(pedPalyer)
        local diffDistance = #(vector3(coordsPlayer[1], coordsPlayer[2], coordsPlayer[3]) - vector3(132.91,-989.7,29.36))
        if diffDistance < 20.0 then
            timeWaiting = 5
            DrawMarker(3,132.91,-989.7,29.36,0,0,0,0,0,0,2.00,2.00,2.00,255,6,6,100,0,0,0,1)
            if diffDistance < 2.0 then 
                if inService then
                    drawTxt("PRESSIONE  ~g~E~w~ PARA SAIR DO ~r~SERVIÇO", 4, 0.5, 0.7, 0.8, 250, 250, 250,180)
                    if IsControlJustPressed(0,38) then 
                        if blips then 
                            RemoveBlip(blips)
                        end
                        inService = false
                    end
                else
                    drawTxt("PRESSIONE  ~g~E~w~ PARA ENTRAR EM ~r~SERVIÇO", 4, 0.5, 0.7, 0.8, 250, 250, 250,180)
                    if IsControlJustPressed(0,38) then 
                        blipCreating(listPosicoes[1].x,listPosicoes[1].y,listPosicoes[1].z)
                        inService = true
                    end
                end
            end
        end
        Wait(timeWaiting)
    end
end)

Citizen.CreateThread(function()
    while true do
        local timeWaiting = 1000
            if inService then
                timeWaiting = 5
                drawTxt("VOCÊ ESTÁ EM ~r~SERVIÇO", 4, 0.05, 0.2, 0.4, 0, 255, 0,200)
            end
        Wait(timeWaiting)
    end
end)

Citizen.CreateThread(function()
    while true do 
        local timeWaiting = 1000
        local pedPalyer = PlayerPedId()
        local coordsPlayer = GetEntityCoords(pedPalyer)
        local diffDistance = #(vector3(coordsPlayer[1], coordsPlayer[2], coordsPlayer[3]) - vector3(listPosicoes[pos].x,listPosicoes[pos].y,listPosicoes[pos].z))
        if inService then
            if diffDistance < 80.0 then 
                timeWaiting = 5
                DrawMarker(21,listPosicoes[pos].x,listPosicoes[pos].y,listPosicoes[pos].z,0,0,0,0,0,0,2.00,2.00,2.00,255,6,6,100,0,0,0,1)

                if diffDistance < 2.0 then
                    if pos == #listPosicoes then 
                        pos = 1
                        TriggerEvent("sounds:source","deathcop",1)
                    else 
                        pos = pos + 1 
                        TriggerEvent("sounds:source","cash",1)
                    end
                    if blips then 
                        RemoveBlip(blips)
                    end
                    blipCreating(listPosicoes[pos].x,listPosicoes[pos].y,listPosicoes[pos].z)
                end
            end
        end
        Wait(timeWaiting)
    end
end)

function drawTxt(text, font, x, y, scale, r, g, b, a)
    SetTextFont(font)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextOutline()
    SetTextCentre(1)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

function blipCreating(x,y,z)
    blips = AddBlipForCoord(x,y,z)
    SetBlipSprite(blips, 127)
    SetBlipColour(blips, 83)
    SetBlipScale(blips, 1.0)
    SetBlipAsShortRange(blips, false)
    SetBlipRoute(blips, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Destino")
    EndTextCommandSetBlipName(blips)
end

print("---------------------------")
print("Fim da depuração")
print("---------------------------")
