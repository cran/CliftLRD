liftHurstCC <-
function (x, grid = 1:length(x), model = "FGN", ntraj = 50, 
    cutoffs = 0, cut.fine = TRUE, efun = meanmoC, afun = idj, 
    altype = 1, tail = TRUE, normalise = TRUE, level = 0.05, 
    bc = TRUE, vc = TRUE, jsc = TRUE, BHonly = TRUE, ...) 
{
    levvar <- function(nj, max = 5000) {
        z2njh <- sum(1/((0:max) + nj/2)^2)
        v <- z2njh/(log(2))^2
        v
    }
    gj <- function(nj) {
        	bias <- digamma(nj/2)/log(2) - log2(nj/2)
        bias
    }
    if (!is.matrix(x)) {
        x <- matrix(x)
    }
    if (ncol(x) == 2) {
        grid <- x[, 1]
        x <- x[, 2]
    }
    n <- length(x)
    trajmat <- matrix(0, ntraj, n - 2)
    lcu<-length(cutoffs)
    beta <- beta2<-rep(0,lcu)
    betamat <- betamat2<-matrix(0,ntraj,lcu)
    if (bc) {
        cat("doing bias correction...\n")
    }
    if (vc) {
        cat("doing weighted regression...\n")
    }
    if (jsc) {
        cat("doing j* coefficient computation...\n")
    }

### x is now complex, so we will get two sets of complex coeffs

        for (i in 1:ntraj) {
            trajmat[i, ] <- sample(1:n, n - 2, replace = FALSE)
        }
        cat("generated trajectories.\n")
        for (k in 1:ntraj) {
            if ((k%%5) == 0) {
                cat(k, "...")
            }
            xlift <- fwtnppermC(grid, Re(x), mod = trajmat[k, ],...)
		
		W <- xlift$W
#		Gpre = W %*% t(Conj(W))	

            rem <- xlift$removelist	# same as trajmat[k,]
            coeff1 <- W%*%x	#
            coeff2 <- Conj(W)%*%x

	if (normalise) {
 #           coeff1 <- coeff1/sqrt(diag(Gpre))
 #           coeff2 <- coeff2/sqrt(diag(Gpre))
		coeff1 <- coeff1/sqrt(colSums(Mod(W)^2))
		coeff2 <- coeff2/sqrt(colSums(Mod(W)^2))
        }

            scales <- xlift$lengthsremove
            scalesa <- rep(NA, n)
            scalesa[rem] <- scales
            al <- artificial.levels(scales, rem, grid, tail = tail, 
                type = altype)
            levno <- length(al)
            energies <- energies2<-NULL
            scalesx <- NULL
            l2vec <- NULL
            levvec <- NULL
            nj <- sapply(al, length)

	# modify here for complex coeffs
            for (j in 1:levno) {
               		energies[j] <- efun(coeff1[al[[j]]])
               		energies2[j] <- efun(coeff2[al[[j]]])
                scalesx[j] <- afun(scalesa[al[[j]]], j = j)
                if (jsc) {
                  l2vec <- c(l2vec, log2(scalesa[al[[j]]]))
                  levvec <- c(levvec, rep(scalesx[j], times = nj[j]))
                }
            }

            if (jsc) {
                jstarc <- lm(l2vec ~ log2(levvec))$coef[2]
            }
            if (bc) {
                gg <- sapply(nj, gj)
            }
            else {
                gg <- 0
            }
            if (vc) {
               	levw <- 1/sapply(nj, levvar)
            }
            else {
                levw <- rep(1, times = levno)
            }
            for (i in 1:lcu) {
                if (cut.fine) {
                  index <- (1 + cutoffs[i]):levno
                }
                else {
                  index <- 1:(levno - cutoffs[i])
                }
                beta[i] <- lm((log2(energies) - gg)[index] ~ 
                  log2(scalesx[index]), weights = levw[index])$coef[2]
                beta2[i] <- lm((log2(energies2) - gg)[index] ~ 
                  log2(scalesx[index]), weights = levw[index])$coef[2]
                if (jsc) {
                  beta[i] <- beta[i] * jstarc
                  beta2[i] <- beta2[i] * jstarc
                }
            }
#            betamat <- rbind(betamat, beta)
#           betamat2 <- rbind(betamat2, beta2)
		betamat[k,]<-beta
		betamat2[k,]<-beta2
        }
        cat("\n")
        beta <- colMeans(betamat)
        beta2 <- colMeans(betamat2)
        Hs <- Hfrombeta(betamat, model = model)
        Hs2 <- Hfrombeta(betamat2, model = model)
        sds <- apply(Hs, 2, sd)
        H <- colMeans(Hs)
        H2 <-colMeans(Hs2)
        ci <- t(apply(Hs, 2, bootci, level = level))
#        bandH <- cbind(beta, H, sds, ci)
        HH <- mean(c(H,H2))

    if (BHonly) {
        return(HH)
    }
    else {
        return(list(HH = HH, energies = (log2(energies) - 
            gg)[index], scales = log2(scalesx[index])))
    }
}
