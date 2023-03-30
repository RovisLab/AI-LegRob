# Simulator control Simulink

## Static Gait:
  
  Robotul se deplaseasa de alungul unei traiectorii(o linie dreapta). Logica de coltrol este urmatoarea:
  
  1. se calculeaza eroarea dintre centru corpului si primul punct din traiectorie
  2. cu ajutorul ZMP(zero moment point) se calculeaza care este pozitia picioarelor astfel incat robotul sa ramana stabil(in programul Simulink a fost implementata doar o mica parte din ZMP)
  3. In State Flow a fost implementata structura secventiala de deplasare a picioarelor si a corpului
  4. prin intermediul Kinematici inverse se calculeaza care sunt valorile unghiulare din cuple pe baza pozitilor picioarelor si a corpului

  Simulatorul din Simulink a fost implementat in totalitate in C++
  
https://user-images.githubusercontent.com/57198584/228913159-8651c07b-aa2b-4663-9f34-0bbcca39fdd5.mp4


https://user-images.githubusercontent.com/57198584/228915002-56c92ba8-f171-468c-aa05-1577b0c1acf7.mp4

