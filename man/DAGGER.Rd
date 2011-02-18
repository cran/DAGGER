\name{DAGGER}
\alias{DAGGER}

\title{
Consensus genetic maps
}
\description{
Integrates the information from multiple linkage maps to create a consensus directed graph, which is then 
linearized to produce a consensus map.
}
\usage{
DAGGER(Maps,Linearize=TRUE,MapFilename=NULL,
       GraphFilename=NULL,GraphDistances=FALSE)
}

\arguments{
\item{Maps}{
List of linkage maps.  Each linkage map is a data frame with two columns: the first column contains
the marker names (as character objects), the second column contains the map positions.
}
\item{Linearize}{
If TRUE (default), DAGGER will linearize the consensus graph provided it is acyclic.
}
\item{MapFilename}{
Specifies the name of the output file for the consensus map.
}
\item{GraphFilename}{
Specifies the name of the output file for the consensus graph.
}
\item{GraphDistances}{
If FALSE (default), the consensus graph is simplified and edge weights are not included in the output file.
}
}
\details{
DAGGER first merges the linkage maps to create a consensus directed graph, in which the vertices are 
marker bins and there is an edge for every map interval between adjacent bins in the linkage maps.

DAGGER next checks whether the consensus graph is acyclic by identifying the strongly connected components.  
Cycles represent ordering conflicts between the linkage maps, which must be resolved by the user before 
DAGGER will produce a consensus map.  DAGGER will write the non-singleton strongly connected components to 
the output GraphFilename in a format for visualization with the software Graphviz dot (\url{http://www.graphviz.org}). 

If the consensus graph is acyclic, it can be written to GraphFilename in one of two ways.  When the
argument GraphDistances == TRUE, all of the edges and their weights are shown, which conveys the 
information used to linearize the graph.  When GraphDistances == FALSE, the edge set is reduced to the 
minimum necessary to show the ordering of the markers, and no edge weights are shown.  This edge reduction preserves
the ordinal equivalency of the consensus graph with the linkage maps (there is a path from vertex v to vertex w 
if and only if bin v precedes bin w in one of the linkage maps).

If Linearize == TRUE (and the consensus graph is acyclic), a linear consensus map is produced that is  
ordinally consistent with the consensus graph and contains minimum error relative to the linkage maps.  The consensus
map can be written to the output MapFilename, arranged by marker bin.  It will also be returned by the function as 
a data frame with two columns: marker name and map position.
}
\value{
If Linearize == TRUE, DAGGER returns either a dataframe containing the consenus map or NULL if 
the linkage maps had ordering conflicts.
If Linearize == FALSE, DAGGER returns a logical value indicating whether the consensus graph was acyclic.
}
\references{
Yap et al. 2003. A graph-theoretic approach to comparing and integrating genetic, physical and 
sequence-based maps. Genetics 165:2235-22247.

Close et al. 2009. Development and implementation of high-throughput SNP genotyping in barley. 
BMC Genomics 10:582. \url{http://www.biomedcentral.com/1471-2164/10/582}

Endelman, J.B. (submitted) New algorithm improves fine structure of the barley consensus SNP map.
}


\examples{

data(Barley5H)

ConsensusMap <- DAGGER(Barley5H)

}


