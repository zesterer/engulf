namespace NGulf
{
	public class Core
	{
		public World world;

		public Core()
		{
			this.world = new World(128, 96, 2);
		}

		public void tick()
		{
			this.world.tick();
		}
	}
}
