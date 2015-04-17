int main(string[] args)
{
	stdout.printf("Hello, World!\n");

	unowned SDL.Screen screen;

	screen = SDL.Screen.set_video_mode(640, 480, 8, SDL.SurfaceFlag.HWSURFACE);
	SDL.WindowManager.set_caption("NGulf", "");

	SDLGraphics.Rectangle.fill_color(screen, 0, 0, (int16)(8), (8), 0x000000FF);

	bool running = true;

	while (running)
	{
		screen.flip();

		SDL.Event event;
		while (SDL.Event.poll(out event) == 1)
		{
			if (event.type == SDL.EventType.QUIT)
				running = false;
		}
	}

	return 0;
}
