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

			this.cells[this.width / 2, this.height / 2].minion_count[0] = 25600;
		}

		public void tick()
		{
			for (int x = 0; x < this.width; x ++)
			{
				for (int y = 0; y < this.height; y ++)
				{
					this.cells[x, y].tick();
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

		public int[] minion_count;

		public Cell(World world, int team_count, int x, int y)
		{
			this.world = world;

			this.x = x;
			this.y = y;

			this.minion_count = new int[team_count];

			for (int count = 0; count < this.minion_count.length; count ++)
			{
				this.minion_count[count] = 0;
			}

			this.solid = false;
		}

		public void tick()
		{
			int *pos_r = null;
			int *pos_u = null;
			int *pos_l = null;
			int *pos_d = null;

			for (int team = 0; team < this.minion_count.length; team ++)
			{
				int *pos_us = &this.minion_count[team];
				int val_us = this.minion_count[team];

				pos_r = &this.world.getCell(this.x + 1, this.y + 0).minion_count[team];
				pos_u = &this.world.getCell(this.x + 0, this.y - 1).minion_count[team];
				pos_l = &this.world.getCell(this.x - 1, this.y + 0).minion_count[team];
				pos_d = &this.world.getCell(this.x + 0, this.y + 1).minion_count[team];

				int average_near = (*pos_r + *pos_u + *pos_l + *pos_d) / 4;

				int diff_r = *pos_us - *pos_r;
				int diff_u = *pos_us - *pos_u;
				int diff_l = *pos_us - *pos_l;
				int diff_d = *pos_us - *pos_d;

				if (*pos_r < val_us)
				{
					*pos_r += diff_r / 50 + 1;
					*pos_us -= diff_r / 50 + 1;
				}

				if (*pos_u < val_us)
				{
					*pos_u += diff_u / 50 + 1;
					*pos_us -= diff_u / 50 + 1;
				}

				if (*pos_l < val_us)
				{
					*pos_l += diff_l / 50 + 1;
					*pos_us -= diff_l / 50 + 1;
				}

				if (*pos_d < val_us)
				{
					*pos_d += diff_d / 50 + 1;
					*pos_us -= diff_d / 50 + 1;
				}
			}
		}
	}
}
