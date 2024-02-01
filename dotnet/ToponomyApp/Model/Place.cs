using ToponomyApp.Data;

public class Place
{
    public int Id { get; set; }
    public string OwnerId { get; set; }
    public string PlaceName { get; set; }
    public string Address { get; set; }
    public string PlaceType { get; set; }
    public DateTime Date { get; set; }
    public bool IsDeleted { get; set; }
}
