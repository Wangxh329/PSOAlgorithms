%%%%%%%%%%%%%%%% 协同粒子群算法 %%%%%%%%%%%%%%%%
%特点：计算速度较慢,但结果收敛速度快
%思路：将整个群体分成若干个子群,更新时分别更新自己子群的当前粒子群体subpop*,记录当前子群的最优粒子xmin*,最后各个子群的更新结果拼起来
%存在问题：
%2)输出值不稳定
%3)划分的子种群重复代码过多,写成循环且可以交互输入子种群个数？
%4)算法内部参数c1/c2/a的影响？
%5)随机变异操作r的意义？增加多样性,但会降低收敛速率？
%6)加入算法在线性能/离线性能/收敛速率/计算时间等的评估
%7)find函数改进？

function [opsch,opx,opy,optimy]=CPSOjobshop_5Group(gennum,psize,w,C1,C2,jnum,mnum) 
n=mnum*jnum; 
current_gen=1; 

%%%%%%%%%%%%%%%%% 初始化 %%%%%%%%%%%%%%%%%%%
newgen=zeros(psize,n+1); 
pop=zeros(psize,n); 
A=zeros(psize,n/5);%全局最优粒子种群 
vel=zeros(psize,n/5); 
optimy=ones(1,gennum); 
newgen(1:psize,1:n)=rand(psize,n); %对newgen矩阵的前n列初始化随机数
%每个子群体更新的子部分
subpop1=zeros(psize,n/5); 
subpop2=zeros(psize,n/5); 
subpop3=zeros(psize,n/5); 
subpop4=zeros(psize,n/5); 
subpop5=zeros(psize,n/5); 
%每个子群体当前完整状态
newgen1=zeros(psize,n+1); 
newgen2=zeros(psize,n+1); 
newgen3=zeros(psize,n+1); 
newgen4=zeros(psize,n+1); 
newgen5=zeros(psize,n+1); 
%中间变量
pop1=zeros(psize,n); 
pop2=zeros(psize,n); 
pop3=zeros(psize,n); 
pop4=zeros(psize,n); 
pop5=zeros(psize,n); 
%记录每个子群体更新后与其他群体结合的部分(信息局部共享部分)
min1=zeros(psize,n/5); 
min2=zeros(psize,n/5); 
min3=zeros(psize,n/5); 
min4=zeros(psize,n/5); 
min5=zeros(psize,n/5); 
%记录每个子群体每次迭代的全局最优值
optimy1=ones(1,gennum); 
optimy2=ones(1,gennum); 
optimy3=ones(1,gennum); 
optimy4=ones(1,gennum); 
optimy5=ones(1,gennum); 
%记录每个子群体当前迭代中各粒子的最优值
optt1=ones(psize,1); 
optt2=ones(psize,1); 
optt3=ones(psize,1); 
optt4=ones(psize,1); 
optt5=ones(psize,1); 
%每个子群体的速度矩阵
vel1=vel; 
vel2=vel; 
vel3=vel; 
vel4=vel; 
vel5=vel; 
%每个子群对应需要按照公式更新的部分
subpop1=newgen(:,1:n/5);                
subpop2=newgen(:,n/5+1:2*n/5);         
subpop3=newgen(:,2*n/5+1:3*n/5); 
subpop4=newgen(:,3*n/5+1:4*n/5); 
subpop5=newgen(:,4*n/5+1:n); 
%子群(分部)的最优小粒子,初始位置随便定
xmin1=subpop1(1,:);          
xmin2=subpop2(1,:); 
xmin3=subpop3(1,:); 
xmin4=subpop4(1,:); 
xmin5=subpop5(1,:); 
 
%初始化5个min矩阵,元素均为newgen中第一行的元素 
for i=1:psize 
    min1(i,:)=xmin1; 
    min2(i,:)=xmin2; 
    min3(i,:)=xmin3; 
    min4(i,:)=xmin4; 
    min5(i,:)=xmin5; 
