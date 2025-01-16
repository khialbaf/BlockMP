زبان:
پارسی
|
[English](./README.md)

# اندیکاتور بلاک
اندیکاتور بلاک برگرفته از ایده ی جناب آقای مصطفی پازوکی بوده و با توجه به درخواست چند تن از دوستان فقط توسط
[اینجانب](https://mjst219.github.io/profile)
،برای استفاده در چند سکو طراحی و توسعه داده شده.
<br/>
به شخصه از این روش استفاده نمی کنم ولی امیدوارم این اندیکاتور برای دوستانی که از این روش تحلیلی استفاده می کنند، راه گشا باشه.

|زبان برنامه نویسی|سکو|نسخه|لینک دانلود|کد منبع|
|-|-|-|-|-|
|MQL5|MetaTrader5|1.00|[دانلود](https://github.com/mjst219/BlockMP/releases/download/v1.00/BlockMP.ex5)|[نمایش](https://github.com/mjst219/BlockMP/blob/main/MQL5/BlockMP.mq5)|
|MQL4|MetaTrader4|1.00|[دانلود](https://github.com/mjst219/BlockMP/releases/download/v1.00/BlockMP.ex4)|[نمایش](https://github.com/mjst219/BlockMP/blob/main/MQL4/BlockMP.mq4)|
|Pine Script|TradingView|1.00|[نمایش](#pinescript-code)|[نمایش](#pinescript-code)|


## PineScript Code
```s
// This Pine Script™ code is subject to the terms of the Mozilla Public License 2.0 at https://mozilla.org/MPL/2.0/
// © mjst219

//@version=6
indicator("Block_MP",max_boxes_count=333,overlay=true)

color cUp=input(color.rgb(0,255,0,87),'Color block Up: ','Set the ascending block color')
color cDown=input(color.rgb(255,0,0,87),'Color block Down: ','Set the color of the descending block')

tf=timeframe.in_seconds()

var box lastBox=na

c=cDown
if open<close
	 c:=cUp
b=box.new(bar_index,high,bar_index,low,c,0,bgcolor=c)
lastBox.set_right(bar_index)
if lastBox.get_top()>=close and lastBox.get_bottom()<=close
	 box.delete(b)
	 if lastBox.get_top()<high
		  lastBox.set_top(high)
	 if lastBox.get_bottom()>low
		  lastBox.set_bottom(low)
else
	 lastBox:=b
```