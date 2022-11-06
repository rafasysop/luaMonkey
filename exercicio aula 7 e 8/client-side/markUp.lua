print("---------------------------")
print("Inicio da depuração")
print("---------------------------")

local listPosicoes = {
    [1] = { ['x'] = 132.91, ['y'] = -989.7, ['z'] = 29.36 },
    [2] = { ['x'] = 169.48, ['y'] = -1003.86, ['z'] = 29.35},
    [3] = { ['x'] = 211.19, ['y'] = -1017.45, ['z'] = 29.31},
    [4] = { ['x'] = 224.96, ['y'] = -980.54, ['z'] = 29.3 },
    [5] = { ['x'] = 239.27, ['y'] = -939.34, ['z'] = 29.29},
    [6] = { ['x'] = 263.69, ['y'] = -872.88, ['z'] = 29.17 },
    [7] = { ['x'] = 224.49, ['y'] = -858.74, ['z'] = 30.12 },
    [8] = { ['x'] = 185.85, ['y'] = -844.58, ['z'] = 31.1 }
}

local pos = 1

Citizen.CreateThread(function()
    while true do 
        local timeWaiting = 1000
        local pedPalyer = PlayerPedId()
        local coordsPlayer = GetEntityCoords(pedPalyer)
            local diffDistance = #(vector3(coordsPlayer[1], coordsPlayer[2], coordsPlayer[3]) - vector3(listPosicoes[pos].x,listPosicoes[pos].y,listPosicoes[pos].z))
            if diffDistance < 80.0 then 
                timeWaiting = 5
                DrawMarker(21,listPosicoes[pos].x,listPosicoes[pos].y,listPosicoes[pos].z,0,0,0,0,0,0,2.00,2.00,2.00,255,6,6,100,0,0,0,1)

                if diffDistance < 2.0 then 
                    drawTxt("PRESSIONE  ~g~E~w~  PARA SELECIONAR", 4, 0.5, 0.80, 0.50, 255, 255, 255,180)
                    SetNuiFocus(false,false)
                    if IsControlJustPressed(0,38) then 
                        if pos == #listPosicoes then 
                            pos = 1
                        else 
                            pos = pos + 1 
                            TriggerEvent("sounds:source","cash",1)
                        end
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

print("---------------------------")
print("Fim da depuração")
print("---------------------------")
