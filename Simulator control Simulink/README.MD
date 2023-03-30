# Simulator control Simulink

## Static Gait:
  
  Robotul se deplaseasa de alungul unei traiectorii(o linie dreapta). Logica de coltrol este urmatoarea:
  
  1. se calculeaza eroarea dintre centru corpului si primul punct din traiectorie
  2. cu ajutorul ZMP(zero moment point) se calculeaza care este pozitia picioarelor astfel incat robotul sa ramana stabil(in programul Simulink a fost implementata doar o mica parte din ZMP)
  3. In State Flow a fost implementata structura secventiala de deplasare a picioarelor
  4. Inainte ca robotul sa faca un pas aceta isi deplseaza centru corpului(in viitor o sa fie centrul de masa) in  

