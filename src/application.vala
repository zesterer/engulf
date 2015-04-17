namespace NGulf
{
	public class Application
	{
		public Renderer renderer;

		public bool running;

		public Application(string[] args)
		{
			stdout.printf("Starting Application...\n");

			this.renderer = new Renderer(this);

			this.running = true;
		}

		public void run()
		{
			while (this.running)
			{
				this.running &= this.renderer.run();
			}
		}
	}
}
