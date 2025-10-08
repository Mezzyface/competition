There are many YouTube videos about 
how to create basic UIs in Godot. But once we have a UI, then what? In this video, we'll look at how 
to create a system that makes   your UI implementation maintainable and flexible. Here's a menu in which the player 
can hire heroes to build their party. We have a list of available heroes 
that are for hire on the left and a list on the right, which 
contains all hired party members. When a hero is selected, all their 
information is shown in the center. I went ahead and implemented the 
logic, so let's see it in action. When I select the hero, the information box in the 
center appears and updates with that hero's info. I can click hire to move a hero from 
the available list to the hired list. Or remove them to move them 
back to the available list. When I change the name, the 
change automatically affects   all other nodes that display the name, 
like this item in the list over here. Also note that the selection 
updates accordingly and only   one item from one of the two lists 
can be selected at any given time. So, how would you actually code all of this? Let's talk about the most obvious but 
not so great way of doing things first. You could just write a script that 
hard-codes all interactions in your UI. For each component, you code 
what happens when it changes. When a hero is selected, you set 
the line edits text to the name of   the selected hero and update all 
labels that display their stats. When the line edits text changes,   you update the selected item's label and 
anything else that uses the name and so on. This works fine for simple user interfaces. But as your UI grows, it 
becomes difficult to change,   logic becomes complicated, and it generates 
a lot of code which is hard to maintain. So how can we do this better? There are many design patterns like 
Model-View-Controller Model-View-View,   Model-View-Presenter and more 
that can be used to manage a UI. To simplify, these are just ways 
to separate the logic and visible   content of your controls from the 
data the UI ultimately manipulates. For our purposes, we're just going 
to ignore the details of the design   patterns and instead focus on the idea of 
separating our data from our nodes in Godot. Just be aware what we're going to do in this 
video is just one way of managing the UI. But it's what I found to complement 
Godot's node system quite well. Really, there are only two things we need 
to deal with, the state and controls. The state is all data that 
you may want the UI to affect. In my example, that's two arrays of Hero objects 
where each Hero has some data like a name. Of course, in my example, they 
had more data than just a name. They also had stats, but that 
doesn't fit nicely into this diagram. Controls, on the other hand,   are any control nodes which the player 
can see and usually interact with. That could be Buttons, Labels, 
CheckBoxes, LineEdits, and so on. Our goal is to tie the state 
to our controls somehow. If the state changes, we update the control and 
when the control changes, we update the state. Note that our control nodes in Godot 
often have an internal state of their own. For example, a LineEdit contains state 
like the text it currently displays. So really, we're linking our state to 
this internal state of the LineEdit. To make sure the different controls 
don't know too much about each other,   we're going to use signals 
to do all the communication. Here's how it'll work. Say we have our state, a line edit, and a label. When I type something into the line 
edit, the text changed signal is emitted,   which we'll connect a function 
to that updates the state. Meanwhile, the state contains a value_changed 
signal that we connect to another function,   which writes the data into 
our labels text property. By going through these signals, we're avoiding 
any direct interaction between our two controls. Our components are now completely independent from 
each other and only ever interact with the state. That's a huge improvement. The UI can now be changed easily later on, 
logic stays simple because each component   only worries about itself, and we end up 
with less code which is easier to maintain. So how do we implement all this? Again, our controls already have signals that   we can connect to to see if 
their internal state changes. For example, the text changed 
signal in a line edit. We can simply connect a function to 
this and that modifies the state. Personally, I like using lambda 
functions to make this very compact. Like this single line of code, which updates the   name of our selected hero based 
on what text the player enters. Ignore the properties called value for a second. You'll see what those are all about soon. Anyway, detecting changes to our state 
is a little bit more complicated. We could just use setters to detect a change 
in our state and call some custom signal. So in this example, when my value is modified, 
value_changed is emitted to signal the change. But this is where things get tricky. First of all, this doesn't work well with arrays. Here we are doing exactly what we did before, 
but use an array instead of an integer. Sure, if we set an entire 
array, the setter is called. But when we append a value into the 
array, the setter is never called. This is a problem since we would like to work 
with arrays in our UI for lists and such. The other problem is that this ends up 
generating a lot of boilerplate code. You end up with a ton of setters and signals, 
and that makes everything very messy. To fix both of these issues, we 
need to create a few helper classes. First is a base class I like to call Reactive as   it will allow us to define 
types that react to change. I like to make this Reactive 
class extend resource. And as you can see, all it contains is a signal 
that we can emit when the Reactive object changes. But let's add one more thing, the ability 
for reactive objects to have an owner. First, I've added this owner 
property and given it a setter. If this property is set to a valid 
reactive object, rather than null,   then we can connect the owner's propagate 
function to the Reactive's signal. This propagate function simply emits the signal   which essentially propagates the 
signal up the chain of owners. Sounds complicated, but it's really simple. Let's say we have a hero 
class which extends Reactive. Inside the class, we have variables for the 
hero's name, strength, wisdom, and so on. All of these are also objects of type Reactive. Now what happens if I emit the 
reactive_changed signal of the name property? Well, it will emit and that's it. But if you think about it, the hero should 
also emit its reactive_changed signal. After all, if I rename a hero, that implies 
that the hero itself has changed, right? So we set the owner of name, strength, 
wisdom, and other properties to be the hero. This will automatically propagate 
changes to these properties by   emitting the signal of the hero at the same time. If for example the name emits its 
signal then its owner the hero will too. Now that we have our reactive type working 
let's add some sub-classes like ReactiveInt,   ReactiveString, and stuff like that. These are going to store the actual values 
that make up our data like integers or strings. Sadly, Godot doesn't have generic types like 
we can have with templates in C++, for example. So, we're going to create multiple 
sub-classes as a workaround. As you can see, all these sub-classes do is store 
an internal value here, either an int or a String. When they are set, the signal is emitted. And to be able to quickly set the owner, the 
_init function takes an initial owner as well. For arrays, I want to create 
another subclass ReactiveArray,   which wraps all common array operations and makes 
sure they also emit the signal after completion. This way we can have arrays that 
react to change properly as well. And finally, I would like to be able to store any   other object like a Hero for 
example or another Reactive. So let's create a ReactiveObject class. This is just for convenience as it 
allows us to avoid having a million   sub-classes for every imaginable type of object. As you can see, if the ReactiveObject's 
value is set to another Reactive,   we also propagate its signal 
to the reactive object. This is really nice for having nested Reactives. And there we go. That was a lot of setup, but that's all we need 
to build our state and connect controls to it. In my example, we need to 
track two arrays of heroes. Of course, we need to actually code the 
Hero class, which inherits from reactive. Its properties like name, strength, wisdom,   and so on are Reactive sub-classes 
that set the hero as their owner. Remember that just means if they 
change, the hero itself changed as well. And that's it for the state. It's actually quite simple. By the way, the state is just a 
node which I set up as an autoload. This makes it exist in the background 
and keeps it easily accessible. Of course, you can store your state 
wherever and however you like. Okay, all of the steps we went through 
may have seemed like a lot of effort,   but now that we have everything set up properly, 
making UI interactions work is super easy. And the system will make it stay manageable 
even as things become more complex. Let's look at the code for the 
menu I showed you as an example. This script is attached to the root 
of my menu, which is a control node. The first thing we define is some extra 
state that is only relevant to this menu,   which is the currently selected Hero. The entire rest of the logic simply 
goes into the _ready function. First, we set the selection 
of our two lists to be the   same Reactive we're using for our selected Hero. This is really neat because it 
links our lists up and makes it   so you can only select one Hero at any given time. By the way, my lists aren't 
actually ItemList nodes. I don't like those because 
they're not that useful. So, I made my own that just extends 
VBoxContainer and its items are child nodes. You can look at the code for it in 
the GitHub repository if you care. Anyway, back to the menu. Whenever one of the two lists in the state is 
modified, we need to update our list nodes. For simplicity, I chose to just rebuild 
each list entirely when necessary. If you want to be more optimal, you could instead 
handle specific changes to the list separately,   but I couldn't be bothered and 
wanted to keep it super simple. When the name is edited by the player, the name 
of the selected hero is updated in the state. When buttons are pressed, the selected hero is 
moved from one list in the state to the other. When the selected hero changes,   we pull data out of the state and 
put it into the correct components. We can make this a single function call 
that handles multiple components like   I did here or connect a function for each control. Comes down to the same thing. What's important is that components use the state 
but don't actually talk to each other directly. Always remember that. And that's basically it. To wrap things up, I manually emit each list's 
reactive array so everything is initialized. And I also set the initial selected hero to null. So no hero is selected when the menu opens. And just like that, we have a working UI. What's really cool about it is that we can remove   any controls from the UI and 
the rest will keep working. So rearranging things or changing the menu later 
on when your game's design changes is really easy. And as you saw, the actual menu 
logic remains really simple. Each component simply communicates 
with the state and that's it. Our example case here is of course quite 
simple, but imagine how nice a system like   this is to use with more complicated 
UI with more intertwined components. And of course, this system 
makes completely separate   UIs work together as long as 
they modify the same state. Well, that about wraps this video up. There's a GitHub repository with all 
the code linked in the description. I hope this video was useful to you. Thanks for watching and bye.