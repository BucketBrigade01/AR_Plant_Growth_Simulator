using Godot;
using System;

public partial class GameManager : Node
{
	public static GameManager Instance { get; private set; }

	public string light { get; set; }
	public string temp { get; set; }
	public string humid { get; set; }
	
	public override void _Ready()
	{
		Instance = this;
	}
}
