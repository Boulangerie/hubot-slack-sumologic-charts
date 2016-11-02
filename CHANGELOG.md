## 0.1.0
- [x] Implement `sumo (name)`
- [x] Implement `lobotomize sumo`
- [x] Implement Sumologic Memory management via file uploading
- [x] Chart support
    - [x] Pie
    - [x] StackedBar
    - [x] counter
    - [x] timecounter
    - [x] lines
- [x] Old Todo
    - [x] Implement some `highchart` adapters depending of widget
    - [x] Add Hubot hear for this dev
    - [x] Test on a true slack
    - [x] Graph can be built on `highchart` or `svg` template
      - [x] Split how work graph builder for allowing multiple implementation
      - [x] Base on graph type
    - [x] Use promises !
       - [x] Break callback hell into promise composition
    - [x] Clean generated image file
      - [x] Auto find tmp file
      - [x] Use it
    - [x] Style graph
    - [x] Teach Hubot to learn
      - [x] Learn from a `json` file (brain used)
      - [x] Allow to erase memory via a command
    - [x] Clean && Tidy && Refactor if needed
      - [x] Clean todo's
      - [x] SendToSlack (ensure work for common cases)
    - [x] Package it !
      - [x] Boulangerie repo
      - [x] Readme
      - [x] Npm publish
    - [x] When Hubot has learnt, return a message

### To milestonize

### Learn Hubot to learn
POC on fact Hubot can get a json file through slack
Can be a link to file but it's less safe
Finally we can brainwash Hubot if we want !
Maybe if Sumologic fix their API we could use it properly
and avoid a lot of this stuff

#### Edit
Some of these features have already been done.
But this part of this package could improved a bit more

- [] Erase brain should be possible only by some users
- [] Should list all widget available...
- [] Should add/update/remove unitary by a command

### Learn Hubot to make graphs with query
Instead of using dashboard data, use true results from
a custom query. The naive way should to transform query
results into dashboard data format. Like this graphs implementation
should work as expected without no update on it.

We should use the same Hubot command, but Hubot has to warn the user
the result could not come as quickly as a widget result

- [ ] Associate a query with a name and a graph type
- [ ] Implement logic to transform sumo data into something usable for graph
- [ ] Add Hubot behavior
- [ ] (Depending of : Learn Hubot to learn) Update or consider it


### Teach Hubot to make beautiful graphs
- [ ] Missing infos
  - [ ] Time range of current graph
- [ ] Missing graph
  - [ ] Donuts
  - [ ] Text percentage
  - [ ] Filled line chart
- [ ] Upgrade logic behind how we format rawData from sumo (too dumb for now)
- [ ] Style should be configurable
- [ ] Apply Color rules on some of them when sumo will give us that details

### Teach Hubot to give insights to find his mistakes !
- [ ] Implement a true logger to see what Hubot does

### Improve filesystem management
Instead of using promise of folder, use it or flag, this could avoid problem
with promise. Other solution should be to create it at module install

- [ ] Spec it :)

### Other points
- [ ] Find a way to delete what Hubot sends to Slack
- [ ] Make this part of Hubot more customizable via brain of something (theme ?)
