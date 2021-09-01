%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Name: Step_increasing_epochs
% 
% Objective:
%
% Input/Output Parameters:
%
% Obs: This matlab routine will generate random data with multiple step
% distribution and subsequently train a Self-Organizing Map 
% and further generate plots of SOM outputs vs the increasing of training
% epochs
%
% V1.0 - Moreira Bastos, Jun 2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Initialize all variables %
z1=200;
z2=500;
z3=50;
z4=250;

bins=100;
neurons=1000;
initialradius=neurons/5;
finalradius=0;
limite1=25;
limite2=50;
limite3=75;
limite4=100;

    
    for i=1:500
%% Generate the data

epochs=i;

randomdata1=rand(z1,1)*limite1; %Generate data in the first zone

randomdata2=(rand(z2,1)*25+limite1); %Generate data in the second zone

randomdata3=(rand(z3,1)*25+limite2); %Generate data in the third zone

randomdata4=(rand(z4,1)*25+limite3); %Generate data in the fourth zone

dados=[randomdata1;randomdata2;randomdata3;randomdata4]; %Put all data in one matrix

qtd=zeros(bins,1); %initialize a variable to store the quantity of data in each bin

for x=1:length(dados)
    qtd(ceil(dados(x))) = qtd(ceil(dados(x)))+1;
end

dens=[z1/25 z2/25 z3/25 z4/25]; % copy the density of input data in each bin to a variable
verticd=[z1/25 z1/25 z2/25 z2/25 z3/25 z3/25 z4/25 z4/25];
horizd=[1 25 25 50 50 75 75 100];
plot(horizd,verticd); %PLOT the density values in each zone
grid on, hold on;

%% TRAINING THE SOM %  

%sMap = som_randinit(dados,'munits',neuronios); %Initialize randomly the SOM Map
sMap = som_lininit(dados,'munits',neurons,'shape','toroid'); % %Initialize linearly the SOM Map

sMap2= som_batchtrain(sMap,dados,'radius_ini',initialradius,'radius_fin',finalradius,'trainlen',epochs,'shape','toroid'); %TRAINING THE SOM

SOM_data= sMap2.codebook; %Copy the neurons to SOM_data

qtdn=zeros(bins,1); %initialize a variable to store the quantity of neurons in each bin

for x=1:length(sMap2.codebook)
    argument=ceil(SOM_data(x));
    if argument==0
        argument=1; %A condition to avoid the error when argument equals zero
    end
    qtdn(argument) = qtdn(argument)+1;    
end

densn=[sum(qtdn(1:25))/25 sum(qtdn(26:50))/25 sum(qtdn(51:75))/25 sum(qtdn(76:100))/25];
verticn=[sum(qtdn(1:25))/25 sum(qtdn(1:25))/25 sum(qtdn(26:50))/25 sum(qtdn(26:50))/25 sum(qtdn(51:75))/25 sum(qtdn(51:75))/25 sum(qtdn(76:100))/25 sum(qtdn(76:100))/25];
horizn=[1 25 25 50 50 75 75 100];
plot(horizn,verticn);

save(sprintf('increasing_epochs%d',i));

end


