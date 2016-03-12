function Raster:update( delta )
   if not self.day then
      self.day = 1
   end

   if self.hour then
      self.hour = self.hour + delta
   else
      self.hour = delta
   end

   if self.hour >= 24 then
      self.day = self.day + 1
      self.hour = self.hour - 24
   end


   self:setpixel( 0, 0, 0, self.hour )
   -- self:setpixel( 1, i, j, self.day )

--   io.write( "DayUpdate Day " .. self.day .. " hour " .. self.hour .. "\n" )
end
