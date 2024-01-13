%Receive UDP packets
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
numPackets  = 5;
deltaT_s    = 2;
IPAddress   = '127.0.0.1';
portNumber  = 49003;

%% Receive packets
for k=1:numPackets
    disp(['k = ',num2str(k)])
    udpr = dsp.UDPReceiver('RemoteIPAddress',IPAddress,...
        'LocalIPPort',portNumber);

    setup(udpr)
    disp('Setup udpr')

    %Wait to receive packets
    pause(deltaT_s);

    %Read from buffer
    dataReceived = udpr();

    disp('Bytes')
    dataReceived

    disp('convert to char')
    char(dataReceived')

    %Release object
    release(udpr);
end

toc
disp('DONE!')