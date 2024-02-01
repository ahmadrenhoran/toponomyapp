using Microsoft.EntityFrameworkCore;


namespace ToponomyApp.Data
{
    public class DataContext : DbContext
    {
        public DataContext(DbContextOptions<DataContext> options) : base(options)
        {

        }
        public DbSet<User> Users { get; set; }
        public DbSet<Place> Places { get; set; }
    }
}