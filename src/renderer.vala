namespace NGulf
{
	public class Renderer
	{
		public Application application;

		public unowned SDL.Screen screen;

		public Renderer(Application application)
		{
			stdout.printf("Starting Renderer...\n");

			this.application = application;

			this.screen = SDL.Screen.set_video_mode(640, 480, 8, SDL.SurfaceFlag.HWSURFACE);
			SDL.WindowManager.set_caption("NGulf", "");
		}

		public bool? run()
		{
			bool running = true;

			SDLGraphics.Rectangle.fill_color(screen, 8, 8, (int16)(32), (32), (uint32)0xFFFFFFFF);

			screen.flip();

			SDL.Event event;
			while (SDL.Event.poll(out event) == 1)
			{
				if (event.type == SDL.EventType.QUIT)
					running = false;
			}

			return running;
		}
	}
}
