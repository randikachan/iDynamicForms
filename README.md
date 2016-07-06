# iDynamicForms
iOS iDynamicForms Objective-C minimal framework/codebase for developing dynamic forms based on UITableView and UITableViewCell objects.

Like in PHP, Arrays are the most important and superpower overloaded element, in iOS framework, UITableViews are the objects that inherits
a lot of power throughout the framework. But even though it's out there, I've seen and felt the painful feeling when working and maintaining some applications where it has dynamic forms but had built using UIScrollView objects, but they have forgotten the first option is building them using UITableView objects.

After you implement, `TableViewFormDataSource` protocol within Your `ViewController`'s DataSource class (or may be in a DataSource Super class) you could easily implement a UI like the following or may be even something more complex. But remember, this forms are already dynamic. You are totally free to grow these UI dynamically.

<p align="center">
  <img src="http://i.imgur.com/TMLdckj.png" width="375" height="667" alt="iDynamic Sample Form"/><br/>
  <span> Here is the sample UI Screen of iDynamic, Clone the project and check it out </span>
</p>

So here I have created a reusable code-structure/mini-framework/skeleton to use `UITableView` objects to build Dynamic Forms in iOS Applications.
My major objective on publishing this as an open sourced project in GitHub is to receive your all feedback to identify pros and cons of this implementation and improve this if possible.

# Introduction:

##### So Let's get into How these forms are made up and inner working
iDynamicForms are totally dependent on `UITableView` and `UITableViewCell` classes. You already know that `UITableView` has to be backed up by
a data source, mostly an array of data for each row to be populated and represent the data. Here we have adapted the same concept, iDynamicForms are
always being backed up by a hybrid combination of `NSArray` and `NSMutableDictionary` objects.

The reason to use `NSMutableDictionary` to hold the data objects
for all cells which makes up the form is, sometimes we may need to grab a particular data object of a cell just by calling its name. So in that case
`NSMutableDictionary` API helps a lot. But `NSMutableDictionary` lacks one thing. That is it may jumble the order of the objects at runtime in time to time we run
the application. So in order to keep the order of the objects for each cell in the order the cells may appear, we used the `NSArray` in combination
with the `NSMutableDictionary`. So in order to make this work we have come up with a convenient simple API. Not only that we can add/remove `UITableViewCells` with
form content such as messages, buttons, text fields, etc. arbitrary using this structure.

# Note:
Here the form UI is really simple what I have created initially just to give you an idea. And also I will add functionality little by little later on
as time permits me.

Cheers!!!
