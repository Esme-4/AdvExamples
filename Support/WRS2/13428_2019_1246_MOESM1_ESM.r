## Supplementary materials for the article: Robust Statistical Methods in R Using the WRS2 Package.


## -------------------------- Robust Measures of Location, Scale, and Dependence --------------------------------------
## ---- trimmed mean
library("WRS2")
timevec <- c(77, 87, 88, 114, 151, 210, 219, 246, 253, 262, 296, 299,
             306, 376, 428, 515, 666, 1310, 2611)
mean(timevec, 0.1)
trimse(timevec, 0.1)
mean(timevec)
sd(timevec)/sqrt(length(timevec))

## ----- median
median(timevec)
msmedse(timevec)

## ---- Winsorized mean/variance
winmean(timevec, 0.1)
winse(timevec, 0.1)
winvar(timevec, 0.1)

## ---- M-estimators
mest(timevec)
mestse(timevec)

## ---- robust correlations 
library("reshape")
hangctr <- subset(hangover, subset = group == "alcoholic")
hangwide <- cast(hangctr, id ~ time, value = "symptoms")[,-1]
colnames(hangwide) <- paste("Time", 1:3)
winall(hangwide)

library("GGally")
ggpairs(hangwide)

ct1 <- subset(hangover, subset = (group == "control" & time == 1))$symp
ct2 <- subset(hangover, subset = (group == "control" & time == 2))$symp
at1 <- subset(hangover, subset = (group == "alcoholic" & time == 1))$symp
at2 <- subset(hangover, subset = (group == "alcoholic" & time == 2))$symp
set.seed(123)
twocor(ct1, ct2, at1, at2, corfun = "pbcor", beta = 0.15)

## ------------------------- Robust Two-Sample Testing Strategies -------------------------------
## ---- Yuen's test
library("ggplot2")
SpainGer <- subset(eurosoccer, League == "Spain" | League == "Germany")
SpainGer <- droplevels(SpainGer)
ggplot(SpainGer, aes(x = League, y = GoalsGame)) + 
  geom_boxplot(outlier.shape = NA) +
  geom_jitter(position = position_jitter(0.1))

yuen(GoalsGame ~ League, data = SpainGer)
akp.effect(GoalsGame ~ League, data = SpainGer)

set.seed(123)
yuen.effect.ci(GoalsGame ~ League, data = SpainGer)

## ----- M-estimator tests
set.seed(123)
pb2gen(GoalsGame ~ League, data = SpainGer, est = "median")
pb2gen(GoalsGame ~ League, data = SpainGer, est = "onestep")

## ---- quantile comparisons
set.seed(123)
fitqt <- qcomhd(GoalsGame ~ League, data = SpainGer, 
  q = c(0.1, 0.25, 0.5, 0.75, 0.95), nboot = 500)
fitqt

## ----- two dependent groups 
library("MASS")
anorexiaFT <- subset(anorexia, subset = Treat == "FT")
anorexiaLong <- reshape(anorexiaFT, varying = list(2:3), direction = "long", v.names = "weight")
anorexiaLong$time <- factor(anorexiaLong$time, labels = c("prior", "post"))
gp <- ggplot(anorexiaLong, aes(x = time, y = weight, colour = as.factor(id), group = id))
gp + geom_point(size = 1) + geom_line() + theme(legend.position="none") 

library("MASS")
anorexiaFT <- subset(anorexia, subset = Treat == "FT")
with(anorexiaFT, yuend(Prewt, Postwt))

## ----- dependent quantile comparisons
set.seed(123)
with(anorexiaFT, Dqcomhd(Prewt, Postwt, q = c(0.25, 0.5, 0.75)))

## ----- discrete distribution comparisons
g1 <- c(2, 4, 4, 2, 2, 2, 4, 3, 2, 4, 2, 3, 2, 4, 3, 2, 2, 3, 5, 5, 2, 2)
g2 <- c(5, 1, 4, 4, 2, 3, 3, 1, 1, 1, 1, 2, 2, 1, 1, 5, 3, 5)
binband(g1, g2, KMS = TRUE)



## ------------------------- One-Way Robust Testing Strategies ------------------------------------------
## ---- one-way trimmed means comparisons
anorexia$Wdiff <- anorexia$Postwt - anorexia$Prewt
ggplot(anorexia, aes(x = Treat, y = Wdiff)) + xlab("group") + ylab("weight difference") + 
  geom_boxplot(outlier.shape = NA) +
  geom_jitter(position = position_jitter(0.1))

anorexia$Wdiff <- anorexia$Postwt - anorexia$Prewt
t1way(Wdiff ~ Treat, data = anorexia)

