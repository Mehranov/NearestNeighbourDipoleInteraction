# NearestNeighbourDipoleInteraction
In this code, we calculate the direct magnetic dipole interaction for each dipole within a disk in a arrays of multilayer ferromagnetic nanowire and include the result in a mean field calculation explixitly
You should run Main.m file in Matlab and input the followings:
1- Radius of the disk
2- thickness of magnetic layer
3- thickness of non-magnetic layer
4- Saturation Magnetization, Ms
5- Number of nearest neighbors you want to take into account 
6- Resultion for the calculation (size of a single dipole)
7- Resultion of angle rotation in each step (it is pi/resolution, so the higher the value of "resolution" the slower the dipoles will rotate)
8- Porosity Factor (the density of pores per unit area)
The output will be the total magnetic density energy produced by neighboring layers at the center of the middle disk vs Theta
By fitting the data to uniaxial anisotropy equation ( K*sin^2(Theta)+C ) we can achive the anisotropy constant K and the calculate the Effective Field 
