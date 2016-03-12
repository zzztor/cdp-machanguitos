function Agent:init()
    self.stable = math.random(10);

    if (self.stable == 1) then
        self.x = 4229;
        self.y = 2013;
    end
    if (self.stable == 2) then
        self.x = 4520;
        self.y = 1980;
    end
    if (self.stable == 3) then
        self.x = 5757;
        self.y = 1214;
    end
    if (self.stable == 4) then
        self.x = 6414;
        self.y = 1657;
    end
    if (self.stable == 5) then
        self.x = 6586;
        self.y = 2757;
    end
    if (self.stable == 6) then
        self.x = 8929;
        self.y = 5400;
    end
    if (self.stable == 7) then
        self.x = 5928;
        self.y = 7985;
    end
    if (self.stable == 8) then
        self.x = 3786;
        self.y = 4200;
    end
    if (self.stable == 9) then
        self.x = 3042;
        self.y = 6571;
    end
    if (self.stable == 10) then
        self.x = 1443;
        self.y = 5157;
    end
    self.x = self.x + math.random(5);
    self.y = self.y + math.random(5);

    self.changeDir = true;
    self.counterDir = 0;

--usually cows deposit around 64 kg/day of manure, so in each step around 1kg
    self.grassToManure = 1.0;
    io.write( "Agent init " .. self.grassToManure .. " kg manure per step \n" )
    self.cowLaziness = 0.9;
    io.write( "Agent init " .. self.cowLaziness .. " cow laziness \n" )
end

function Agent:update(delta)

--    io.write( "Agent:update " .. delta .. " delta time in hours \n" )

    local rstDaily = raster.daily;
    local hour = rstDaily:get(0, 0, 0);

--    io.write( "Agent:update " .. hour .. " hour \n" )

--assume cows are active from 8 to 20h (half day)
--usually cows are lazy, include a laziness factor (0.5)
    if (hour > 8 and hour < 20) then
        local movementPercent = math.random();
--        io.write( "Agent:update " .. hour .. " hour " ..movementPercent .. " movementPercent \n" )
        if (movementPercent > self.cowLaziness) then
--            io.write( "Agent:update  movementPercent>self.cowLaziness go into Gis \n" )
            self:checkGis(delta);
        end
    end

end

function Agent:checkGis(delta)
    if self.changeDir == true then
--  cows move randomly but are attracted towards their favourite area (510,320)
        local favouriteX = 510;
        local favouriteY = 320;
--      increase prob cow goes in the direction towards favourite area
        local randX = math.random();
        if (self.x<favouriteX) then
           randX=randX+0.25;
        end
        local randY = math.random();
        if (self.y<favouriteY) then
           randY=randY+0.25;
        end
        if (randX >= 0.5) then
            self.dirX = 1;
        else
            self.dirX = -1;
        end
        if (randY >= 0.5) then
            self.dirY = 1;
        else
            self.dirY = -1;
        end
        self.changeDir = false;
    else
        self.counterDir = self.counterDir + 1;
        if ( self.counterDir > 5+math.random()*10 ) then
            self.counterDir = 0;
            self.changeDir = true;
        end
    end

    -- 5m./minute == 50m./10 minutes
    self.dx = self.dirX*((50.0)*delta);
    self.dy = self.dirY*((50.0)*delta);
--    io.write( "Agent:checkGIS dx " .. self.dx .. " dy " .. self.dy .. "\n" )

    tempX = self.x + self.dx;
    tempY = self.y + self.dy;
    local rstArea = raster.area;
    local area = rstArea:get( 0, tempX, tempY);
--    io.write( "Agent:checkGIS x " .. tempX .. " y " .. tempY .. " area " .. area .. "\n" )
    if ( area > 0 and tempX < 10000 and tempX >0 and tempY < 10000 and tempY >0 )then
        self.x = tempX;
        self.y = tempY;
--        io.write( "Agent:checkGIS " .. delta .. " delta, now into depositManure \n" )
        self:depositManure(delta);
    end
end

function Agent:depositManure(delta)
    local rstManure = raster.manure;
    local inc = self.grassToManure ;
--    io.write( "Agent:depositManure " .. inc .. " increment \n" )
    rstManure:increment( 0, self.x, self.y, inc );
end
