%Test how to use Simscape for electrical system modeling
%
%Christopher Lum
%lum@uw.edu

%Version History
%06/09/24: Created

clear
clc
close all

tic

%Start a blank simscape model using 'ssc_new'

%% User selections
%Battery voltage
Vsupply_V       = 12;

%Loads
ROriginal_ohm   = 5;
RNew_ohm        = 3;


%Fuses
iRatedFuseOriginal_A   = 3;


toc
disp('DONE!')