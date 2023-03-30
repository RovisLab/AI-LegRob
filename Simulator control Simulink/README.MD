# Simulator control Simulink

## Static Gait:
  
  Robotul se deplaseasa de alungul unei traiectori(o linie dreapta). Logica de coltrol este urmatoarea:
  
  1. se calculeaza eroarea dintre centru corpului si primul punct din traiectorie
  2. cu ajutorul ZMP(zero moment point) se calculeaza care este pozitia picioarelor astfel incat robotul sa ramana stabil(in programul Simulink a fost implementata doar o mica parte din ZMP)
  3. In State Flow a fost implementata structura secventiala de deplasare a picioarelor si a corpului
  4. prin intermediul Kinematici inverse se calculeaza care sunt valorile unghiulare din cuple pe baza pozitilor picioarelor si a corpului

  Simulatorul din Simulink a fost implementat in totalitate in C++


https://user-images.githubusercontent.com/57198584/228916648-34d83e82-d0b7-4379-a967-83cf8b365b7b.mp4



https://user-images.githubusercontent.com/57198584/228918355-bd1c1278-805f-42a9-81ba-16f9397cc136.mp4









