# Architectural-TD-Metrics-Calculator
Modularity is one of the key principles of software design. In order for a software system to be modular, 
it should be organized into modules that are highly coherent internally, whereas at the same time as independent 
from other modules as possible. In this paper we explore coupling and cohesion metrics at the software package level—i.e., 
one of most basic levels of software functional decomposition in object-oriented (OO) systems, with the aim of 
investigating their relation to the technical debt of each package. Current state-of-the-art tools in TD measurement 
are working on the source code level, and the extent to which they can unveil limitations at the architecture level 
(e.g., violations of the modularity principle), has not been explored so far. 
To achieve this goal, we conducted a case study on 1,200 packages retrieved from 20 well-known open source software projects. 
The results of the study suggested that current measures of technical debt are able to identify / predict modules that lack 
modularity, and therefore suffer from Architectural Technical Debt (ATD). The results of the study are discussed both from 
the practitioners’ and researchers’ point of view.
