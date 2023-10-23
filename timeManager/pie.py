from kivy.app import App
from kivy.uix.boxlayout import BoxLayout
from kivy.uix.button import Button
from kivy.graphics import Color, Line, Ellipse
import random

class PieChart(BoxLayout):

    def __init__(self, colours, **kwargs):
        super(PieChart, self).__init__(**kwargs)
        self.orientation = 'horizontal'
        self.canvas.before.add(Color(0, 0, 0))
        self.size_hint = (None, None)
        self.size = (300, 300)
        self.chart_data = [(f'Slice {i+1}', 100/len(colours)) for i in range(len(colours))]
        self.draw_pie_chart(colours=colours)

    def draw_pie_chart(self, colours):
        self.canvas.clear()
        total = sum(percentage for label, percentage in self.chart_data)
        current_angle = 0

        with self.canvas:
            for i, (label, percentage) in enumerate(self.chart_data):
                slice_angle = 360 * (percentage / total)
                Color(*colours[i])
                Ellipse(pos=self.center, size=(300, 300), angle_start=current_angle, angle_end=current_angle + slice_angle)
                current_angle += slice_angle

    def change_percentages(self, nums, colours, *args):
        if sum(nums) == 0: nums = [100/len(nums) for _ in range(len(nums))]
        for i, (_, percentage) in enumerate(self.chart_data):
            self.chart_data[i] = (f'Slice {i+1}', nums[i])
        self.draw_pie_chart(colours=colours)
