# iDynamicForms
iOS iDynamicForms Objective-C minimal framework/codebase for developing dynamic forms based on UITableView and UITableViewCell objects.

After you implement, TableViewFormDataSource protocol within Your ViewController's DataSource class (or may be in a DataSource Super class) you could easily implement a UI like the following or may be even something more complex. But remember, this forms are already dynamic. You are totally free to grow these UI dynamically.

<p align="center">
  <img src="http://i.imgur.com/TMLdckj.png" width="375" height="667" alt="iDynamic Sample Form"/>
  <span> Here is the sample UI Screen of iDynamic, Clone the project and check it out </span>
</p>


Like in PHP, Arrays are the most important and superpower overloaded element, in iOS framework, UITableViews are the objects that inherits
a lot of power throughout the framework. But even though it's out there, I've seen and felt the painful feeling when working and maintaining some applications where it has dynamic forms but had built using UIScrollView objects, but they have forgotten the first option
is building them using UITableView objects.

So here I have created a reusable code-structure/mini-framework/skeleton to use UITableView objects to build Dynamic Forms in iOS Applications.
My major objective on publishing this as an open sourced project in GitHub is to receive your all feedback to identify pros and cons of this implementation and improve this if possible.

# Note:
Here the form UI is really simple what I have created initially just to give you an idea. And also I will add functionality little by little later on
as time permits me.

Cheers!!!
