\name{CliftLRD-package}
\alias{CliftLRD-package}
\alias{CliftLRD}
\docType{package}
\title{
Complex-Valued Wavelet Lifting Estimators of the Hurst Exponent for Irregularly Sampled Time Series
}
\description{
Implementations of Hurst exponent estimators based on the relationship between wavelet lifting scales from complex-valued lifting schemes and wavelet energy.
}
\details{
Package information:
\tabular{ll}{
Package: \tab CliftLRD\cr
Type: \tab Package\cr
Version: \tab 0.1-1\cr
Date: \tab 2018-07-09\cr
License: \tab GPL-2\cr
}

This package exploits a complex-valued wavelet transform for irregularly spaced data to form wavelet-like scale-based energy measures for a time series.  This is then used 
to estimate the Hurst exponent for real- and complex-valued time series. The main routines are \cr\cr
\code{\link{liftHurstC}} and \code{\link{liftHurstCC}}
 
}
\references{
Knight, M. I, and Nunes, M. A. (2018) Long memory estimation for complex-valued time series. \emph{Stat. Comput. (to appear)}. Online First Article: 
DOI \href{https://doi.org/10.1007/s11222-018-9820-8}{10.1007/s11222-018-9820-8}. \cr\cr
For related literature on the lifting methodology adopted in the technique, see\cr\cr
Hamilton, J., Nunes, M. A., Knight, M. I. and Fryzlewicz, P. (2017) Complex-valued lifting and applications. \emph{Technom.},\bold{60} (1), 48--60. \cr\cr
For more information on long-memory processes, see e.g.\cr\cr
Beran, J. et al. (2013) Long-memory processes.  Springer.\cr
Lilly, J. M., Sykulski, A. M., Early, J. J. and Olhede, S. C. (2017) Fractional {B}rownian motion, the {M}at\'ern process, and stochastic modeling of turbulent dispersion. 
\emph{Nonlin. Proc. Geophys.}, \bold{24}, 481--514.
}
\author{
Matt Nunes, Marina Knight

Maintainer: Matt Nunes <nunesrpackages@gmail.com>
}

\keyword{ package }
%\seealso{
%~~ Optional links to other man pages, e.g. ~~
%~~ \code{\link[adlift]{fwtnp}}, \code{\link[nlt]{fwtnpperm}} ~~
%}
