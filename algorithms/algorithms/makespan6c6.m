function [minmakespan,starts,ends]=makespan6c6(gen) 
T=[1 3 6 7 3 6 
  8 5 10 10 10 4 
  5 4 8 9 1 7  
  5 5 5 3 8 9 
  9 3 5 4 3 1  
  3 3 9 10 4 1]; 
js=[3 1 2 4 6 5 
    2 3 5 6 1 4 
    3 4 6 1 2 5 
    2 1 3 4 5 6 
    3 2 5 6 1 4 
    2 4 6 1 5 3]; 
[n,m]=size(T); 
wpn=length(gen); 
starts=zeros(m,n); 
ends=zeros(m,n); 
jp=zeros(1,n);%job working procedure 
mj=zeros(m,1);% job on machine 
mjn=zeros(m,n); 
for i=1:wpn 
    jp(gen(i))=jp(gen(i))+1; 
    mj(js(gen(i),jp(gen(i))))=mj(js(gen(i),jp(gen(i))))+1; 
    mjn(js(gen(i),jp(gen(i))),gen(i))=mj(js(gen(i),jp(gen(i)))); 
    if jp(gen(i))==1 
       if mj(js(gen(i),1))==1 
          starts(js(gen(i),1),1)=0; 
          ends(js(gen(i),1),1)=T(gen(i),1); 
       else 
          starts(js(gen(i),1),mj(js(gen(i),1)))=ends(js(gen(i),1),mj(js(gen(i),1))-1); 
          ends(js(gen(i),1),mj(js(gen(i),1)))=starts(js(gen(i),1),mj(js(gen(i),1)))+T(gen(i),1); 
       end 
    else 
       if mj(js(gen(i),jp(gen(i))))==1 
          starts(js(gen(i),jp(gen(i))),1)=ends(js(gen(i),jp(gen(i))-1),mjn(js(gen(i),jp(gen(i))-1),gen(i))); 
          ends(js(gen(i),jp(gen(i))),1)=starts(js(gen(i),jp(gen(i))),1)+T(gen(i),jp(gen(i))); 
       else 
          starts(js(gen(i),jp(gen(i))),mj(js(gen(i),jp(gen(i)))))=max(ends(js(gen(i),jp(gen(i))),mj(js(gen(i),jp(gen(i))))-1),ends(js(gen(i),jp(gen(i))-1),mjn(js(gen(i),jp(gen(i))-1),gen(i)))); 
          ends(js(gen(i),jp(gen(i))),mj(js(gen(i),jp(gen(i)))))=starts(js(gen(i),jp(gen(i))),mj(js(gen(i),jp(gen(i)))))+T(gen(i),jp(gen(i))); 
       end 
    end 
end 
minmakespan=max(max(ends)); 