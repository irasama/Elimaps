function [M,D]=askDAY(DOY1,AN)
% gives month and day when DOY and year
DOY=[1:365]';
DOYB=[1:366]';

mes1=[1:30]';
mes2=[1:31]';
mes3=[1:28]';
mes4=[1:29]';

m1=1.*ones(31,1);
m2=2.*ones(28,1);
m2b=2.*ones(29,1);
m3=3.*ones(31,1);
m4=4.*ones(30,1);
m5=5.*ones(31,1);
m6=6.*ones(30,1);
m7=7.*ones(31,1);
m8=8.*ones(31,1);
m9=9.*ones(30,1);
m10=10.*ones(31,1);
m11=11.*ones(30,1);
m12=12.*ones(31,1);

n_meses=[m1 ;m2 ; m3 ; m4 ; m5  ;m6  ;m7  ;m8  ;m9 ; m10 ; m11 ; m12];
n_dia=[mes2;mes3;mes2;mes1;mes2;mes1;mes2;mes2;mes1;mes2;mes1;mes2];
n_mesesb=[m1 ;m2b ; m3 ; m4 ; m5  ;m6  ;m7  ;m8  ;m9 ; m10 ; m11 ; m12];
n_diab=[mes2;mes4;mes2;mes1;mes2;mes1;mes2;mes2;mes1;mes2;mes1;mes2];


if AN== 2004 | AN==2008 | AN==2012 | AN==2016 | AN==2020 %% bisiesto
            mes=n_mesesb;
            dia=n_diab;
            DOY=DOYB';
        else
            mes=n_meses;
            dia=n_dia;
            DOY=DOY;
end

pos1=ones(size(DOY1));
for i=1:size(DOY1)
    for j=1:size(DOY) 
        if DOY1(i)==DOY(j)
            pos1(i)=j;
        end
    end
end
M=mes(pos1);
D=dia(pos1);

end
