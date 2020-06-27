# Project 2 - *Flix*

**Flix** is a movies app using the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: **15** hours spent in total

## User Stories

The following **required** functionality is complete:

- [x] User sees an app icon on the home screen and a styled launch screen.
- [x] User can view a list of movies currently playing in theaters from The Movie Database.
- [x] Poster images are loaded using the UIImageView category in the AFNetworking library.
- [x] User sees a loading state while waiting for the movies API.
- [x] User can pull to refresh the movie list.
- [x] User sees an error message when there's a networking error.
- [x] User can tap a tab bar button to view a grid layout of Movie Posters using a CollectionView.

The following **optional** features are implemented:

- [x] User can tap a poster in the collection view to see a detail screen of that movie
- [x] User can search for a movie.
- [x] All images fade in as they are loading.
- [x] User can view the large movie poster by tapping on a cell.
- [x] For the large poster, load the low resolution image first and then switch to the high resolution image when complete.
- [x] Customize the selection effect of the cell.
- [x] Customize the navigation bar.
- [x] Customize the UI.

The following **additional** features are implemented:

- [ ] List anything else that you can get done to improve the app functionality!

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. ways to reduce repeating code (ex not having to copy the fetch movies function into several places)
2. pre-emptively checking for errors (ex when requesting data, checking to make sure returned data is not null)

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='http://g.recordit.co/Ws8uesliCh.gif' title='Now Playing Tab Walkthrough' width='' alt='Video Walkthrough' />
<img src='http://g.recordit.co/wE4Kp4cFMm.gif' title='Superhero and Search Tabs Walkthrough' width='' alt='Video Walkthrough' />
<img src='https://github.com/adriennehl/Flix/blob/master/Simulator%20Screen%20Shot%20-%20iPhone%2011%20-%202020-06-26%20at%2019.03.50.png' title='Network Error Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [RecordIt](http://recordit.co/).

## Notes

Describe any challenges encountered while building the app.
- making sure requests were formatted correctly.
- managing outlets.
- checking for null values. 

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library
- [Movies API](https://www.themoviedb.org/) - movies database

## License

    Copyright [yyyy] [name of copyright owner]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
