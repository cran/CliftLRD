meanmoC <-
function (x) 
{
    n <- length(x)
    sum(Mod(x)^2)/(n - 1)
}
