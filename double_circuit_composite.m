disp('Double Circuit Bundled With Composite Conductors ');
f = 50;  %frequency in Hz
d1= input(' Distance between conductors a and a*(in m): ');
d2= input(' Distance between conductors b and b*(in m): ');
d3= input(' Distance between conductors c and c*(in m): ');
h1= input(' Vertical Distance between conductors a and b(in m): ');
h2= input(' Vertical Distance between conductors b and c(in m): ');
h3= input(' Vertical Distance between conductors c and a(in m): ');
conductor = input('Enter your ACSR code: ','s');
[rL,rC]=radii(conductor);
dab=power((h1^2+((d1-d2)/2)^2)*(h1^2+(d1-(d1-d2)/2)^2),1/4);
dbc=power((h2^2+((d3-d2)/2)^2)*(h2^2+(d3-(d3-d2)/2)^2),1/4);
dca=power((h3^2+d3^2)*h3^2,1/4);
Deq= power((dab*dbc*dca),1/3);
dsa= sqrt(rL*d1); %ds(a-a')
dsb= sqrt(rL*d2); %ds(b-b')
dsc= sqrt(rL*d3); %ds(c-c')
Ds= power((dsa*dsb*dsc),1/3);
L= 2*10^-7*log(Deq/Ds);
XL = 2*pi*f*L;
display(['Deq= ' num2str(Deq) 'm']);
display(['Ds for L = ' num2str(Ds) 'm']);
display(['OUTPUT INDUCTANCE']);
display(['L= ' num2str(L) '[H/m]'])
display(['XL= ' num2str(XL) '[ohm/m]']);
%Calculation of Capacitance:
dsca= sqrt(rC*d1);
dscb= sqrt(rC*d2);
dscc= sqrt(rC*d3);
DsC= power((dsca*dscb*dscc),1/3);
k = 8.85*10^-12;
C= (2*pi*k)/(log(Deq/DsC));
XC = 1/(2*pi*f*C);
display(['Ds for C = ' num2str(DsC) 'm']);
display(['OUTPUT CAPACITANCE']);
display(['C= ' num2str(C) '[F/m]']);
display(['XC= ' num2str(XC) '[ohm/m]']);

disp('For Improving Efficieny;')
num_bund = input('Enter No of conductors in Bundle (3 or 4): ');
spaci_bund = input('Enter Spacing btw Conductors (in m): ');
if num_bund == 3
    newdsa= power((rL*d1^2),1/3); %ds(a-a')
    newdsb= power((rL*d2^2),1/3); %ds(b-b')
    newdsc= power((rL*d3^2),1/3); %ds(c-c')
    newDs= power((newdsa*newdsb*newdsc),1/3);
    newdsca= power((rC*d1^2),1/3);
    newdscb= power((rC*d2^2),1/3);
    newdscc= power((rC*d3^2),1/3);
    newDsC= power((newdsca*newdscb*newdscc),1/3);
elseif num_bund == 4
    newdsa= 1.09*power((rL*d1^3),1/4); %ds(a-a')
    newdsb= 1.09*power((rL*d2^3),1/4); %ds(b-b')
    newdsc= 1.09*power((rL*d3^3),1/4); %ds(c-c')
    newDs= power((newdsa*newdsb*newdsc),1/3);
    newdsca= 1.09*power((rC*d1^3),1/4);
    newdscb= 1.09*power((rC*d2^3),1/4);
    newdscc= 1.09*power((rC*d3^3),1/4);
    newDsC= power((newdsca*newdscb*newdscc),1/3);
else
end
newL= 2*10^-7*log(Deq/newDs);
newXL = 2*pi*f*newL;
display(['Deq= ' num2str(Deq) '[m]']);
display(['New Ds for L = ' num2str(newDs) '[m]']);
display(['OUTPUT INDUCTANCE']);
display(['New L= ' num2str(newL) '[H/m]']);
display(['New XL= ' num2str(newXL) '[ohm/m]']);
k=8.85*10^-12; 
newC= (2*pi*k)/(log(Deq/newDsC));
newXC = 1/(2*pi*f*newC);
display(['New Ds for C = ' num2str(newDsC) '[m]']);
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
    disp(['There is a ' num2str(abs(percent_change_XC)) '% increase in XC.']);
elseif percent_change_XC < 0
    disp(['There is a ' num2str(abs(percent_change_XC)) '% decrease in XC.']);
else
    disp('There is no change.');
end