end 

%%%%%%%%%%%%%%%%%%% 处理子群(第一代) %%%%%%%%%%%%%%%%%%%
%问题：
%2)每个子群之间存在交叉操作？(min*)每个子群内部只有subpop*不一样,变异操作？---一部分一部分地更新(卢 切割九宫格,避免陷入局部最优)
%3)只取每个子群的1/5加入下一个子群,这1/5是否有效？能否保证收敛？或是仅仅为了增加种群多样性？

%处理第一个子群
newgen1=[subpop1,min2,min3,min4,min5,optt1]; 
for i=1:psize 
    [Ya,pop1(i,1:n)]=sort(newgen1(i,1:n)); %Ya为从小到大排序后的数组,pop1(i,1:n)为排序后数组中每个元素在原数组中的位置
    lz=ceil(pop1(i,1:n)/mnum); %产生一个可行的调度序列(AMAZING!!):利用排序得到索引号(共n=j×m个),除以m后向上取整保证每个j出现m次,解可行
    %%%%%%%%%%%%% 算例测试区 %%%%%%%%%%%%%%
    %newgen1(i,n+1)=jsmakespan6c6(lz);    % makespan6c6
    %newgen1(i,n+1)=jsmakespan10c10(lz); % makespan10c10
    %newgen1(i,n+1)=jsmakespan20c5(lz);  % makespan20c5
    newgen1(i,n+1)=jsmakespan10c5(lz);  % makespan10c5
    %newgen1(i,n+1)=jsmakespan20c10(lz);  % makespan20c10
    %newgen1(i,n+1)=jsmakespan30c10(lz);  % makespan30c10
    %newgen1(i,n+1)=jsmakespan15c15(lz);  % makespan15c15
    %newgen1(i,n+1)=jsmakespan15c10(lz);  % makespan15c10
    %%%%%%%%%%%%% 算例测试区 %%%%%%%%%%%%%%
    optt1(i)=newgen1(i,n+1); 
end 
[Ya,Ia]=sort(optt1); %Ya为排序更新后的optt1矩阵,Ia为各元素在原矩阵中的位置
optimy1(current_gen)=newgen1(Ia(1),n+1); %记录当前迭代中子群1的全局最小makespan
newgenp1=newgen1(1:psize,:); %记录当前迭代中得到的完整的子群1
newgeng1=newgen1(Ia(1),:); %记录当前迭代中子群1的最优调度
xmin1=newgen1(Ia(1),1:n/5);%全局最优粒子种群 
for i=1:psize 
    min1(i,:)=xmin1; 
end 
%处理第二个子群
newgen2=[min1,subpop2,min3,min4,min5,optt2]; 
for i=1:psize 
    [Ya,pop2(i,1:n)]=sort(newgen2(i,1:n)); 
    lz=ceil(pop2(i,1:n)/mnum); 
    %%%%%%%%%%%%% 算例测试区 %%%%%%%%%%%%%%
    %newgen2(i,n+1)=jsmakespan6c6(lz);   % makespan6c6
    %newgen2(i,n+1)=jsmakespan10c10(lz);  % makespan10c10
    %newgen2(i,n+1)=jsmakespan20c5(lz);  % makespan20c5
    newgen2(i,n+1)=jsmakespan10c5(lz);  % makespan10c5
    %newgen2(i,n+1)=jsmakespan20c10(lz);  % makespan20c10
    %newgen2(i,n+1)=jsmakespan30c10(lz);  % makespan30c10
    %newgen2(i,n+1)=jsmakespan15c15(lz);  % makespan15c15
    %newgen2(i,n+1)=jsmakespan15c10(lz);  % makespan15c10
    %%%%%%%%%%%%% 算例测试区 %%%%%%%%%%%%%%
    optt2(i)=newgen2(i,n+1); 
