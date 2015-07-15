---
title: "Reproducible Research: Peer Assessment 1"
output: 
  html_document:
    keep_md: true
---


## Loading and preprocessing the data


```r
data <- read.csv("activity.csv")
data$date <- as.Date(data$date)
```

## What is mean total number of steps taken per day?

Calculate the total number of steps taken per day


```r
data2 <- aggregate(. ~ date, sum, data=data, na.action=na.omit)
data2 <- data2[-3]
head(data2)
```

```
##         date steps
## 1 2012-10-02   126
## 2 2012-10-03 11352
## 3 2012-10-04 12116
## 4 2012-10-05 13294
## 5 2012-10-06 15420
## 6 2012-10-07 11015
```

Make a histogram of the total number of steps taken each day


```r
hist(data2$steps, col="steelblue", breaks=20)
```

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-3-1.png) 

Calculate and report the mean and median of the total number of steps taken per day


```r
paste("mean: ", mean(data2$steps))
```

```
## [1] "mean:  10766.1886792453"
```

```r
paste("median: ", median(data2$steps))
```

```
## [1] "median:  10765"
```


## What is the average daily activity pattern?

Make a time series plot (i.e. type = "l") of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all days (y-axis)


```r
data3 <- aggregate(. ~ interval, mean, data=data, na.action=na.omit)
plot(data3$interval, data3$steps, type="l")
```

![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-5-1.png) 

Which 5-minute interval, on average across all the days in the dataset, contains the maximum number of steps?


```r
maxindex <- which.max(data3$steps)
paste("max interval: ", data3[maxindex, 1])
```

```
## [1] "max interval:  835"
```
## Imputing missing values

Calculate and report the total number of missing values in the dataset (i.e. the total number of rows with NAs)


```r
sum(is.na(data$steps))
```

```
## [1] 2304
```

Devise a strategy for filling in all of the missing values in the dataset. The strategy does not need to be sophisticated. Use the mean. Create a new dataset that is equal to the original dataset but with the missing data filled in.


```r
data4 <- data
data4$steps[is.na(data4$steps)] <- mean(data4$steps, na.rm = T)
```

Make a histogram of the total number of steps taken each day and Calculate and report the mean and median total number of steps taken per day. Do these values differ from the estimates from the first part of the assignment? What is the impact of imputing missing data on the estimates of the total daily number of steps?


```r
data5 <- data4
data5 <- aggregate(. ~ date, sum, data=data5)
hist(data5$steps, col="steelblue", breaks=20)
```

![plot of chunk unnamed-chunk-9](figure/unnamed-chunk-9-1.png) 

```r
paste("mean: ", mean(data5$steps))
```

```
## [1] "mean:  10766.1886792453"
```

```r
paste("median: ", median(data5$steps))
```

```
## [1] "median:  10766.1886792453"
```

We see see that by replacing the NA values the median equals the mean. It is therefore not skewed.

## Are there differences in activity patterns between weekdays and weekends?

Create a new factor variable in the dataset with two levels – “weekday” and “weekend” indicating whether a given date is a weekday or weekend day.


```r
data4$weekdays <- weekdays(data4$date)
data4$type[(data4$weekdays == "Saturday" | data4$weekdays == "Sunday")] <- "weekend"
data4$type[!(data4$weekdays == "Saturday" | data4$weekdays == "Sunday")] <- "weekdays"
```

Make a panel plot containing a time series plot (i.e. type = "l") of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all weekday days or weekend days (y-axis).


```r
weekdays <- data4[data4$type=="weekdays", 1:3]
weekend <- data4[data4$type=="weekend", 1:3]
weekdays2 <- aggregate(. ~ interval, mean, data=weekdays)
weekend2 <- aggregate(. ~ interval, mean, data=weekend)
par(mfrow = c(2, 1))
plot(weekdays2$interval, weekdays2$steps, type="l")
plot(weekend2$interval, weekend2$steps, type="l")
```

![plot of chunk unnamed-chunk-11](figure/unnamed-chunk-11-1.png) 
