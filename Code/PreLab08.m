% AER E 344 Pre-Lab 07
% Section 3 Group 3
clear, clc, close all;

u = symunit;

%% Given
mu = 1.8e-5; % [N*s/m^2]
rho = 1.225; % [kg/m^3]
V_inf = 12.8; % [m/s] <-- this is for 10 Hz

c = 0.101; % [m]

Re_transition = 10^5; % []

%% Calculations
x_transition = Re_transition * mu / (rho * V_inf); % [m]
x_transition = ...
    double(separateUnits(unitConvert(x_transition * u.m, u.in))); % [in]
x_laminar = 0 : 0.01 : x_transition; % [in]
x_turbulent = x_transition : 0.01 : 70; % [in]
Re_laminar = rho * V_inf ...
    * double(separateUnits(unitConvert(x_laminar * u.in, u.m))) ...
    / mu; % []
Re_turbulent = rho * V_inf ...
    * double(separateUnits(unitConvert(x_turbulent * u.in, u.m))) ...
    / mu; % []

boundary_layer_laminar = ...
    5.0 * x_laminar ./ sqrt(Re_laminar); % [in]
boundary_layer_turbulent = ...
    0.37 * x_turbulent ./ Re_turbulent.^(1 / 5); % [in]

%% Output
fprintf( ...
    "x_transition = %g in\n", ...
    x_transition);

figure;
plot(x_laminar, boundary_layer_laminar);
hold on;
plot(x_turbulent, boundary_layer_turbulent);
hold off;
title("Boundary Layer Thickness vs. Distance from LE");
xlabel("x [in]");
ylabel("\delta [in]");
grid on;
saveas(gcf, "boundary_layer_thickness.svg");