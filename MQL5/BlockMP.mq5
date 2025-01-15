//+------------------------------------------------------------------+
//|                                                      BlockMP.mq5 |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                              https://github.com/khialbaf/BlockMP |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://github.com/khialbaf/BlockMP"
#property version   "1.00"
#property indicator_chart_window

struct struct_block{
   datetime time;
   double high;
   double low;
   color clr;
};
struct_block block={0,0,0};

input int tlfc=3333;//The last few candles?
input color blockUpClr=C'0,123,0';//The color of ascending blocks
input color blockDownClr=C'123,0,0';//The color of descending blocks

string objBN=MQLInfoString(MQL_PROGRAM_NAME)+"_";

int OnInit(){
   restart();
   return(INIT_SUCCEEDED);
}
int OnCalculate(const int rates_total,const int prev_calculated,const datetime &time[],const double &open[],const double &high[],const double &low[],const double &close[],const long &tick_volume[],const long &volume[],const int &spread[]){
   int s=prev_calculated;
   if(prev_calculated==0){
      restart();
      s=rates_total-tlfc;
      if(s<=0)
         s=1;
   }
   
   for(int i=s-1;i<rates_total;i++){
      double h=high[i],l=low[i];
      if(block.time==0)
         setNewBlock(time[i],open[i],h,l,close[i]);
      else{
         if(h<close[i-1])
            h=close[i-1];
         if(l>close[i-1])
            l=close[i-1];
      }
      
      if( close[i]>block.high || close[i]<block.low ){
         setObjBlock((int)block.time,block.time,block.high,time[i],block.low,block.clr);
         if(i+1<rates_total)
            setNewBlock(time[i],open[i],h,l,close[i]);
      }else{
         double hb=block.high,lb=block.low;
         if(hb<h)
            hb=h;
         if(lb>l)
            lb=l;
         if(i+1<rates_total){
            block.high=hb;
            block.low=lb;
         }else if(block.time!=time[i])
            deleteObjBlock((int)time[i]);
         
         setObjBlock((int)block.time,block.time,hb,time[i],lb,block.clr);
      }
   }
   
   return(rates_total);
}
void OnDeinit(const int reason){
   restart();
}

//
void restart(){
   ObjectsDeleteAll(0,objBN);
   ChartRedraw(0);
   block.time=0;
   block.high=0;
   block.low=0;
   block.clr=blockUpClr;
}
void setNewBlock(const datetime time,const double open,const double high,const double low,const double close){
   block.time=time;
   block.high=high;
   block.low=low;
   block.clr=blockUpClr;
   if(open>close)
      block.clr=blockDownClr;
}
void setObjBlock(string name,const datetime t1,const double p1,const datetime t2,const double p2,const color clr){
   name=objBN+name;
   if(ObjectFind(0,name)<0){
      ObjectCreate(0,name,OBJ_RECTANGLE,0,t1,p1,t2,p2);
      ObjectSetInteger(0,name,OBJPROP_FILL,true);
      ObjectSetInteger(0,name,OBJPROP_BACK,true);
   }
   ObjectSetInteger(0,name,OBJPROP_COLOR,clr);
   ObjectSetDouble(0,name,OBJPROP_PRICE,0,p1);
   ObjectSetInteger(0,name,OBJPROP_TIME,1,t2);
   ObjectSetDouble(0,name,OBJPROP_PRICE,1,p2);
}
void deleteObjBlock(string name){
   name=objBN+name;
   if(ObjectFind(0,name)<0)
      ObjectDelete(0,name);
}
