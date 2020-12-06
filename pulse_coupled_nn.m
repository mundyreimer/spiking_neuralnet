% This model is a modified version of Eugene Izhikevich's
% class of pulse-coupled spiking neural networks (PCNN)
% created in 2003 and modified in 2012-2013.

% Includes Experimental WIN55-eCBR & PCP-NMDAR mechanisms
% See README.md for more information.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Excitatory Neurons            Inhibitory Neurons
Ne = 800                        Ni = 200
                                
% Model the rate of PV interneuron death
                                DeathRate = 0; 

% Return an Nx1 column matrix of random entries to 
% give either RS (regular spiking) or CH (chattering)
% cells a random distribution (w/ bias towards RS cells)
re = rand(Ne,1);                ri = rand(Ni,1);

% Time scale of recovery variable u
% Smaller values => slower recovery
% Recovery set at ~0.02
a = [0.02*ones(Ne,1);           0.02+0.08*ri];

% Sensitivity of recovery variable
% Greater values couple v & u more strongly
% These lead to sub-threshold osciallations ~0.2
b = [0.2*ones(Ne,1);            0.25-0.05*ri];

% Afterspike RESET value of membrane potential v
% Caused by *fast* high-threshold K+ conductances ~65 mV
c = [-65+15*re.^2;              -65*ones(Ni,1)];

% Afterspike RESET value of membrane recovery variable u
% Caused by *slow* high-threshold Na+ & K+ conductances ~2
% Greater d yields large spike hyperpolarizations
% Thus, increases in longer interspike period occur
d = [8-6*re.^2;                 2*ones(Ni,1)];

% Synaptic Weight Matrix
% Firing of jth neuron changes variable Vi by weight Sij
% Multiply the excitatory connections by 0.5 to make
% them half as weak as inhibitory connections
S = [0.5*rand(Ne+Ni,Ne)];
rand(Ne+Ni, Ni);

% Sets initial values of v, where v is the membrane 
% potential in mV
v = -65*ones(Ne+Ni,1);

% Sets initial values of u, where u is the membrane
% recovery variable
% Activates K+, Inactivates Na+ ionic currents so to 
% provide negative feedback to v
u = b.*v;

% Provides stacked column matrices to plot spike
% timings.  These take the form of n-dimensional
% matrices because they will be different row sizes 
firings=[];

timeseries = zeros(Ne, 1000);

% Represents the build up of extracellular eCB   
eCBLongTerm = [zeros(Ne, Ne)];

% eCB tolerance effect that nullifies eCB inhibition
% Sets a counter for total # times specific receptor
% activated (simplistic mechanism for now)
eCBReceptorActivationCounter = [zeros(Ne, Ne)];

% Arbitrarily chosen rate of eCB degradation rates of 
% the enzymes FAAH & MGL (tighten this parameter later)
eCBDecayRate = 0.05;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Simulation Code

% Simulation of 't' ms
for t = 1:1000

% Arbitrarily chosen constant for now for death rate
DeathRate = DeathRate + 0.2;

% Noisy thalamic input
% Add direct current value here
I = [5*randn(Ne,1);             2*randn(Ni,1)];

% Give indices of spikes
% Create a single column vector of n-rows that fired
% ie - went over 30, the apex
fired = find(v >= 30);

% Give indices of post excitatory neurons that 
% were depolarized
depolarized_excitatory=find(v(Ne:1,Ne:1) >=1);

% Keep adding the previous whole firings stack
% to the new results simulation number and 2nd number
% represents newly fired results
firings = [firings; t+0*fired, fired];

% Reset those values in matrix v that fired to normal 
% values c (our slow conductances)
v(fired) = c(fired);

% Set those values in matrix u that fired to values
% of matrix u + matrix d (fast conductances)
u(fired) = u(fired) + d(fired);

% Add thalamic input each time to summed matric S
% values that fired
I = I + sum(S(:, fired), 2);

% step 0.5 ms (a dynamic value)
v = v + 0.5*(0.04*v.^2 + 5*v + 140 - u + I);

% Stability
u = u + a.*(b.v-u);

% Represent the transient eCB effect
eCBShortTerm = [zeros(Ne, Ne)];

% Set all values of matrix eCBShortTerm (at indices
% of v that depolarized) to the values of v (indices
% that depolarized)
eCBShortTerm(depolarized_excitatory) = v(depolarized_excitatory);

% Update values of matrix eCBLongTerm to 
% continually add older values (with decay rate
% applied to them) + newer values
eCBLongTerm = (eCBDecayRate.*eCBLongTerm) + eCBShortTerm;

% Create a new matrix that continually stores ones at indices
% that were depolarized
eCBReceptorActivationCounter(depolarized_excitatory) = 
eCBReceptorActivationCounter(depolarized_excitatory) + 
(eCBShortTerm(depolarized_excitatory). / 
eCBShortTerm(depolarized_excitatory));

% Find those indices of previous matrix whose receptor
% activation counter exceeds 10 (arbitrarily chosen number for right now)
eCBReceptor Hypofunctioning = find(eCBReceptorActivationCounter >= 10);

% Silence those LongTerm receptors which are activated 10 times
% by multiplying them by zero
eCBLongTerm(eCBReceptorHypofunctioning) = 0.*eCBLongTerm(eCBReceptorHypofunctioning);

% Prevent the multiplication of a zero matrix S at next step
totaldepolarized = find(eCBLongTerm >= 1);

% Set all values that were depolarized throughout total time
% to their inverses.
% The greater the strength of depolarization, the greater
% the weights decrease.
eCBWeightChange = 1./eCBLongTerm(totaldepolarized);

S(totaldepolarized) = S(totaldepolarized) + 
                      S(totaldepolarized). *
                      eCBWeightChange;

act_pattern = (v >= 30);
time_series(:, t) = act_pattern(1:Ne, :);

end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plotting Data

pop_rate = mean(time_series, 1);
spectrum(fft(pop_rate'));

plot(firings(:,1), firings(:,2), '.');
figure;
plot(pop_rate);
figure;
[y x] = get_spectrum(pop_rate', .001);
plot(x,y);

