function initialize()

io.write("Machen " ..config.VERSION_MAJOR .. "." ..config.VERSION_MINOR .. "\n")

io.write("Simulando Ejemplo de CdP \n")

config.setLogLevel("info")

--Aqui definimos algunas constantes: 
--en total son 7 meses de 30 dias, es decir 210 dias de simulacion, medido en horas 24*210
--6 iteraciones en cada hora
--la semilla aleatoria deberia cambiarse cada vez
config.setvars({
	starttime = 0.0,
	endtime = 24 * 30 * 7,
	iters = 6 * 24 * 30 * 7,
	randomseed = 9999,
})
--io.write(" Tiempo total (horas):" ..endtime .. " Iteraciones:" ..iters .. "\n")

--Aqui definimos los layers                             

data.createLayer("daily",
{
	x0 = 0.0,
	x1 = 10000.0,
	y0 = 0.0,
	y1 = 10000.0,
	w = 700,
	h = 700,
	default = 0,
})

data.setLayerUpdate("daily", "dayupdate")



data.createLayer("manure",
{
	x0 = 0.0,
	x1 = 10000.0,
	y0 = 0.0,
	y1 = 10000.0,
	w = 700,
	h = 700,
	default = 0,
	layers = 1,
})

--data.setLayerUpdate("manure", "manureupdate")

data.loadLayer("area", "1.png",
{
	x0 = 0.0,
	x1 = 10000.0,
	y0 = 0.0,
	y1 = 10000.0,
})

data.setLayerUpdate("area", "areaupdate")


--Aqui definimos los agentes (tipo y numero de agentes)
config.addAgent("cow", 10000)
--config.addAgent("cow", 6300)
--config.addAgent("sheep", 10200)

end

function startIteration(num)
end

function endIteration(num)
    if num % 300 == 0 then
        io.write("Manure saved, iteration " .. num .. "\n");
        --http://gifmaker.me/
        --raster.manure:save("/gpfs/res_projects/uc19/cdp/export/output"..num..".png")
        raster.manure:save("export/output"..num..".png");
    end
end

function endSimulation()
io.write("End Simulation\n")
end
