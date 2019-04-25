

Decred = read.csv("CMC-Decred-201719.csv", stringsAsFactors = FALSE)
Decred$project = "Decred"

BAT = read.csv("CMC-BAT-201719.csv", stringsAsFactors = FALSE)
BAT$project = "BAT"

Bitcoin = read.csv("CMC-Bitcoin-201719.csv", stringsAsFactors = FALSE)
Bitcoin$project = "Bitcoin"

Dash = read.csv("CMC-Dash-201719.csv", stringsAsFactors = FALSE)
Dash$project = "Dash"

Doge = read.csv("CMC-Doge-201719.csv", stringsAsFactors = FALSE)
Doge$project = "Doge"

Ethereum = read.csv("CMC-Ethereum-201719.csv", stringsAsFactors = FALSE)
Ethereum$project = "Ethereum"

Litecoin = read.csv("CMC-Litecoin-201719.csv", stringsAsFactors = FALSE)
Litecoin$project = "Litecoin"

Monero = read.csv("CMC-Monero-201719.csv", stringsAsFactors = FALSE)
Monero$project = "Monero"

Nano = read.csv("CMC-Nano-201719.csv", stringsAsFactors = FALSE)
Nano$project = "Nano"

Ripple = read.csv("CMC-Ripple-201719.csv", stringsAsFactors = FALSE)
Ripple$project = "Ripple"

zcash = read.csv("CMC-zcash-201719.csv", stringsAsFactors = FALSE)
zcash$project = "Zcash"

df = rbind(BAT, Bitcoin, Dash, Decred, Doge, Ethereum, Litecoin, Monero, Nano, Ripple, zcash)
nrow(df)

#volatility as % change between open and close

df$daychange = df$Open. - df$Close..
df$daychange_per = (df$daychange/df$Open.) * 100

#deal with Date
df$date = as.POSIXlt(df$Date, format = "%b %d, %Y")


#graph daychange_per as line, facet wrap by project, fixed Y axes
p.daily.volatility = ggplot(df, aes(x = date, y = daychange_per))+
  geom_line()+
  facet_wrap(~project, ncol = 1)

ggsave("daily-pricechange-2years.png", height = 12, width = 5)


#crosstab of mean and sd daychange_per by project

write.csv(with(df, tapply(daychange_per, list(project = project), mean) ), file = "daychange-mean-2yr.csv")
write.csv(with(df, tapply(daychange_per, list(project = project), sd) ), file = "daychange-sd-2yr.csv")

df1year = df[df$date > 1524664336,]

write.csv(with(df1year, tapply(daychange_per, list(project = project), mean) ), file = "daychange-mean-1yr.csv")
write.csv(with(df1year, tapply(daychange_per, list(project = project), sd) ), file = "daychange-sd-1yr.csv")