## ----- linear contrasts
lincon(Wdiff ~ Treat, data = anorexia)

## ---- one-way median comparisons
set.seed(123)
med1way(Wdiff ~ Treat, data = anorexia)


## ---- quantile ANOVA
set.seed(123)
fitqa <- Qanova(Wdiff ~ Treat, data = anorexia,
   q = c(0.25, 0.5, 0.75))
fitqa

## ------------------------ Robust Two-Way and Three-Way Comparisons ------------------------------
## ---- two-way trimmed means comparisons
goggle.agg <- with(goggles, aggregate(attractiveness, list(gender = gender, alcohol = alcohol), mean, trim = 0.20))
goggle.agg$tse <- as.vector(with(goggles, by(attractiveness, list(gender = gender, alcohol = alcohol), trimse, tr = 0.20)))
gp <- ggplot(goggle.agg, aes(x = gender, y = x, colour = alcohol, group = alcohol)) + ylab("attractiveness")
gp + geom_line() + geom_point(aes(shape = alcohol), size = 3) + 
   geom_errorbar(aes(ymax = x + tse, ymin = x - tse), width = 0.1) 
gp <- ggplot(goggle.agg, aes(x = alcohol, y = x, colour = gender, group = gender)) + ylab("attractiveness")
gp + geom_line() + geom_point(aes(shape = gender), size = 3) + 
   geom_errorbar(aes(ymax = x + tse, ymin = x - tse), width = 0.1) 

goggles$alcohol <- relevel(goggles$alcohol, ref = "None")
t2way(attractiveness ~ gender*alcohol, data = goggles)

postgoggle <- mcp2atm(attractiveness ~ gender*alcohol, data = goggles)
postgoggle$contrasts

postgoggle$contrasts
postgoggle


## ---- other M-estimators
set.seed(123)
med2way(attractiveness ~ gender*alcohol, data = goggles)
mcp2a(attractiveness ~ gender*alcohol, data = goggles, est = "median")
pbad2way(attractiveness ~ gender*alcohol, data = goggles, est = "mom")
mcp2a(attractiveness ~ gender*alcohol, data = goggles, est = "mom")


## ---- three-way trimmed mean comparisons
optpes.male <- subset(swimming, Sex == "Male")
optpes.female <- subset(swimming, Sex == "Female")

agg.male <- with(optpes.male, aggregate(Ratio, list(Optim = Optim, Event = Event), mean, trim = 0.20))
agg.male$tse <- as.vector(with(optpes.male, by(Ratio, list(Optim = Optim, Event = Event), trimse, tr = 0.20, simplify = TRUE)))
gp <- ggplot(agg.male, aes(x = Event, y = x, colour = Optim, group = Optim)) + ylab("Ratio")
gp + geom_line() + geom_point(aes(shape = Optim), size = 3) + 
   geom_errorbar(aes(ymax = x + tse, ymin = x - tse), width = 0.1) + ggtitle("Interaction Plot Men")

agg.female <- with(optpes.female, aggregate(Ratio, list(Optim = Optim, Event = Event), mean, trim = 0.20))
agg.female$tse <- as.vector(with(optpes.female, by(Ratio, list(Optim = Optim, Event = Event), trimse, tr = 0.20, simplify = TRUE)))
gp <- ggplot(agg.female, aes(x = Event, y = x, colour = Optim, group = Optim)) + ylab("Ratio")
gp + geom_line() + geom_point(aes(shape = Optim), size = 3) + 
   geom_errorbar(aes(ymax = x + tse, ymin = x - tse), width = 0.1) + ggtitle("Interaction Plot Women")

t3way(Ratio ~ Optim*Sex*Event, data = swimming)


## ------------------------------- Repeated Measurements and Mixed ANOVA Designs -----------------------
## ---- robust repeated measurements ANOVA
ind <- rep(1:6, each = 20)
symlist <- split(hangover$symptoms, ind)[c(1,4,2,5,3,6)]
gtmeans <- sapply(symlist, mean, trim = 0.2)
plot(1:3, type = "n", ylim = c(0, max(hangover$symptoms) + 10), xaxt = "n", xlab = "Time Points",
     ylab = "Number of Symptoms", main = "Hangover Data")
axis(1, at = 1:3, labels = paste("Time", 1:3))
for (i in 1:6) points(jitter(rep(ceiling(i/2), 20)), symlist[[i]], cex = 0.6, col = ((i %% 2) + 1))
legend("topleft", legend = c("control", "alcoholic"), lty = 1, col = 1:2)
lines(1:3, gtmeans[c(1, 3, 5)], col = 1, type = "b", pch = 19)
lines(1:3, gtmeans[c(2, 4, 6)], col = 2, type = "b", pch = 19)

