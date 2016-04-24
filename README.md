# Hubot Slack Sumologic Charts (:microscope: : **Experimental package**)

## Description

It's a package which allow you to display sumologic charts in your slack via Hubot.
That's why the name is so long, sorry for that :wink:

## Install 

I assume you already have an Hubot and you just want add this feature
If you want everything from the beginning, you should check [**hubot-slack**](https://github.com/slackhq/hubot-slack)
repository which explain how to do it.

Let's go ! First, like all Npm package, install it !
```
npm install hubot-slack-sumologic-charts --save
```

Make sure you have the following environment variables set correctly

```
HUBOT_SLACK_TOKEN=<your_slack_token>
HUBOT_SUMOLOGIC_TOKEN=<your_sumologic_api_token>
```

Install Complete !


## What this package do

For now, this package only works for dashboard widgets. Support for queries should be planned and added depending 
of time left... 

Other important point, Sumologic API and especially the dashboard part is still in beta, that's why that package will
never reach version 1.0.0 while this part isn't done. But the most important part is you can't have easily the information
about a dashboard and his widgets, this part of the API seems broken or not implemented yet, we have open an issue
for it and hope one this one will be done.

Don't hesitate to push it, this package should be better ! [[:octocat: Github issue](https://github.com/SumoLogic/sumo-api-doc/issues/8)]

So you have to explain hubot, how to get widget data from a dashboard and unfortunately, this part is manual :disappointed:.
 
I will tell you how to explain hubot to learn new things later, now the process ! 

### Process 

#### Step one : Target the good widget
For now we can't do it easily while the dashboard API from Sumologic is broken.
So we have to teach hubot how to get it and we use a name you will give for that.
We suppose hubot have is memory set and he find the widget.


#### Step two : Transform widget data to chart

Thanks to jsdom and highcharts, we can transform what sumologic return to a chart and generate a svg file.
Only a little range of sumologic charts have been implemented, feel free to implement others or create issue for them.

#### Step three : Transform svg graph to image

For now we will use svg2png, it use phamtomjs in background for extract png from
svg. Not the nicer solution but the easiest for now. Other lib are only wrapper 
of lower image libs. Maybe this latest solution is faster than the previous and 
we should consider it on long term maybe. But this one is harder to implement and
depend on which OS the hubot will run.

#### Step Four : Send the img to slack

Hubot send image generated to the channel/user where the command have been executed.


That's all ! 

## Teach hubot how to render widget

This is simple but not convenient. You have to create a json file with the mapping between dashboard/widget you want to
generate. Example below :

```javascript
{
  "boulangerie-baguettes": {
    "dashboardId" : 12345678,
    "widgetId" : 87654321,
    "type" : "stackedBar"
  },
  "boulangerie-pie": {
    "dashboardId" : 123456781,
    "widgetId" : 876543210,
    "type" : "pie"
  },
  "boulangerie-butter-counter": {
    "dashboardId" : 1234567811,
    "widgetId" : 8765432100,
    "type" : "counter"
  },
  "boulangerie-baguette-cooking": {
    "dashboardId" : 14567811,
    "widgetId" : 8765332100,
    "type" : "timecounter"
  },
  "boulangerie-sells": {
    "dashboardId" : 14567823,
    "widgetId" : 8765332111,
    "type" : "lines"
  }
}
```


This file have to contain in his filename the mention : `hubot-sumo-lesson`
Object keys are the way to sumo to retrieve the chart you want at the time you asked to hubot.
Types are the currently supported chart hubot can generate, the example above list all of them for now.

Finally to teach to hubot, just upload that file and ensure this one have a public visibility.
You can add as many lessons you want hubot brain will merge his memory with the new lesson. 

This is an experimental package, so if you find something wrong, don't hesitate to ask.

## Available hubot commands on slack

### Display a chart by name

```
@hubot sumo boulangerie-pie
```

### Erase all memory of hubot about sumologic

```
@hubot lobotomize sumo
```
