\name{fscale}
\alias{fscale}

\title{Standardize the columns of a matrix}

\description{
  Standardize each column in a matrix, so that the columns have mean 0
  and SD 1.
}

\usage{
fscale(x)
}

\arguments{
 \item{x}{A numeric matrix.}
}

\details{
  Missing values (\code{NA}) are ignored and left as is.

  If there is just 1 non-missing value in a column, it is left as is.

  This function uses a one-pass algorithm to calculate the mean and SD,
  which is fast but can show a bit of round-off error.
}

\value{
A matrix of the same form as the input, but with columns transformed to
have mean 0 and SD 1.
}

\author{Karl W Broman, \email{kbroman@biostat.wisc.edu} }

%\references{
%}

\examples{
x <- matrix(1:10, ncol=2)
y <- fscale(x)
}

\seealso{ \code{\link[base]{scale}} }

\keyword{array}