end 
[Ya,Ia]=sort(optt2); 
optimy2(current_gen)=newgen2(Ia(1),n+1); 
newgenp2=newgen2(1:psize,:); 
newgeng2=newgen2(Ia(1),:); 
xmin2=newgen2(Ia(1),n/5+1:2*n/5);%全局最优粒子种群 
for i=1:psize 
    min2(i,:)=xmin2; 
end 
%处理第三个子群
newgen3=[min1,min2,subpop3,min4,min5,optt3]; 
for i=1:psize 
    [Ya,pop3(i,1:n)]=sort(newgen3(i,1:n)); 
    lz=ceil(pop3(i,1:n)/mnum); 
    %%%%%%%%%%%%% 算例测试区 %%%%%%%%%%%%%%
    %newgen3(i,n+1)=jsmakespan6c6(lz);   % makespan6c6
    %newgen3(i,n+1)=jsmakespan10c10(lz);  % makespan10c10
    %newgen3(i,n+1)=jsmakespan20c5(lz);  % makespan20c5
    newgen3(i,n+1)=jsmakespan10c5(lz);  % makespan10c5
    %newgen3(i,n+1)=jsmakespan20c10(lz);  % makespan20c10
    %newgen3(i,n+1)=jsmakespan30c10(lz);  % makespan30c10
    %newgen3(i,n+1)=jsmakespan15c15(lz);  % makespan15c15
    %newgen3(i,n+1)=jsmakespan15c10(lz);  % makespan15c10
    %%%%%%%%%%%%% 算例测试区 %%%%%%%%%%%%%%
    optt3(i)=newgen3(i,n+1); 
end 
[Ya,Ia]=sort(optt3); 
optimy3(current_gen)=newgen3(Ia(1),n+1); 
newgenp3=newgen3(1:psize,:); 
newgeng3=newgen3(Ia(1),:); 
xmin3=newgen3(Ia(1),2*n/5+1:3*n/5);%全局最优粒子种群 
for i=1:psize 
    min3(i,:)=xmin3; 
end 
%处理第四个子群
newgen4=[min1,min2,min3,subpop4,min5,optt4]; 
for i=1:psize 
    [Ya,pop4(i,1:n)]=sort(newgen4(i,1:n)); 
    lz=ceil(pop4(i,1:n)/mnum); 
    %%%%%%%%%%%%% 算例测试区 %%%%%%%%%%%%%%
    %newgen4(i,n+1)=jsmakespan6c6(lz);   % makespan6c6
    %newgen4(i,n+1)=jsmakespan10c10(lz);  % makespan10c10
    %newgen4(i,n+1)=jsmakespan20c5(lz);  % makespan20c5
    newgen4(i,n+1)=jsmakespan10c5(lz);  % makespan10c5
    %newgen4(i,n+1)=jsmakespan20c10(lz);  % makespan20c10
    %newgen4(i,n+1)=jsmakespan30c10(lz);  % makespan30c10
    %newgen4(i,n+1)=jsmakespan15c15(lz);  % makespan15c15
    %newgen4(i,n+1)=jsmakespan15c10(lz);  % makespan15c10
    %%%%%%%%%%%%% 算例测试区 %%%%%%%%%%%%%%
    optt4(i)=newgen4(i,n+1); 
end 
[Ya,Ia]=sort(optt4); 
optimy4(current_gen)=newgen4(Ia(1),n+1); 
newgenp4=newgen4(1:psize,:); 
newgeng4=newgen4(Ia(1),:); 
xmin4=newgen4(Ia(1),3*n/5+1:4*n/5);%全局最优粒子种群 
for i=1:psize 
    min4(i,:)=xmin4; 
