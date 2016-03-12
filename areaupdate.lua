function Raster:update( delta )

   if not self.month then
       self.month = 1
   end

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

      -- Aproximacion: abril-octubre todos con una duracion de 30 dias
      if (self.day % 30 == 0) then
          self.month = self.month + 1;
          io.write( 'Cambio de mes: ' .. self.month .. '\n')
          self.load( self.month .. ".png")
      end
   end


end
