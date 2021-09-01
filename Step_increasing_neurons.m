%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Name: Step_increasing_neurons
% 
% Objective:
%
% Input/Output Parameters:
%
% Obs: This matlab routine will generate random data with step
% distribution and subsequently train a Self-Organizing Map 
% and further generate plots of SOM outputs vs. the increasing of neurons
%
% V1.0 - Moreira Bastos, Jun 2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Initialize all variables

bins=100;
limiteinferior=50; 
limitesuperior=50;
iterations=1; 
z1=50; %data in zone z1 
z2=1000-z1; %data in zone z2

%% Coding

for j=1:2000 % number of runs

    neurons=j; initialradius=neurons/5;

        for i=1:iterations

epochs=500; %number of SOM training epochs

randomdata1=rand(z1,1)*limiteinferior; %Generate data in the first zone

randomdata2=(rand(z2,1)*limiteinferior)+limitesuperior; %Generate data in the second zone

dados=[randomdata1;randomdata2]; %Put all data in one matrix

qtd=zeros(bins,1); %initialize a variable to store the quantity of data in each bin

for x=1:length(dados)
    qtd(ceil(dados(x))) = qtd(ceil(dados(x)))+1;
end

dens=qtd/(sum(qtd)); % copy the density of input data in each bin to a variable


%% TRAINING THE SOM

sMap = som_lininit(dados,'munits',neurons); % %Initialize linearly the SOM Map

sMap2= som_batchtrain(sMap,dados,'radius_ini',initialradius,...
    'radius_fin',0,'trainlen',epochs); %TRAINING THE SOM

SOM_data= sMap2.codebook; % Copy the neurons to SOM_data

qtdn=zeros(bins,1); % Initialize a variable to store the quantity of neurons in each bin

for x=1:length(sMap2.codebook)
%     argument=ceil(SOM_data(x));
%     if argument==0
%         argument=1; % Condition to avoid the error when argument equals zero
%     end
     qtdn(ceil(SOM_data(x))) = qtdn(ceil(SOM_data(x)))+1;    
end

%% PLOTTING THE RESULTS

densidade_inputx=[0 50 51 100]; % Data density zone boundaries
densidade_input=[z1/50 z1/50 z2/50 z2/50]; % Theoretical density in each zone from (0 to 50) and (50 to 100)

densidade_outputx=[0 50 51 100];
densidade_output=[sum(qtdn(1:51))/50 sum(qtdn(1:51))/50 sum(qtdn(51:100))/50 sum(qtdn(51:100))/50];

save(sprintf('heaviside_n%d.mat',j)); %Saving all the experiment

%% Uncomment the section below if you want to save the values for density in each iteration

% comparing_density_first_zone(i,:)=[densidade_input(1) densidade_output(1)];
% 
% comparing_density_second_zone(i,:)=[densidade_input(3) densidade_output(3)];

% save('curvadeconvergencia.mat','comparing_density_first_zone','comparing_density_second_zone');


        end
%
%% Uncomment the section below if you want to plot the resulting 
%% data density distribution vs. the input data distribution
%
% tiledlayout(2,1);
% nexttile
% plot((comparing_density_first_zone),'.');
% grid('minor');
% legend('theoretical density','neurons density');
% xlabel('Iteration');
% ylabel('Density');
% ylim([(z1/(z1+z2)/50)/10, 0.005]);
% % titulo=sprintf('Comparing density in the lower density zone \n (%d input data of %d)',z1,z1+z2);
% % title(titulo);
% 
% 
% nexttile
% 
% plot((comparing_density_second_zone),'.');
% grid('minor');
% % titulo=sprintf('Comparing density in the higher density zone \n\t (%d input data of %d)',z2,z1+z2);
% % title(titulo);
% legend('theoretical density','neurons density');
% legend('theoretical density','neurons density');
% xlabel('Iteration');
% ylabel('Density');
% ylim([0, (z2/(z1+z2)/50)+(z2/(z1+z2)/50)/10]);

% save(sprintf('increasing_neurons%d.mat',j)); %Saving all the experiment

end

