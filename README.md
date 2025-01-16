Language:
[پارسی](./README-fa.md)
|
English

# Block Indicator
The block marker is from the idea of ​​Mr. Mustafa Pazuki and at the request of several friends, it was designed and developed by
[me](https://mjst219.github.io/profile)
for use on several platforms.
<br/>
Personally, I don't use this method, but I hope this indicator will be helpful for friends who use this analytical method.

|Programming Language|Platform|Version|Download Link|Source Code|
|-|-|-|-|-|
|MQL5|MetaTrader5|1.00|[Download](https://github.com/mjst219/BlockMP/releases/download/v1.00/BlockMP.ex5)|[View](https://github.com/mjst219/BlockMP/blob/main/MQL5/BlockMP.mq5)|
|MQL4|MetaTrader4|1.00|[Download](https://github.com/mjst219/BlockMP/releases/download/v1.00/BlockMP.ex4)|[View](https://github.com/mjst219/BlockMP/blob/main/MQL4/BlockMP.mq4)|
|Pine Script|TradingView|1.00|Soon|Soon|

<table>
	<thead>
		<tr>
			<th>Programming Language</th>
			<th>Platform</th>
			<th>Version</th>
			<th>Download Link</th>
			<th>Source Code</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>MQL5</td>
			<td>MetaTrader5</td>
			<td>1.00</td>
			<td><a href="https://github.com/mjst219/BlockMP/releases/download/v1.00/BlockMP.ex5">Download</a></td>
			<td><a href="https://github.com/mjst219/BlockMP/blob/main/MQL5/BlockMP.mq5">View</a></td>
		</tr>
		<tr>
			<td>MQL4</td>
			<td>MetaTrader4</td>
			<td>1.00</td>
			<td><a href="https://github.com/mjst219/BlockMP/releases/download/v1.00/BlockMP.ex4">Download</a></td>
			<td><a href="https://github.com/mjst219/BlockMP/blob/main/MQL4/BlockMP.mq4">View</a></td>
		</tr>
		<tr>
			<td>MQL4</td>
			<td>MetaTrader4</td>
			<td>1.00</td>
			<td colspan="2" align="center"><a href="https://github.com/mjst219/BlockMP/edit/main/README.md#pinescript-code">Download</a></td>
		</tr>
	</tbody>
</table>


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
