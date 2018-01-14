function minmakespan=jsmakespan10c5(gen) 
%js is the job sequence matrix 
T=[21 53 95 55 34
   21 52 16 26 71
   39 98 42 31 12
   77 55 79 66 77
   83 34 64 19 37
   54 43 79 92 62
   69 77 87 87 93
   38 60 41 24 83
   17 49 25 44 98
   77 79 43 75 96]; 
js=[2 1 5 4 3
    1 4 5 3 2
    4 5 2 3 1
    2 1 5 3 4
    1 4 3 2 5
    2 3 5 1 4
    4 5 2 3 1
    3 1 2 4 5
    4 2 5 1 3
    5 4 3 2 1]; 
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