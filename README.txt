Vector Billiards
Nature of Code - Week 2
Mark Kleback

For this assignment, we were instructed to create forces using the PVector class in Processing. After a few trial runs, I decided to implement the Box2D library to simulate real-world physics using gravity, friction, and acceleration.

In this demo, a ball is generated in the upper left corner every second. It is attracted to the black hole in the center of the sketch. If it enters this hole, the score is reduced by 1 point.

The user can use the mouse to attract the balls toward the mouse cursor. When the mouse is pressed, the attractive force switches to the cursor, and the user can guide the balls toward the green goal in the bottom of the sketch. When the balls enter this hole, the score increases by 1 point.