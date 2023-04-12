# Emovied
Develop a mobile application that displays current movie screenings, ongoing television show broadcasts, and provides users with comprehensive information about the movie, including its plot summary and cast details.

Note: running the app on debugging will not show the splash screen in Android 12

How to run debugging:
- clone this repository
- do "flutter pub get"
- flutter run

How to run from build release apk:
- clone this repository
- do "flutter pub get"
- do "flutter build apk"
- after finish building copy the apk to your phone
- install apk
- run the installed app

currently API key was kept inside of the repository and will be put in to a gitignore later

What to try?
- "Upcoming movie" are placed at the home screen
- "Now playing" are below the "Upcoming movie"
- "Airing today" are on the same place as "Now playing" to trigger the "Airing today" tap on the "TV Show" button on the right side
![WhatsApp Image 2023-04-12 at 4 31 11 PM](https://user-images.githubusercontent.com/88265749/231401467-7580488e-d20f-441c-b087-f5fc4cfc0716.jpeg)
![WhatsApp Image 2023-04-12 at 4 31 12 PM (1)](https://user-images.githubusercontent.com/88265749/231403335-ab3eb382-fb08-441d-bd6b-880825d14932.jpeg)


- "Popular Movies" are placed on the Discover section along with the "Top Rated Movies", "Popular TV Show" and "Top Rated Movies" tap on the filter chip to change the result
![WhatsApp Image 2023-04-12 at 4 31 11 PM (1)](https://user-images.githubusercontent.com/88265749/231402636-ed67d45c-a151-489f-8b06-d83b05a31c7e.jpeg)
![WhatsApp Image 2023-04-12 at 4 31 12 PM](https://user-images.githubusercontent.com/88265749/231403455-42f9ab79-a2e0-45d9-8012-bd9268224179.jpeg)

- "Watchlist" are on the top corner of image movie item, tap to add to watch list
- To check if the show is added to watch list go to the "Watchlist" screen by tapping on the bottom navigation bar on the right
![WhatsApp Image 2023-04-12 at 4 31 12 PM (2)](https://user-images.githubusercontent.com/88265749/231403201-781f344c-d6ca-4660-a4a9-8936723c8174.jpeg)

- "Search" are on the Search Screen, to try it tap on the center icon at Bottom Navigation Bar
- Tap on the textfield on top of the Search Screen then type the query to do the searching
- The result will pop after few hundred millisecond
![WhatsApp Image 2023-04-12 at 4 31 13 PM (1)](https://user-images.githubusercontent.com/88265749/231404496-df27cb4b-f2e3-494c-ac8f-136cff6f1592.jpeg)

- Visiting detail screen can be done by tapping item that contains movie detail like image and name
![WhatsApp Image 2023-04-12 at 4 31 13 PM (2)](https://user-images.githubusercontent.com/88265749/231404529-9b106c4b-4bb2-4ae3-a348-bf4abdbecdb6.jpeg)

