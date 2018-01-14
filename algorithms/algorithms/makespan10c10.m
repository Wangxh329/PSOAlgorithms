function [minmakespan,starts,ends]=makespan10c10(gen) 
T=[29 78 9 36 49 11 62 56 44 21 
   43 90 75 11 69 28 46 46 72 30 
   91 85 39 74 90 10 12 89 45 33 
   81 95 71 99 9 52 85 98 22 43 
   14 6 22 61 26 69 21 49 72 53 
   84 2 52 95 48 72 47 65 6 25 
   46 37 61 13 32 21 32 89 30 55 
   31 86 46 74 32 88 19 48 36 79 
   76 69 76 51 85 11 40 89 26 74 
   85 13 61 7 64 76 47 52 90 45]; 
js=[1 2 3 4 5 6 7 8 9 10 
    1 3 5 10 4 2 7 6 8 9 
    2 1 4 3 9 6 8 7 10 5 
    2 3 1 5 7 9 8 4 10 6 
    3 1 2 6 4 5 9 8 10 7 
    3 2 6 4 9 10 1 7 5 8 
    2 1 4 3 7 6 10 9 8 5 
    3 1 2 6 5 7 9 10 8 4 
    1 2 4 6 3 10 7 8 5 9 
    2 1 3 7 9 10 6 4 5 8]; 
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