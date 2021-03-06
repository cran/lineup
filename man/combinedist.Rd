% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/combinedist.R
\name{combinedist}
\alias{combinedist}
\title{Combine distance matrices into a single such}
\usage{
combinedist(..., method = c("median", "mean"))
}
\arguments{
\item{\dots}{Set of distance matrices, as calculated by \code{\link[=distee]{distee()}}
or \code{\link[=disteg]{disteg()}}.}

\item{method}{Indicates whether to summarize using the median or the mean.}
}
\value{
A distance matrix, with class \code{"lineupdist"}.  The individual
IDs are in the row and column names.
}
\description{
Combine multiple distance matrices into a single distance matrix providing
an overall summary
}
\details{
The row and column names of the input distance matrices define the
individual IDs.

If the input distance matrices all have an attribute \code{"denom"} (for
denominator) and \code{method="mean"}, we use a weighted mean, weighted by
the denominators.  This could be used to calculate an overall proportion.
}
\examples{
library(qtl)

# load example data
data(f2cross, expr1, expr2, pmap, genepos)
\dontshow{
keep <- c(1:20, 197, 553, 573, 740, 794, 822, 1474, 1522,
          1591, 1645, 2080, 2643, 2984, 3089, 3672, 4010, 4039,
          4159, 4191, 4198, 4213, 4401, 4544, 4593, 4925)
expr1 <- expr1[,keep]
expr2 <- expr2[,keep]
genepos <- genepos[keep,]}

# calculate QTL genotype probabilities
f2cross <- calc.genoprob(f2cross, step=1)

# find nearest pseudomarkers
pmark <- find.gene.pseudomarker(f2cross, pmap, genepos)

# line up individuals
id1 <- findCommonID(f2cross, expr1)
id2 <- findCommonID(f2cross, expr2)

# calculate LOD score for local eQTL
locallod1 <- calc.locallod(f2cross[,id1$first], expr1[id1$second,], pmark)
locallod2 <- calc.locallod(f2cross[,id2$first], expr2[id2$second,], pmark)

# take those with LOD > 25
expr1s <- expr1[,locallod1>25,drop=FALSE]
expr2s <- expr2[,locallod2>25,drop=FALSE]

# calculate distance between individuals
#     (prop'n mismatches between obs and inferred eQTL geno)
d1 <- disteg(f2cross, expr1s, pmark)
d2 <- disteg(f2cross, expr2s, pmark)

# combine distances
d <- combinedist(d1, d2)

# summary of problem samples
summary(d)

}
\seealso{
\code{\link[=distee]{distee()}}, \code{\link[=disteg]{disteg()}},
\code{\link[=summary.lineupdist]{summary.lineupdist()}}
}
\author{
Karl W Broman, \email{broman@wisc.edu}
}
\keyword{utilities}
