# Kinematics model

## Inverse kinematics:

1. The Inverse Kinematics problem is solved trigonometrically.
2. The implemented method allows control of the legs and the body (its orientation and translation can be changed).
3. If the solution is NaN or less. it means that the desired point is not in the robot's working space.

https://user-images.githubusercontent.com/57198584/228921293-8061b913-397c-4f70-af76-c269255ac56c.mp4

## Trajectory Planning with initial and final null velocity and acceleration:

## Center of Mass:

1. The center of mass of the robot is variable depending on its configuration.
2. In the "com.m" program, the total center of mass of the robot is calculated based on the positions of the centers of mass of each individual link.
![image](https://user-images.githubusercontent.com/57198584/228894422-2b0a7a57-1557-4281-af61-15a92b51e419.png)  

![image](https://user-images.githubusercontent.com/57198584/228899073-139a489f-bd7e-4807-a819-609281e880bc.png)



