# High-Performance Discrete Particle Swarm Optimization (PSO) Algorithm and Software Development of Application on JSSP

## Abstract
- Conducted research to study industrial **Job-shop Scheduling Problem(JSSP)**, and designed a coding and decoding scheme.
- Prototyped and implemented the **Cooperative PSO algorithm** for optimizing JSSP problem in **MATLAB**.
- Discovered **optimal combination of parameters** for CPSO algorithm using **Response Surface Methodology(RSM)**.
- Designed 8 JSSP testing cases for CPSO algorithm with optimal parameters, and mapped correlated algorithm convergence curve and scheduling Gantt Graphs. 
- Conducted **performance analysis** from two aspects.
	* **Algorithm Improvement**: CPSO algorithm **reduced at most 17.68% error** to theoretical optimal solution compared to that of standard PSO algorithm; 
	* **Parameter Optimization**: approximately **87.5%** of 8 test cases results made **better performances** with aforementioned optimal parameters than original parameters did.
- Developed a **user-friendly desktop client**: PSO-related JSSP software system in **C#** and **SQL Server**, providing the capability for users to obtain fast results by inputting key parameters.

## Algorithm Design
### Standard PSO Algorithm
<img src="https://raw.githubusercontent.com/Wangxh329/PSOAlgorithms/master/doc/PSO.png" width="442px" height="618px" alt="standard PSO algorithm">

> standard PSO algorithm

### Cooperative PSO Algorithm
<img src="https://raw.githubusercontent.com/Wangxh329/PSOAlgorithms/master/doc/CPSO.png" width="425px" height="627px" alt="cooperative PSO algorithm">

> cooperative PSO algorithm

## Performance Analysis
Designed 8 JSSP benchmark testing cases(FT06，FT10，FT20，LA01，LA21，LA26，LA31，LA36) for performance analysis:
### Algorithm Improvement
Mainly compared the results of JSSP benchmarks solved by PSO algorithm and CPSO algorithm:

<img src="https://raw.githubusercontent.com/Wangxh329/PSOAlgorithms/master/doc/makespan.bmp" width="768px" height="421px" alt="makespan">

> makespan

<img src="https://raw.githubusercontent.com/Wangxh329/PSOAlgorithms/master/doc/rate.bmp" width="768px" height="421px" alt="optimization rate">

> optimization rate

<img src="https://raw.githubusercontent.com/Wangxh329/PSOAlgorithms/master/doc/relative_error.bmp" width="768px" height="421px" alt="average relative error">

> average relative error

<img src="https://raw.githubusercontent.com/Wangxh329/PSOAlgorithms/master/doc/standard_deviation.bmp" width="768px" height="421px" alt="standard deviation">

> standard deviation

### Parameter Optimization
Discovered optimal combination of parameters for CPSO algorithm using Response Surface Methodology(RSM), and about 87.5% of test cases had better performances than the original parameters did:

<img src="https://raw.githubusercontent.com/Wangxh329/PSOAlgorithms/master/doc/optimization_result.png" width="944px" height="202px" alt="parameter optimization">

> parameter optimization

## Software Development
Developed a user-friendly desktop client: PSO-related JSSP software system in C# and SQL Server, providing the capability for users to obtain fast results by inputting key parameters.
### Infrastructure Design

<img src="https://raw.githubusercontent.com/Wangxh329/PSOAlgorithms/master/doc/system.png" width="663px" height="367px" alt="infrastructure design">

> infrastructure design

### Function Design

<img src="https://raw.githubusercontent.com/Wangxh329/PSOAlgorithms/master/doc/function.png" width="854px" height="377px" alt="function design">

> function design

### Database Design
- results

<img src="https://raw.githubusercontent.com/Wangxh329/PSOAlgorithms/master/doc/db_results.png" width="577px" height="299px" alt="results table">

> results table

- users

<img src="https://raw.githubusercontent.com/Wangxh329/PSOAlgorithms/master/doc/db_users.png" width="577px" height="181px" alt="users table">

> users table

### Software Screenshot
- Login and register

<img src="https://raw.githubusercontent.com/Wangxh329/PSOAlgorithms/master/doc/login.jpg" width="601px" height="341px" alt="login and register">

> login and register

- Parameter settings

<img src="https://raw.githubusercontent.com/Wangxh329/PSOAlgorithms/master/doc/parameter.jpg" width="601px" height="341px" alt="parameter settings">

> parameter settings

- Scheduling result and history

<img src="https://raw.githubusercontent.com/Wangxh329/PSOAlgorithms/master/doc/history.jpg" width="601px" height="341px" alt="schedule history">

> schedule history

<img src="https://raw.githubusercontent.com/Wangxh329/PSOAlgorithms/master/doc/gantt.png" width="901px" height="506px" alt="gantt graph">

> gantt graph

- Users

<img src="https://raw.githubusercontent.com/Wangxh329/PSOAlgorithms/master/doc/users.jpg" width="601px" height="341px" alt="users management">

> users management