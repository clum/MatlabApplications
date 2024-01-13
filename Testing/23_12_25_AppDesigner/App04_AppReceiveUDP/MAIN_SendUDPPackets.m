%Send UDP packets
%
%Christopher Lum
%lum@uw.edu

%Version History
%01/04/23: Created

clear
clc
close all

ChangeWorkingDirectoryToThisLocation();

tic

%% User settings
numPackets  = 50;
deltaT_s    = 1;
IPAddress   = '127.0.0.1';
portNumber  = 49003;

%% Send packets
for k=1:numPackets
    disp(['Now sending packet ',num2str(k)])
    SendStringOverUDP(num2str(k),IPAddress,portNumber)
    pause(deltaT_s);
end

toc
disp('DONE!')