%改进之处：当前采用半活动调度,即不允许利用空闲时段插队.可改为活动调度,易得最优解

function minmakespan=jsmakespan6c6(gen) 
T=[1 3 6 7 3 6      %各个工件的各个操作对应的加工时间
   8 5 10 10 10 4 
   5 4 8 9 1 7  
   5 5 5 3 8 9 
   9 3 5 4 3 1  
   3 3 9 10 4 1]; 
js=[3 1 2 4 6 5     %各个工件的各个操作对应的机器(机器数=操作数)
    2 3 5 6 1 4 
    3 4 6 1 2 5 
    2 1 3 4 5 6 
    3 2 5 6 1 4 
    2 4 6 1 5 3]; 
[n,m]=size(T); 
wpn=length(gen); 
starts=zeros(m,n);   %记录每个机器上每个操作的开始加工时间
ends=zeros(m,n);     %记录每个机器上每个操作的结束加工时间
jp=zeros(1,n);       %记录每个工件当前执行到了第几个操作 
mj=zeros(m,1);       %记录每个加工机器上目前已累积的操作数
mjn=zeros(m,n);      %记录每个工件的每道操作在加工机器上的加工排序
%gen=[6  3  6  5  5  3  4  1  2  4   6  3   3  6   1  5   1   6   4   2   2   5   5]; 
for i=1:wpn 
    jp(gen(i))=jp(gen(i))+1; 
    mj(js(gen(i),jp(gen(i))))=mj(js(gen(i),jp(gen(i))))+1; 
    mjn(js(gen(i),jp(gen(i))),gen(i))=mj(js(gen(i),jp(gen(i)))); 
    if jp(gen(i))==1 %若执行的是当前工件的第一道操作
       if mj(js(gen(i),1))==1 %当前加工机器上空闲
          starts(js(gen(i),1),1)=0; 
          ends(js(gen(i),1),1)=T(gen(i),1); 
       else %半活动调度
          starts(js(gen(i),1),mj(js(gen(i),1)))=ends(js(gen(i),1),mj(js(gen(i),1))-1); %资源约束:某机器上的非空闲时段加入的新操作的开始时间=该机器上当前加工操作的结束时间
          ends(js(gen(i),1),mj(js(gen(i),1)))=starts(js(gen(i),1),mj(js(gen(i),1)))+T(gen(i),1); 
       end 
    else 
       if mj(js(gen(i),jp(gen(i))))==1 
          starts(js(gen(i),jp(gen(i))),1)=ends(js(gen(i),jp(gen(i))-1),mjn(js(gen(i),jp(gen(i))-1),gen(i))); %工序约束:某工件的非首道操作开始时间=该工件的上道操作的结束时间
          ends(js(gen(i),jp(gen(i))),1)=starts(js(gen(i),jp(gen(i))),1)+T(gen(i),jp(gen(i))); 
       else %半活动调度
           %当前操作非工件的首道操作且加工机器不空闲时,开始时间选择max[该工件的前道操作,该机器的前道操作]
          starts(js(gen(i),jp(gen(i))),mj(js(gen(i),jp(gen(i)))))=max(ends(js(gen(i),jp(gen(i))),mj(js(gen(i),jp(gen(i))))-1),ends(js(gen(i),jp(gen(i))-1),mjn(js(gen(i),jp(gen(i))-1),gen(i)))); 
          ends(js(gen(i),jp(gen(i))),mj(js(gen(i),jp(gen(i)))))=starts(js(gen(i),jp(gen(i))),mj(js(gen(i),jp(gen(i)))))+T(gen(i),jp(gen(i))); 
       end 
    end 
end 
minmakespan=max(max(ends)); 