end 
%处理第五个子群
newgen5=[min1,min2,min3,min4,subpop5,optt5]; 
for i=1:psize 
    [Ya,pop5(i,1:n)]=sort(newgen5(i,1:n)); 
    lz=ceil(pop5(i,1:n)/mnum); 
    %%%%%%%%%%%%% 算例测试区 %%%%%%%%%%%%%%
    %newgen5(i,n+1)=jsmakespan6c6(lz);   % makespan6c6
    %newgen5(i,n+1)=jsmakespan10c10(lz);  % makespan10c10
    %newgen5(i,n+1)=jsmakespan20c5(lz);  % makespan20c5
    newgen5(i,n+1)=jsmakespan10c5(lz);  % makespan10c5
    %newgen5(i,n+1)=jsmakespan20c10(lz);  % makespan20c10
    %newgen5(i,n+1)=jsmakespan30c10(lz);  % makespan30c10
    %newgen5(i,n+1)=jsmakespan15c15(lz);  % makespan15c15
    %newgen5(i,n+1)=jsmakespan15c10(lz);  % makespan15c10
    %%%%%%%%%%%%% 算例测试区 %%%%%%%%%%%%%%
    optt5(i)=newgen5(i,n+1); 
end 
[Ya,Ia]=sort(optt5); 
optimy5(current_gen)=newgen5(Ia(1),n+1); 
newgenp5=newgen5(1:psize,:); 
newgeng5=newgen5(Ia(1),:); 
xmin5=newgen5(Ia(1),4*n/5+1:n);%全局最优粒子种群 
for i=1:psize 
    min5(i,:)=xmin5; 
end 
%记录第一代全局最小makespan
a=[optimy1(1),optimy2(1),optimy3(1),optimy4(1),optimy5(1)]; 
optimy(1)=min(a); 

