%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Name: Uniforme
% 
% Objective:
%
% Input/Output Parameters:
%
% Obs: This matlab routine will generate random data with uniform
% distribution and subsequently train a Self-Organizing Map. 
%
% V1.0 - Moreira Bastos, Jun 2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Initialize all variables %

bins=10;                    %number of bins
neurons=1000;               %SOM neurons
initialradius=neurons/5;    %Initial radius
finalradius=0;              %Final radius
iterations=1000;            %Number of iterations

for j=1:1

z1=10^4; %data points

    for i=1000:iterations

epochs=i; %On each iteration the training epochs will unitarily increase

%% Generate random data %

% dados=rand(z1,1); %Generate random data

dados=0:0.001:0.999; 
dados=dados+0.0005; 
dados=dados';

qtd=zeros(bins,1); %initialize a variable to store the quantity of data in each bin

for x=1:length(dados)
    qtd(ceil(dados(x)*bins)) = qtd(ceil(dados(x)*bins))+1; %storing the quantity of data in each bin
end

dens=qtd/(1/bins); % copy the density of input data in each bin to a variable

%% TRAINING THE SOM %  

sMap = som_lininit(dados,'munits',neurons,'shape','toroid'); % %Initialize linearly the SOM Map with toroid shape

sMap2= som_batchtrain(sMap,dados,'radius_ini',initialradius,'radius_fin',finalradius,'trainlen',epochs); %Training the SOM

SOM_data= sMap2.codebook; %Copy the neurons to SOM_data

qtdn=zeros(bins,1); %initialize a variable to store the quantity of neurons in each bin

for x=1:length(sMap2.codebook)
    qtdn(ceil(SOM_data(x)*bins)) = qtdn(ceil(SOM_data(x)*bins))+1;    %storing the quantity of neurons in each bin
end

neurons_density=qtdn/(1/bins); % copy the density of neurons in each bin to a variable

tiledlayout(2,1) % Create a tiled chart layout

nexttile % Top plot

title('Step distribution'); %figure title
grid on;
hold on;

bar(dens); %Show the input data density in a bars graph 
ylim([0 1200]);
xlabel('Bins') , ylabel('Density');
yline(1000,'-','Average Density');
hold off;
title(sprintf('%d input data with uniform distribution',z1));%figure title

nexttile % Bottom plot

hold on
bar(neurons_density,'r'); %Show the SOM neurons density in a bars graph
xlabel('Bins') , ylabel('Density');
yline(neurons,'-','Average Unit Density');
hold off
texto=sprintf('SOM Output after %d training epochs',epochs);
title(texto);
grid on


    end

save(sprintf('distribuicaouniforme_toroid.mat')); %Saving all the experiment

end
