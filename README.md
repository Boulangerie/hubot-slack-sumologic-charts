# Hubot Slack Sumologic Charts (:microscope: : **Experimental package**)

## Description

This is a package that allows you to display Sumologic charts in your Slack using Hubot.
That's why the name is so long, sorry for that :wink:

## Install

I assume you already have a Hubot and you just want to add this feature.
If you need to learn more about how Hubot can interact with Slack, make sure you have a look at the [**hubot-slack**](https://github.com/slackhq/hubot-slack) repository.

Let's go ! First, like every Npm package, you need to install it !
```
npm install hubot-slack-sumologic-charts --save
```

Make sure you have the following environment variables set correctly

```
HUBOT_SLACK_TOKEN=<your_slack_token>
HUBOT_SUMOLOGIC_TOKEN=<your_sumologic_api_token>
```

Install Complete !


## What this package does

For now, this package only works for dashboard widgets. Support for queries should be planned and added depending
of time left...

Another important point, Sumologic API and especially the dashboard part is still in beta, that's why that package will
never reach version 1.0.0 while this part isn't done. But the most important part is that you can't easily access the information
about a dashboard and its widgets. This part of the API seems to be broken or not implemented yet. We have open an issue
for it and hope it will be taken care of soon.

Don't hesitate to push it, it will help improve this package ! [[:octocat: Github issue](https://github.com/SumoLogic/sumo-api-doc/issues/8)]

So you have to explain Hubot how to get widget data from a dashboard and unfortunately, this part is manual :disappointed:.

I will tell you how to teach Hubot new things later, now the process !

### Process

#### Step one : Target the good widget
For now, this can't be easily done since the Sumologic's dashboard API is broken.
So we have to teach Hubot how to get it. You will have to provide a name for that.
We suppose Hubot has his memory set and he can find the widget.


#### Step two : Transform widget data to chart

Thanks to `jsdom` and `highcharts`, we can transform what Sumologic returns to a chart and generate a `svg` file.
Only a little range of Sumologic charts have been implemented, feel free to implement others or create issues for them.

#### Step three : Transform svg graph to image

For now we will use `svg2png`, it uses `phamtomjs` in the background to extract `png` from
`svg`. Not the nicest solution but the easiest for now. Other libs are only wrappers
for lower image libs. Maybe this latest solution is faster than the previous one and
we should consider it in the long run. But this one is more complex to implement and
depends on which OS Hubot will run.

#### Step Four : Send the img to slack

Hubot sends the image generated to the channel/user where the command has been typed.

That's all !

## Teach Hubot how to render widget

This is simple but not convenient. You have to create a `json` file with the mapping between dashboard/widget you want to
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


This file has to contain in its filename the mention : `hubot-sumo-lesson`
Object keys are the way for Sumologic to retrieve the chart you want at the time you asked Hubot.
Types are the currently supported chart Hubot can generate, the example above list all of them for now.

Finally, to teach Hubot, simply upload that file and ensure this one has a public visibility.
You can add as many lessons you want: Hubot's brain will merge its memory with the new lessons.

This is an experimental package, so if you find something wrong, feel free to ask.

## Available Hubot commands on slack

### Display a chart by name

```
@hubot sumo boulangerie-pie
```

### Erase all memory of Hubot about Sumologic

```
@hubot lobotomize sumo
```
