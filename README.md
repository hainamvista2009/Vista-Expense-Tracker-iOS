# Goal: A log where users can type in an expense amount, select a category (e.g., Food, Transport, Rent), and see a history of what they spent. The data should stay saved even if they close the app.

Concepts learned: Using dropdown selectors, basic local persistent storage, and organizing structured data models.

Android implementation: Use a Spinner component for the categories. For simple local data saving, start out with SharedPreferences to save small lists as JSON strings before jumping into full databases.

Xcode (iOS) implementation: Use a standard Picker view for categories, and use the simple @AppStorage wrapper or UserDefaults to save your data array to the device.

### Built with Xcode 14.3 for iOS 16>
