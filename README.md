# fab_action_menu

The package is for setting up menu options on Floating Action Button

Library provides options for adding button upto 3 menu button.

Here is the implementation in project

| Menu option 1 | Menu Option 2 |
| ------------------ | ------------------ |
| <img src="./assets/gif (1).gif" height="500" alt="gif (1)"/>  | <img src="./assets/gif (2).gif" height="500" alt="gif (2)"/>  |


| Menu option 3 | 
| ------------------ |
| <img src="./assets/gif (3).gif" height="500" alt="gif (3)"/>  | 


# Here is the implementation detail.

Add the package in pubspec.yaml

``
fab_action_menu: ^0.0.1
``

You will need to create a list of ` FloatingActionObject `

The Menu will behave as per the number of items in list.
You will have options to set Color, Icon and Id of the menu in

# Params
```
List<FloatingActionObject> buttonData1 = new List();

 floatingActionObject = new FloatingActionObject();
    floatingActionObject.id = 1;
    floatingActionObject.color = Color.fromRGBO(204, 102, 0, 1);
    floatingActionObject.iconData = Icons.add;
    buttonData1.add(floatingActionObject);
    
 ```   

Now Add the floating action button in Scafold

```
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Container(
            child: Center(
         ...
         ...
        )),
      ]),
      floatingActionButton: FabActionMenu(
        buttonData: widget.object,
        clickListener: this,
        context: context,
      ),
    );
  }
```

You will need to implement the callback listner in the state class
# CallBack Listner

```  
class _PageState extends State<Page> implements CallbackListener{
 ...
 ...}
```

Thats it and you are good to go.


 









