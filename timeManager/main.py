import json
import datetime
from kivy.app import App
from kivy.uix.label import Label
from kivy.uix.textinput import TextInput
from kivy.uix.button import Button
from kivy.uix.boxlayout import BoxLayout

from pie import PieChart

class HelloKivyApp(App):

    tasks = ["Sleep", "Work", "Chores", "Leisure"]
    colours = [(0, 1, 0, 1), (0.5, 0, 0.5, 1), (1, 0.5, 0, 1), (0, 0.5, 1, 1)]

    def build(self):
        # Load saved data if it exists
        try:
            with open('data.json', 'r') as file: self.data = json.load(file)
        except FileNotFoundError: self.data = {}

        # Create UI elements
        layout = BoxLayout(orientation='vertical', pos_hint={'center_x': 0.5})

        # self.message_inputs = []
        self.message_labels = []
        self.save_buttons = []

        for i in range(len(self.tasks)):  # Adjust 'n' as needed
            message_label = Label(text=f"{self.tasks[i]}:")
            save_button = Button(text=f'Activate', on_press=self.save_message,  size_hint=(None, None), size=(200, 100), pos_hint={'center_x': 0.5}, background_color=self.colours[i], font_size=36)
            
            self.message_labels.append(message_label)
            self.save_buttons.append(save_button)

            layout.add_widget(message_label)
            layout.add_widget(save_button)

        self.nowLabel = Label(text=f"Now:")
        layout.add_widget(self.nowLabel)
        delete_button = Button(text="Reset", on_press=self.reset, size_hint=(None, None), size=(200, 100), pos_hint={'center_x': 0.5}, background_color=(1, 0, 0, 1), font_size=36)
        layout.add_widget(delete_button)
        # layout.add_widget(Label(text="\n\n\n"))

        # pie
        # layout.add_widget(Label(text="Chart"))
        self.pie_chart = PieChart(colours=self.colours)
        layout.add_widget(self.pie_chart)

        self.update_message_labels()

        return layout

    def save_message(self, instance):
        # Determine which button was pressed to save the corresponding message
        for i, button in enumerate(self.save_buttons):
            if button == instance:
                
                
                time2 = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
                time1, x = self.data.get("prev", (str(time2), 0))

                self.data["prev"] = (time2, i)

                time1 = datetime.datetime.strptime(time1, "%Y-%m-%d %H:%M:%S")
                time2 = datetime.datetime.strptime(time2, "%Y-%m-%d %H:%M:%S")
                
                self.data[f"spent{x}"] = self.data.get(f"spent{x}", 0) + (time2 - time1).total_seconds()
                self.update_message_labels()

        # Save all messages to a JSON file
        with open('data.json', 'w') as file:
            json.dump(self.data, file)

    def reset(self, instance):
        # Delete all data and update the UI
        self.data = {}
        self.update_message_labels()
        # Save the empty data to the JSON file
        with open('data.json', 'w') as file:
            json.dump(self.data, file)

    def update_message_labels(self):
    
        totalSpent = sum([self.data.get(f"spent{x}", 0) for x in range(len(self.tasks))])

        nums = []
        # Update the displayed messages based on saved data
        for x, label in enumerate(self.message_labels):
            percentage = self.data.get(f"spent{x}", 0) / totalSpent if totalSpent > 0 else 0
            nums.append(percentage)
            label.text = f"{self.tasks[x]}: {(percentage*100):.2f}%"
        
        now = self.data.get("prev", ("", -1))[1]
        self.nowLabel.text = f"Now: {self.tasks[now] if now >= 0 else '-'}"

        self.pie_chart.change_percentages(nums=nums, colours=self.colours)

if __name__ == '__main__':
    HelloKivyApp().run()
