# Modulation-dataset-generation-in-MATLAB

The code covers a generation of three data subsets:
•	Noisy data – in this data subset a signal is missing. This subset is important in order to check if the system is able to detect absence of signal. A noise is generated as a normal Gaussian noise with unit variance and zero mean. 
•	One signal data – As it is impossible to generate all possible combinations for multi-signals, this subset is important to ensure that for each supported modulation format we have enough samples. 20 modulation formats are supported
•	Multi-signals data – the code supports maximum of 5 transmissions. The multi-signals combinations are chosen randomly. 

Different channel and hardware impairments can be easily manipulated in order to create a dataset for your purpose.
