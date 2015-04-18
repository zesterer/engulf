namespace NGulf
{
	public class World
	{
		public Cell[,] cells;

		public int width;
		public int height;

		public int team_count;

		public World(int width, int height, int team_count)
		{
			stdout.printf("Starting World...\n");

			this.width = width;
			this.height = height;

			this.team_count = team_count;

			this.cells = new Cell[this.width, this.height];

			for (int x = 0; x < this.width; x ++)
			{
				for (int y = 0; y < this.height; y ++)
				{
					this.cells[x, y] = new Cell(this, this.team_count, x, y);
				}
			}
		}

		public void tick()
		{
			for (int x = 0; x < this.width; x ++)
			{
				for (int y = 0; y < this.height; y ++)
				{
					this.cells[x, y].pretick();
				}
			}

			for (int x = 0; x < this.width; x ++)
			{
				for (int y = 0; y < this.height; y ++)
				{
					this.cells[x, y].tick();
				}
			}

			for (int x = 0; x < this.width; x ++)
			{
				for (int y = 0; y < this.height; y ++)
				{
					this.cells[x, y].posttick();
				}
			}
		}

		public Cell getCell(int x, int y)
		{
			return this.cells[x.clamp(0, this.width - 1), y.clamp(0, this.height - 1)];
		}
	}

	public class Cell
	{
		public World world;

		public int x;
		public int y;

		public bool solid;

		public int[] minion;
		public int[] minion_cache;

		public Cell(World world, int team_count, int x, int y)
		{
			this.world = world;

			this.x = x;
			this.y = y;

			this.minion = new int[team_count];
			this.minion_cache = new int[team_count];

			for (int count = 0; count < this.minion.length; count ++)
			{
				this.minion[count] = 0;
				this.minion_cache[count] = 0;
			}

			this.solid = false;
		}

		public void pretick()
		{
			for (int team = 0; team < this.minion.length; team ++)
			{
				this.minion[team] = this.minion_cache[team];
			}
		}

		public void tick()
		{
			int pos_r = 0;
			int pos_u = 0;
			int pos_l = 0;
			int pos_d = 0;

			for (int team = 0; team < this.minion.length; team ++)
			{
				int *pos_us = &this.minion[team];
				int val_us = this.minion_cache[team];

				pos_r = this.world.getCell(this.x + 1, this.y + 0).minion_cache[team];
				pos_u = this.world.getCell(this.x + 0, this.y - 1).minion_cache[team];
				pos_l = this.world.getCell(this.x - 1, this.y + 0).minion_cache[team];
				pos_d = this.world.getCell(this.x + 0, this.y + 1).minion_cache[team];

				int average_near = (pos_r + pos_u + pos_l + pos_d) / 4;

				int diff_r = (val_us - pos_r).clamp(-1000, 1000);
				int diff_u = (val_us - pos_u).clamp(-1000, 1000);
				int diff_l = (val_us - pos_l).clamp(-1000, 1000);
				int diff_d = (val_us - pos_d).clamp(-1000, 1000);

				if (pos_r < val_us)
				{
					this.world.getCell(this.x + 1, this.y + 0).minion[team] += diff_r / 8;
					*pos_us -= diff_r / 8;
				}

				if (pos_u < val_us)
				{
					this.world.getCell(this.x + 0, this.y - 1).minion[team] += diff_u / 8;
					*pos_us -= diff_u / 8;
				}

				if (pos_l < val_us)
				{
					this.world.getCell(this.x - 1, this.y + 0).minion[team] += diff_l / 8;
					*pos_us -= diff_l / 8;
				}

				if (pos_d < val_us)
				{
					this.world.getCell(this.x + 0, this.y + 1).minion[team] += diff_d / 8;
					*pos_us -= diff_d / 8;
				}
			}
		}

		public void posttick()
		{
			for (int team = 0; team < this.minion.length; team ++)
			{
				this.minion_cache[team] = this.minion[team];
			}
		}
	}
}
