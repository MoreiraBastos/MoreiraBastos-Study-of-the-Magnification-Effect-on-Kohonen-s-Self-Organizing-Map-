%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Name: main_rectangulo_2areas_increasing_epochs
% 
% Objective:
%
% Input/Output Parameters:
%
% Obs: This matlab routine will generate 2-D input data with two distinct 
% density areas and subsequently train a Self-Organizing Map. Finally it
% plots SOMs outputs vs increasing epochs or increasing.
% 
%
% V1.0 - Moreira Bastos, Jun 2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

area1 = 850; % Data points on the first area
area2 = 150; % Data points on the second area

%% Uncomment to plot the input data distribution before training SOM
% 
% plot(xRandom1,yRandom1,'b.','MarkerSize',12); hold on
% plot(xRandom2,yRandom2,'m.','MarkerSize',12); hold on
% rectangle('Position', [0, 0, 100, 50],'LineWidth',0.5,'LineStyle','--');
% xline(50); txt = 'AREA 1'; text(20,51,txt)
% txt = 'AREA 2'; text(70,51,txt) 
% pause
% close all;
% 
%% TRAINING THE SOM
for u=1:3000
    
    %% Generating random input data
xRandom1=zeros(1,area1); xRandom2=zeros(1,area2);
yRandom1=zeros(1,area1); yRandom2=zeros(1,area2);

for i=1:area1 % Distributing data on the first area
xRandom1(i) = randi([0 49],1,1);
yRandom1(i) = randi([0 49],1,1);
end
Dados1=[xRandom1;yRandom1]; % saving the data

for i=1:area2 % Distributing data on the second area
xRandom2(i) = randi([50 100],1,1);
yRandom2(i) = randi([0 49],1,1);
end
Dados2=[xRandom2;yRandom2]; % saving the data

Dados_entrada=[Dados1 Dados2]; % saving all the data

    %% Self-Organizing Map input parameters
msize = [25 40];

sMap = som_lininit(Dados_entrada','msize',msize,'hexa','sheet','shape','toroid');

som_grid(sMap,'Coord',sMap.codebook); axis equal; neurons=msize(1)*msize(2);


    %% Training the Self-Organizing Map
epochs=u; % number of training epochs

sMap= som_batchtrain(sMap,Dados_entrada','radius_ini',neurons/25,'radius_fin',0,'trainlen',epochs); %Training the SOM using the batch algorithm


          %% Plot the data and the neurons grid mapping animation
% plot(xRandom1,yRandom1,'b.','MarkerSize',12); hold on
% plot(xRandom2,yRandom2,'m.','MarkerSize',12); hold on
% xline(50); txt = 'AREA 1'; text(20,52,txt)
% txt = 'AREA 2'; text(70,52,txt)
% rectangle('Position', [0, 0, 100, 50],'LineWidth',0.5,'LineStyle','--'); 
% hold on
% title(sprintf('%d/%d training steps',npstep*i,npstep*vstep)); axis equal;
% hold on, som_grid(sMap,'Coord',sMap.codebook); 
% hold off
% 
% drawnow
% axis equal;


neuron1=sum(floor(sMap.codebook(:,1))<=49); % number of neurons on the first area
neuron2=sum(floor(sMap.codebook(:,1))>49); % number of neurons on the second area

dens=[area1/(50^2) area2/(50^2)]; % Data density
densn=[neuron1/(50^2) neuron2/(50^2)]; % Neurons density

%% Uncomment to plot average input area densities vs. neuron area densities
% figure
% plot([1 50 50 100],[area1/(50^2) area1/(50^2) area2/(50^2) area2/(50^2) ]); hold on;
% plot([1 50 50 100],[neuron1/(50^2) neuron1/(50^2) neuron2/(50^2) neuron2/(50^2)]);
% txt = 'AREA 1';
% text(20,neuron2/(50^2),txt);
% txt = 'AREA 2';
% text(70,neuron1/(50^2),txt);

save(sprintf('2. Aumento de epocas/2D_1000dados_1000neuronios_2areas_aumentodeepocas%d.mat',u));% Saving all the experiment

end