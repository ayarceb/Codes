% Code to plot the polygones of the OMI satellite over the LE grid 


% clear all
% close all
% clear

%%-------------------------------------------------------------------------------------------------------------------

load Estructuras.mat
corner_longitudes=ncread('OMI-Aura_NO2_20160320.nc','corner_longitudes');  % This first version just takes one day from the OMI Carib cropped region
corner_latitudes=ncread('OMI-Aura_NO2_20160320.nc','corner_latitudes');

ln=length(corner_latitudes(1,:));
clon=corner_lonsgitudes;
clat=corner_latitudes;

dx=0.09;    % distance between each strip on the grid
hold on


%%
% ax = worldmap('COLOMBIA');
% load coast
% geoshow(ax, lat, long,...
%        'DisplayType', 'Polygon', 'FaceColor', [1 1 1])
% hold on
% lon=[-79.8:dx:-65.94];
% lat=[-4.55:dx:13.27];
% [X,Y]=meshgrid(lon,lat)
% 
% for i=1:199
% h=geoshow(ax,Y(i,:),X(i,:),'displaytype','line','color','r');
% hold on
% end
% for i=1:155
% h=geoshow(ax,Y(:,i),X(:,i),'displaytype','line','color','r');
% hold on
% end
% hold on 
%  plot(corner_lonsgitudes(:,:),corner_latitudes(:,:))

%%
 

borders('colombia','r','linewidth',3,'nomap')
hold on

labelborders('Colombia','color','r','nomap')
 hold on
 
%% This part draw the grid on the LOTOS EUROS Experiment Dcol
%  
% for i=1:155
%     plot(X(:,i),Y(:,i),'k','linewidth',0.2)
%     hold on
% end
%     
% for j=1:199
%     plot(X(j,:),Y(j,:),'k','linewidth',0.2)
%     hold on
% end

%%
% Following plot is for the OMI polygons
plot(corner_longitudes(1:4,1:2),corner_latitudes(1:4,1:2)) 
%plot(lon,lat,'*')   % This part plot the first position points that the code of LE2OMI provides
    