# Gold Trading Application

## Overview
The Gold Trading Application is a real-time trading platform that provides users with live market data using WebSockets. The application allows users to track gold prices, receive updates, manage their profile, and access other relevant data.

## Initial Login Credentials
- **Contact Number**: 9988445566  
- **Password**: 123456789  

> **Note:** If there are any changes in the API, please use the **Forgot Password** feature to reset your credentials.

## Application Features
### 1. **Home Page**
   - Displays live market data.
   - Fetches real-time updates using WebSockets.
   - Shows the latest gold price trends.

### 2. **Updates Page**
   - Provides new updates related to the market.
   - Includes news and announcements for traders.

### 3. **Profile Page**
   - Users can manage their personal information.
   - Update contact details and preferences.

### 4. **Other Data Page**
   - Displays additional market-related data.
   - Currently contains dummy data as a placeholder.

## WebSocket Integration
The application utilizes WebSockets to fetch live market data from:
```
ws://capital-server-gnsu.onrender.com/socket.io?EIO=3&transport=websocket&secret=aurify%40123
```
However, since today is **Sunday**, the market is closed, and the WebSocket might not be providing live data at the moment.

## Installation and Setup
1. Clone the repository:
   ```sh
   git clone https://github.com/your-repo/gold-trading-app.git
   ```
2. Navigate to the project folder:
   ```sh
   cd gold-trading-app
   ```
3. Install dependencies:
   ```sh
   flutter pub get
   ```
4. Run the application:
   ```sh
   flutter run
   ```
## Sample Video

https://github.com/user-attachments/assets/b6479a51-ed90-4fb1-94a6-076fb923cc68


## Troubleshooting
- If the WebSocket is not connecting, check if the market is live.
- Ensure that the API endpoints are up and running.
- Use the **Forgot Password** feature if you encounter login issues.

## License
This project is licensed under the MIT License.

## Contact
For any queries, contact **ajilesh46@gmail.com**.

