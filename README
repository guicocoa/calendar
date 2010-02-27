GCCalendar is covered by the MIT License

How to use:
- Drag the GCCalendar folder from this project into the top level of your Xcode project tree.  Make sure "copy items…" and "recursively create…" are selected.
- Import the GCCalendar.h header file anywhere you would like to use the calendar API.
- Implement the GCCalendarDataSource and GCCalendarDelegate protocol and place the required method in the class creating the calendar view.

Changes (v1.1):
- added 'hasAddButton' property to the calendar portrait view.  Setting this to YES causes an add button to be in the nav bar of the calendar view
- calendar data sources and deleegates are now set per calendar view and not at a singleton level
- GCCalendarDelegate now has functions for handling calendar tile selection and adding a new event
Known Issues (v1.1):
- events with start and end time on different days may behave unexpectedly
- touch events on calendar tiles don't reflect the touch in the user interface
- events that overlap may behave unexpectedly

Known issues (v1.0):
- Events that have start and end dates not on the same day may behave unexpectedly.
- Touches on the calendar tiles do not reflect the touch in the user interface.
- The body of calendarTileTouch: in GCCalendarPortraitView is intended to let the developer push a detailed event view onto the navigation stack, currently no such view exists
