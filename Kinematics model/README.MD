# Kinematics model

## Kinematica inversa:

  1. Problema de Kinematica inversa este rezolvata trigonometric.
  2. Metoda implemetata permite controlul picioarelor si a corpului(se poate modifica orientarea si translatia acestuia).
  3. In cazul in care solutia este NaN sau inf. inseamna ca punctul care se dorete sa fie accesat nu este in sptiul de lucru al robotului.
  4. Aceasta problema mai poate fi imbunatatita prin eliminarea functiilor arcsin, arctg, etc.
  5. Nu am atasat rezolvare deoarece trebuie sa o rescriu.

https://user-images.githubusercontent.com/57198584/228896209-083498dc-f889-4cc0-9bc6-8e309b814f82.mp4

## Center of Mass:

  1. Centru de masa al robotului este variabil in functie de configuratia acestuia.
  2. In programul "com.m" se calculaza centru de masa total al robotului pe baza pozitilor centrelor de masa ale fiecarui link in parte.
                  ![image](https://user-images.githubusercontent.com/57198584/228894422-2b0a7a57-1557-4281-af61-15a92b51e419.png)
  3. Asterixul de culoare albastra reprezinta centru de masa total ar robotului   

                    ![image](https://user-images.githubusercontent.com/57198584/228898608-6847385b-01c3-4da1-8e37-820bec1278cd.png)



