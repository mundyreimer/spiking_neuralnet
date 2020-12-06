# Pulse-Coupled Spiking Neural Network (PCNN)

Built a computational model of induced alteration of synaptic activity in medial pre-frontal cortex with mechanistic implications for schizophrenia & psychosis as part of my undergraduate honors thesis project (see [paper here](https://www.researchgate.net/publication/325676679_Computational_Model_of_Induced_Alteration_of_Synaptic_Activity_in_Medial_Pre-Frontal_Cortex_Mechanistic_Implications_for_Schizophrenia_Psychosis)).

This model is a modified version of [Eugene Izhikevich](http://www.scholarpedia.org/article/User:Eugene_M._Izhikevich)'s class of [pulse-coupled](https://en.wikipedia.org/wiki/Pulse-coupled_networks) [spiking neural networks](https://en.wikipedia.org/wiki/Spiking_neural_network) (PCNN) created in 2003 (see original [paper and code here](https://www.izhikevich.org/publications/spikes.htm)) and modified in 2012-2013. Includes additional experimental [WIN55](https://en.wikipedia.org/wiki/WIN_55,212-2)-[endocannabinoid receptor](https://en.wikipedia.org/wiki/Cannabinoid_receptor) & [PCP](https://en.wikipedia.org/wiki/Phencyclidine)-[NMDA receptor](https://en.wikipedia.org/wiki/NMDA_receptor) mechanisms.

---
## Background

Cannabis abuse during key brain developmental stages such as adolescence has been previously shown to be associated with increased likelihood of schizophrenic symptoms and psychosis related diseases. Experimental results also suggest that various forms of synaptic activity and spiking patterns in the medial pre-frontal cortex (mPFC) regulated by transmission of GABA mediated inhibitory pathways coupled with excitatory glutamate pathways will also be subject to disruption due to dependence upon the endocannabinoid signaling pathway. 

This project investigates the role of endocannabinoid signaling on synaptic activity and neuronal spiking dynamics in the mPFC of a glutamate receptor (NMDAR) hypofunction and endocannabinoid receptor (CB1R) hyperfunction mouse models. The Korzus laboratory investigates the biochemical mechanisms of CB1R-mediated plasticity while recording neuronal activity in acute brain slices. 

A simplified proposed model was then built and simulated through MATLAB programming as a network consisting of 1,000 randomly connected spiking cortical neurons in real time. 

Results demonstrate that although the model was able to reproduce a wide variety of biological neuronal behavior such as spiking, bursting, and ultimately alpha and gamma band rhythms, it did not illustrate the full range of expected disruptions in spiking dynamics, indicating a further need to create greater biophysically plausible networks. These competing mechanistic models will be of help in testing the theoretical road-maps of prefrontal cortex dependent cognitive functions.

---

## Context

This was done at the [Hungarian Academy of Sciences](https://en.wikipedia.org/wiki/Hungarian_Academy_of_Sciences) as part of the [Theoretical Neuroscience and Complex Systems group](http://cneuro.rmki.kfki.hu/) ran by Dr. [Péter Érdi](https://en.wikipedia.org/wiki/P%C3%A9ter_%C3%89rdi) and mentored by both Dr. [Zoltán Somogyvári](https://www.researchgate.net/profile/Zoltan_Somogyvari) and [Mihály Bányai](https://www.kyb.tuebingen.mpg.de/person/103805/2549).

Modeling was done with the help of my electrophysiological work in endocannabinoid signaling mechanisms through recording and analyzing the electrical activity of populations of neurons in the brain slices of mice as part of the [Korzus lab](https://korzuslab.ucr.edu/research) under the excellent mentorship of Dr. [Jonny Lovelace](https://www.researchgate.net/profile/Jonathan_Lovelace). 

Wrote my undergraduate honors thesis as part of both of the aforementioned groups.