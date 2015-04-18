namespace NGulf
{
	public class Core
	{
		public World world;

		public Core()
		{
			this.world = new World(160, 120, 2);
		}

		public void tick()
		{
			this.world.tick();
		}
	}
}
