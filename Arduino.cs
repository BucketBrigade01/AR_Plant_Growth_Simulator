using Godot;
using System;
using System.IO.Ports;

public partial class Arduino : Node2D
{
	SerialPort serialPort;
	RichTextLabel temp;
	RichTextLabel humid;
	RichTextLabel light;
	
	
	private string initialHumidity = "";
	private string initialTemperature = "";

	public override void _Ready()
	{
		Console.Write("Starting...");
		temp = GetNode<RichTextLabel>("RichTextLabel");
		humid = GetNode<RichTextLabel>("RichTextLabel3");
		light = GetNode<RichTextLabel>("RichTextLabel5");
		
		serialPort = new SerialPort();
		serialPort.PortName = "COM3"; 
		serialPort.BaudRate = 9600; 
		serialPort.Open();

		GD.Print($"Opened Serial Port: {serialPort.PortName}");
	}

	public override void _Process(double delta)
	{
		if (!serialPort.IsOpen) return;

		// Read all available data
		string serData = serialPort.ReadExisting();
		if (!string.IsNullOrEmpty(serData))
		{
			// Process complete lines
			string[] lines = serData.Split(new[] { '\n' }, StringSplitOptions.RemoveEmptyEntries);
			foreach (string line in lines)
			{
				ProcessLine(line.Trim());    
			}
		}
	}
	private void ProcessLine(string line)
	{
	// Split each line by the comma delimiter
		string[] values = line.Split(',');
		if (values.Length == 3)
		{
			string humidityValue = values[0].Trim();
			string temperatureValue = values[2].Trim();
			string lightValue = values[1].Trim();

			// Check if humidity and temperature are both valid and above 2 digits
			if (humidityValue.Length >= 2 && initialHumidity == "")
			{
				initialHumidity = humidityValue; // Store initial value
				humid.Text = initialHumidity;
				GameManager.Instance.humid = initialHumidity;
			}
			else
			{
				humid.Text = initialHumidity; // Keep the initial value
			}

			if (temperatureValue.Length >= 2 && initialTemperature == "")
			{
				initialTemperature = temperatureValue; // Store initial value
				temp.Text = initialTemperature;
				GameManager.Instance.temp = initialTemperature;
			}
			else
			{
				temp.Text = initialTemperature; // Keep the initial value
			}

			light.Text = lightValue; // Always update light level
			GameManager.Instance.light = lightValue;
		}
		else
		{
			GD.Print("Invalid data format");
		}
	}
}
