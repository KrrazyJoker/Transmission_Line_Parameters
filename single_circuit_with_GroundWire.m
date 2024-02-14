disp('Single Un-bundled Circuit With Ground Wire');
f = 50; %frequency in Hz
d1= input(' Distance between conductors a and b(in m): ');
d2= input(' Distance between conductors b and c(in m): ');
d3= input(' Distance between conductors c and a(in m): ');
hg= input(' Distance between conductor and ground(in m): ');
conductor = input('Enter your ACSR code: ','s');
[rL,rC]=radii(conductor);
Dm= power((d1*d2*d3),1/3);
L= 2*10^-7*log(Dm/rL);
XL = 2*pi*f*L;
display(['OUTPUT INDUCTANCE']);
display(['L= ' num2str(L) '[H/m]']);
display(['XL= ' num2str(XL) '[ohm/m]']);
%Calculation of Capacitance with ground:
H1= hg+hg;
H2= hg+hg;
H3= hg+hg;
H12= sqrt((H1*H1)+(d1*d1));
H23= sqrt((H2*H2)+(d2*d2));
H31= sqrt((H3*H3)+(d3*d3));
k = 8.85*10^-12; 
Hm= power((H12*H23*H31),1/3);
Hs= power((H1*H2*H3),1/3);
C= (2*pi*k)/((log(Dm/rC)) - log(Hm/Hs));
XC = 1/(2*pi*f*C);
display(['OUTPUT CAPACITANCE']);
display(['C= ' num2str(C) '[F/m]']);
display(['XC= ' num2str(XC) '[ohm/m]']);
display([' ']);
disp('For Improving Efficieny;')
num_bund = input('Enter No of conductors in Bundle (2,3 or 4): ');
spaci_bund = input('Enter Spacing btw Conductors (in m): ');

if num_bund == 2
    newrL = sqrt(rL*spaci_bund);
    newrC = sqrt(rC*spaci_bund);
elseif num_bund == 3
    newrL = ((rL) * (spaci_bund^2))^1/3;
    newrC = ((rC) * (spaci_bund^2))^1/3;
elseif num_bund == 4
    newrL = 1.09*(rL*(spaci_bund^3))^1/4;
    newrC = 1.09*(rC*(spaci_bund^3))^1/4;
else
end
newL= 2*10^-7*log(Dm/newrL);
newXL = 2*pi*f*newL
display(['OUTPUT INDUCTANCE']);
display(['New L= ' num2str(newL) '[H/m]']);
display(['New XL= ' num2str(newXL) '[ohm/m]']);
%Calculation of Capacitance:
k = 8.85*10^-12; 
newC= (2*pi*k)/((log(Dm/newrC)) - log(Hm/Hs)); 
newXC = 1/(2*pi*f*newC);
display(['OUTPUT CAPACITANCE']);
display(['New C= ' num2str(newC) '[F/m]']);
display(['New XC= ' num2str(newXC) '[ohm/m]']);
display([' ']);
percent_change_XL = ((newXL - XL)/XL)*100;
percent_change_XC = ((newXC - XC)/XC)*100;

% Display the result for change in XL
if percent_change_XL > 0
    disp(['There is a ' num2str(abs(percent_change_XL)) '% increase in XL.']);
elseif percent_change_XL < 0
    disp(['There is a ' num2str(abs(percent_change_XL)) '% decrease in XL.']);
else
    disp('There is no change.');
end

% Display the result for change in XC
if percent_change_XC > 0
    disp(['There is a ' num2str(abs(percent_change_XC_)) '% increase in XC.']);
elseif percent_change_XC < 0
    disp(['There is a ' num2str(abs(percent_change_XC)) '% decrease in XC.']);
else
    disp('There is no change.');
end