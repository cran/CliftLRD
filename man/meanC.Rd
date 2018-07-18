\name{meanC}
\alias{meanC}
\alias{meanmoC}
%\alias{meanmoCd}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Functions to perform summary calculations of wavelet scales and energies resulting from complex-valued lifting transforms.
}
\description{
To estimate the slope of the relationship between wavelet scale and wavelet energy, choices have to be made as to how these quantities are computed.  Examples of these choices are 
the functions listed here.
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
meanC(x) 
meanmoC(x) 
%meanmoCd(x) 
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{a vector of values, representing the integrals or detail coefficients in a particular artificial level}
%  \item{j}{the index of the artificial level.
%%     ~~Describe \code{j} here~~
%}
}
\value{
A numeric value corresponding to the average (modulus) squared detail coefficient or scaled average (modulus squared detail coefficient.  
}
\references{
Knight, M. I and Nunes, M. A. (2018) Long memory estimation for complex-valued time series. \emph{Stat. Comput. (to appear)}. Online First Article: 
DOI \href{https://doi.org/10.1007/s11222-018-9820-8}{10.1007/s11222-018-9820-8}.
}

\author{
Matt Nunes, Marina Knight
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
\code{\link{liftHurstC}}, 
\code{\link{liftHurstCC}}
}
\examples{

x<-rnorm(50,30,2)
y<-rnorm(50,30,2)

z<-complex(real=x,imaginary=y)

# calculate the average squared value of complex-valued vector (i.e. energy)

meanC(z)

}
\keyword{manip}