hangoverC <- subset(hangover, subset = group == "control")
with(hangoverC, rmanova(y = symptoms, groups = time, block = id))

with(hangoverC, rmmcp(y = symptoms, groups = time, block = id))

## ---- mixed designs
bwtrim(symptoms ~ group*time, id = id, data = hangover)

set.seed(123)
sppbb(errorRatio ~ group*essay, id, data = essays)

set.seed(123)
sppba(errorRatio ~ group*essay, id, data = essays, avg = FALSE)

set.seed(123)
sppba(errorRatio ~ group*essay, id, data = essays)

set.seed(123)
sppbi(errorRatio ~ group*essay, id, data = essays)

## ---------------------------------- Robust ANCOVA -------------------------------------
## ---- interval smoother
library("colorspace")
colpal <- c(rainbow_hcl(5, c = 100))
pal <- palette(colpal)
attach(chile)
op <- par(mfrow = c(2,1))
plot(length, heat, pch = 20, col = "gray", main = "Chile Smoothing I", xlab = "Length", ylab = "Heat")
fitmean <- runmean(length, heat)
fitmest <- rungen(length, heat)
fitmed <- rungen(length, heat, est = "median")
fitbag <- runmbo(length, heat, est = "onestep")
orderx <- order(length)
lines(length[orderx], fitmean[orderx], lwd = 2, col = 1)
lines(length[orderx], fitmest[orderx], lwd = 2, col = 2)
lines(length[orderx], fitmed[orderx], lwd = 2, col = 3)
lines(length[orderx], fitbag[orderx], lwd = 2, col = 4)
legend("topright", legend = c("Trimmed Mean", "MOM", "Median", "Bagged Onestep"), col = 1:4, lty = 1)
plot(length, heat, pch = 20, col = "gray", main = "Chile Smoothing II", xlab = "Length", ylab = "Heat")
fitmean1 <- runmean(length, heat, fr = 0.2)
fitmean2 <- runmean(length, heat, fr = 0.5)
fitmean3 <- runmean(length, heat, fr = 1)
fitmean4 <- runmean(length, heat, fr = 5)
orderx <- order(length)
lines(length[orderx], fitmean1[orderx], lwd = 2, col = 1)
lines(length[orderx], fitmean2[orderx], lwd = 2, col = 2)
lines(length[orderx], fitmean3[orderx], lwd = 2, col = 3)
lines(length[orderx], fitmean4[orderx], lwd = 2, col = 4)
legend("topright", legend = c("f = 0.2", "f = 0.5", "f = 1", "f = 5"), col = 1:4, lty = 1)
par(op)
palette(pal)
detach(chile)

## ---- robust ANCOVA
comppts <- c(18, 70, 80, 90, 100, 110)
fitanc <- ancova(Posttest ~ Pretest + Group, fr1 = 0.3, fr2 = 0.3,
  data = electric, pts = comppts)
fitanc

plot(electric$Pretest, electric$Posttest, col = rep(1:2, each = 96), pch = 1, cex = 0.8,
      xlab = "Pretest Score", ylab = "Posttest Score", main = "TV Show ANCOVA")
eltr <- subset(electric, subset = Group == "treatment")
elct <- subset(electric, subset = Group == "control")
ordtr <- order(eltr$Pretest)
lines(eltr$Pretest[ordtr], fitanc$fitted.values$treatment[ordtr], col = 1, lwd = 2)
abline(lm(eltr$Posttest ~ eltr$Pretest), col = 1, lty = 2)
ordct <- order(elct$Pretest)
lines(elct$Pretest[ordct], fitanc$fitted.values$control[ordct], col = 2, lwd = 2)
abline(lm(elct$Posttest ~ elct$Pretest), col = 2, lty = 2)
abline(v = comppts, lty = 2, col = "gray")
legend(30, 120, legend = c("treatment", "control"), lty = 1, col = 1:2)


## ---------------------------- Robust Mediation Analysis -------------------
## ---- standard mediator model
library("mediation")
fit.mx <- lm(Esteem ~ MatCare, data = Leerkes)
fit.yxm <- lm(Efficacy ~ MatCare + Esteem, data = Leerkes)
set.seed(123)
fitmed <- mediation::mediate(fit.mx, fit.yxm, treat = "MatCare",
  mediator = "Esteem", sims = 999, boot = TRUE, boot.ci.type = "bca")
summary(fitmed)

## ---- robust mediatior model
set.seed(123)
with(Leerkes, ZYmediate(MatCare, Efficacy, Esteem, nboot = 2000))