%%%%%%%%%%%%%%%%% 迭代更新 %%%%%%%%%%%%%%%%%%% 
%每轮迭代更新:subpop*(PSO公式)、optimy*(current_gen)、newgeng*(子群*的全局最优粒子)、xmin*(子群*的分部的最优小粒子)、min*(子群*的当前最优分部)
while (current_gen<gennum) 
      current_gen=current_gen+1; 
      optimy1(current_gen)=optimy1(current_gen-1); 
      optimy2(current_gen)=optimy2(current_gen-1); 
      optimy3(current_gen)=optimy3(current_gen-1); 
      optimy4(current_gen)=optimy4(current_gen-1); 
      optimy5(current_gen)=optimy5(current_gen-1); 
     
      %更新第一个子群
      for i=1:psize 
          A(i,:)=xmin1; 
      end   
      R1 = rand(psize,n/5); 
      R2 = rand(psize,n/5); 
      vel1=w*vel1+C1*R1.*(newgenp1(1:psize,1:n/5)-subpop1)+ C2*R2.*(A-subpop1);  
      subpop1=subpop1+vel1;  
      newgen1=[subpop1,min2,min3,min4,min5,optt1];%本轮迭代中已更新：subpop1 
      % Evaluate the new swarm and update
      for i=1:psize 
          [Ya,pop1(i,1:n)]=sort(newgen1(i,1:n)); 
          lz=ceil(pop1(i,1:n)/mnum); 
          %%%%%%%%%%%%% 算例测试区 %%%%%%%%%%%%%%
          %newgen1(i,n+1)=jsmakespan6c6(lz);   % makespan6c6
          %newgen1(i,n+1)=jsmakespan10c10(lz);  % makespan10c10
          %newgen1(i,n+1)=jsmakespan20c5(lz);  % makespan20c5
          newgen1(i,n+1)=jsmakespan10c5(lz);  % makespan10c5
          %newgen1(i,n+1)=jsmakespan20c10(lz);  % makespan20c10
          %newgen1(i,n+1)=jsmakespan30c10(lz);  % makespan30c10
          %newgen1(i,n+1)=jsmakespan15c15(lz);  % makespan15c15
          %newgen1(i,n+1)=jsmakespan15c10(lz);  % makespan15c10
          %%%%%%%%%%%%% 算例测试区 %%%%%%%%%%%%%%
          optt1(i)=newgen1(i,n+1); 
          if newgen1(i,n+1)<=optimy1(current_gen) 
             optimy1(current_gen)=newgen1(i,n+1); 
             newgeng1=newgen1(i,:); 
             xmin1=newgen1(i,1:n/5); 
          end  
      end   
      % Updating the best position for each particle 
      changeColumns=newgen1(:,n+1)<newgenp1(:,n+1);     
      newgenp1(find(changeColumns),:)=newgen1(find(changeColumns),:);   
      r=fix(rand(1,1)*psize)+1; 
      newgen1(r,1:n/5)=xmin1; %随机变异操作？
      subpop1=newgen1(:,1:n/5); %其中1/2行为xmin1
      for i=1:psize 
          min1(i,:)=xmin1; 
      end 
     
      %更新第二个子群
      for i=1:psize 
          A(i,:)=xmin2; 
      end   
      R1 = rand(psize,n/5); 
      R2 = rand(psize,n/5); 
      vel2=w*vel2+C1*R1.*(newgenp2(1:psize,n/5+1:2*n/5)-subpop2)+ C2*R2.*(A-subpop2);  
      subpop2=subpop2+vel2; 
      newgen2=[min1,subpop2,min3,min4,min5,optt2]; %本轮迭代中已更新：min1、subpop2
      % Evaluate the new swarm  
      for i=1:psize 
          [Ya,pop2(i,1:n)]=sort(newgen2(i,1:n)); 
          lz=ceil(pop2(i,1:n)/mnum); 
          %%%%%%%%%%%%% 算例测试区 %%%%%%%%%%%%%%
          %newgen2(i,n+1)=jsmakespan6c6(lz);   % makespan6c6
          %newgen2(i,n+1)=jsmakespan10c10(lz);  % makespan10c10
          %newgen2(i,n+1)=jsmakespan20c5(lz);  % makespan20c5
          newgen2(i,n+1)=jsmakespan10c5(lz);  % makespan10c5
          %newgen2(i,n+1)=jsmakespan20c10(lz);  % makespan20c10
          %newgen2(i,n+1)=jsmakespan30c10(lz);  % makespan30c10
          %newgen2(i,n+1)=jsmakespan15c15(lz);  % makespan15c15
          %newgen2(i,n+1)=jsmakespan15c10(lz);  % makespan15c10
          %%%%%%%%%%%%% 算例测试区 %%%%%%%%%%%%%%
          optt2(i)=newgen2(i,n+1); 
          if newgen2(i,n+1)<=optimy2(current_gen) 
             optimy2(current_gen)=newgen2(i,n+1); 
             newgeng2=newgen2(i,:); 
             xmin2=newgen2(i,n/5+1:2*n/5); 
          end  
      end   
      % Updating the best position for each particle 
      changeColumns=newgen2(:,n+1)<newgenp2(:,n+1);     
      newgenp2(find(changeColumns),:)=newgen2(find(changeColumns),:);   
      r=fix(rand(1,1)*psize)+1; 
      newgen2(r,n/5+1:2*n/5)=xmin2; 
      subpop2=newgen2(:,n/5+1:2*n/5); 
      for i=1:psize 
          min2(i,:)=xmin2; 
      end 
    
      %更新第三个子群
      for i=1:psize 
          A(i,:)=xmin3; 
      end   
      R1 = rand(psize,n/5); 
      R2 = rand(psize,n/5); 
      vel3=w*vel3+C1*R1.*(newgenp3(1:psize,2*n/5+1:3*n/5)-subpop3)+ C2*R2.*(A-subpop3); %( +a*)+R3.*()+) 
      subpop3=subpop3+vel3; 
      newgen3=[min1,min2,subpop3,min4,min5,optt3]; %本轮迭代中已更新：min1、min2、subpop3
      % Evaluate the new swarm  
      for i=1:psize 
          [Ya,pop3(i,1:n)]=sort(newgen3(i,1:n)); 
          lz=ceil(pop3(i,1:n)/mnum); 
          %%%%%%%%%%%%% 算例测试区 %%%%%%%%%%%%%%
          %newgen3(i,n+1)=jsmakespan6c6(lz);   % makespan6c6
          %newgen3(i,n+1)=jsmakespan10c10(lz);  % makespan10c10
          %newgen3(i,n+1)=jsmakespan20c5(lz);  % makespan20c5
          newgen3(i,n+1)=jsmakespan10c5(lz);  % makespan10c5
          %newgen3(i,n+1)=jsmakespan20c10(lz);  % makespan20c10
          %newgen3(i,n+1)=jsmakespan30c10(lz);  % makespan30c10
          %newgen3(i,n+1)=jsmakespan15c15(lz);  % makespan15c15
          %newgen3(i,n+1)=jsmakespan15c10(lz);  % makespan15c10
          %%%%%%%%%%%%% 算例测试区 %%%%%%%%%%%%%%
          optt3(i)=newgen3(i,n+1); 
          if newgen3(i,n+1)<=optimy3(current_gen) 
             optimy3(current_gen)=newgen3(i,n+1); 
             newgeng3=newgen3(i,:); 
             xmin3=newgen3(i,2*n/5+1:3*n/5); 
          end  
      end   
      % Updating the best position for each particle 
      changeColumns=newgen3(:,n+1)<newgenp3(:,n+1);     
      newgenp3(find(changeColumns),:)=newgen3(find(changeColumns),:);   
      r=fix(rand(1,1)*psize)+1; 
      newgen3(r,2*n/5+1:3*n/5)=xmin3; 
      subpop3=newgen3(:,2*n/5+1:3*n/5); 
      for i=1:psize 
          min3(i,:)=xmin3; 
      end 
   
      %更新第四个子群
      for i=1:psize 
          A(i,:)=xmin4; 
      end   
      R1 = rand(psize,n/5); 
      R2 = rand(psize,n/5); 
      vel4=w*vel4+C1*R1.*(newgenp4(1:psize,3*n/5+1:4*n/5)-subpop4)+ C2*R2.*(A-subpop4); %( +a*)+R3.*()+) 
      subpop4=subpop4+vel4; 
      newgen4=[min1,min2,min3,subpop4,min5,optt4]; %本轮迭代中已更新：min1、min2、min3、subpop4
      % Evaluate the new swarm  
      for i=1:psize 
          [Ya,pop4(i,1:n)]=sort(newgen4(i,1:n)); 
          lz=ceil(pop4(i,1:n)/mnum); 
          %%%%%%%%%%%%% 算例测试区 %%%%%%%%%%%%%%
          %newgen4(i,n+1)=jsmakespan6c6(lz);   % makespan6c6
          %newgen4(i,n+1)=jsmakespan10c10(lz);  % makespan10c10
          %newgen4(i,n+1)=jsmakespan20c5(lz);  % makespan20c5
          newgen4(i,n+1)=jsmakespan10c5(lz);  % makespan10c5
          %newgen4(i,n+1)=jsmakespan20c10(lz);  % makespan20c10
          %newgen4(i,n+1)=jsmakespan30c10(lz);  % makespan30c10
          %newgen4(i,n+1)=jsmakespan15c15(lz);  % makespan15c15
          %newgen4(i,n+1)=jsmakespan15c10(lz);  % makespan15c10
          %%%%%%%%%%%%% 算例测试区 %%%%%%%%%%%%%%
          optt4(i)=newgen4(i,n+1); 
          if newgen4(i,n+1)<=optimy4(current_gen) 
             optimy4(current_gen)=newgen4(i,n+1); 
             newgeng4=newgen4(i,:); 
             xmin4=newgen4(i,3*n/5+1:4*n/5); 
          end  
      end   
      % Updating the best position for each particle 
      changeColumns=newgen4(:,n+1)<newgenp4(:,n+1);     
      newgenp4(find(changeColumns),:)=newgen4(find(changeColumns),:);   
      r=fix(rand(1,1)*psize)+1; 
      newgen4(r,3*n/5+1:4*n/5)=xmin4; 
      subpop4=newgen4(:,3*n/5+1:4*n/5); 
      for i=1:psize 
          min4(i,:)=xmin4; 
      end 
    
      %更新第五个子群
      for i=1:psize 
          A(i,:)=xmin5; 
      end   
      R1 = rand(psize,n/5); 
      R2 = rand(psize,n/5); 
      vel5=w*vel5+C1*R1.*(newgenp5(1:psize,4*n/5+1:5*n/5)-subpop5)+ C2*R2.*(A-subpop5); %( +a*)+R3.*()+) 
      subpop5=subpop5+vel5; 
      newgen5=[min1,min2,min3,min4,subpop5,optt5]; %本轮迭代中已更新：min1、min2、min3、min4、subpop5,即newgen5为本轮迭代的最新版本
      % Evaluate the new swarm  
      for i=1:psize 
          [Ya,pop5(i,1:n)]=sort(newgen5(i,1:n)); 
          lz=ceil(pop5(i,1:n)/mnum); 
          %%%%%%%%%%%%% 算例测试区 %%%%%%%%%%%%%%
          %newgen5(i,n+1)=jsmakespan6c6(lz);   % makespan6c6
          %newgen5(i,n+1)=jsmakespan10c10(lz);  % makespan10c10
          %newgen5(i,n+1)=jsmakespan20c5(lz);  % makespan20c5
          newgen5(i,n+1)=jsmakespan10c5(lz);  % makespan10c5
          %newgen5(i,n+1)=jsmakespan20c10(lz);  % makespan20c10
          %newgen5(i,n+1)=jsmakespan30c10(lz);  % makespan30c10
          %newgen5(i,n+1)=jsmakespan15c15(lz);  % makespan15c15
          %newgen5(i,n+1)=jsmakespan15c10(lz);  % makespan15c10
          %%%%%%%%%%%%% 算例测试区 %%%%%%%%%%%%%%
          optt5(i)=newgen5(i,n+1); 
          if newgen5(i,n+1)<=optimy5(current_gen) 
             optimy5(current_gen)=newgen5(i,n+1); 
             newgeng5=newgen5(i,:); 
             xmin5=newgen5(i,4*n/5+1:n); 
          end  
      end   
      % Updating the best position for each particle 
      changeColumns=newgen5(:,n+1)<newgenp5(:,n+1);     
      newgenp5(find(changeColumns),:)=newgen5(find(changeColumns),:);   
      r=fix(rand(1,1)*psize)+1; 
      newgen5(r,4*n/5+1:n)=xmin5; 
      subpop5=newgen5(:,4*n/5+1:n); 
      for i=1:psize 
          min5(i,:)=xmin5; 
      end 
    
      %更新当前迭代的结果
      a=[optimy1(current_gen),optimy2(current_gen),optimy3(current_gen),optimy4(current_gen),optimy5(current_gen)]; 
      b=[newgeng1(1:n);newgeng2(1:n);newgeng3(1:n);newgeng4(1:n);newgeng5(1:n)]; %所有子群的最优调度集合
      optimy(current_gen)=min(a); %目前迭代中所有子群比较下的最小makespan
      l=find(optimy(current_gen)==a); 
      L=l(1); %记录包含有最小makespan的子群
end 

%结果输出
[Ya,bsort(1,1:n)]=sort(b(L,:));
opsch=ceil(bsort(1,1:n)/mnum);%输出全局最优调度
opx=b(L,:); %输出全局最优调度(小数,供甘特图计算)
opy=min(optimy); %输出最优调度下的最小makespan