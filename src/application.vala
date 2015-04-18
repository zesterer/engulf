namespace NGulf
{
	public class Application
	{
		public Core core;
		public Renderer renderer;

		public bool running;

		public Application(string[] args)
		{
			stdout.printf("Starting Application...\n");

			this.core = new Core();
			this.renderer = new Renderer(this);

			this.running = true;
		}

		public void run()
		{
			while (this.running)
			{
				this.core.tick();
				this.running &= this.renderer.run();
			}
		}
	}
}
