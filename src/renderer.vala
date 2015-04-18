namespace NGulf
{
	public class Renderer
	{
		public Application application;

		public unowned SDL.Screen screen;

		public int width;
		public int height;

		public Renderer(Application application)
		{
			stdout.printf("Starting Renderer...\n");

			this.application = application;

			this.width = 640;
			this.height = 480;

			this.screen = SDL.Screen.set_video_mode(this.width, this.height, 8, SDL.SurfaceFlag.HWSURFACE);
			SDL.WindowManager.set_caption("NGulf", "");
		}

		public bool run()
		{
			bool running = true;

			int width = this.application.core.world.width;
			int height = this.application.core.world.height;

			int dx = this.width / width;
			int dy = this.height / height;

			this.render();

			screen.flip();

			SDL.Event event;
			while (SDL.Event.poll(out event) == 1)
			{
				if (event.type == SDL.EventType.QUIT)
					running = false;

				if (event.type == SDL.EventType.MOUSEBUTTONDOWN)
					this.application.core.world.getCell(event.button.x / dx, event.button.y / dy).minion_cache[0] = 25600;
			}

			return running;
		}

		public void render()
		{
			SDLGraphics.Rectangle.fill_color(screen, 0, 0, (int16)(this.width), (int16)(this.height), (uint32)0x000000FF);

			int width = this.application.core.world.width;
			int height = this.application.core.world.height;

			int dx = this.width / width;
			int dy = this.height / height;

			for (int x = 0; x < width; x ++)
			{
				for (int y = 0; y < height; y ++)
				{
					SDLGraphics.Rectangle.fill_color(screen, (int16)(dx * x), (int16)(dy * y), (int16)(dx * (x + 1) - 2), (int16)(dy * (y + 1) - 2), (uint32)0xFF0F0F00 + (0x01) * ((this.application.core.world.getCell(x, y).minion[0]).clamp(0, 255)));
				}
			}
		}
	}
}
