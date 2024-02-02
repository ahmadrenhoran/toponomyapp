using ToponomyApp.Data;
using ToponomyApp.Interfaces;

public class PlaceRepository : IPlaceRepository
{
    private readonly DataContext _context;

    public PlaceRepository(DataContext context)
    {
        _context = context;
    }

    public IEnumerable<Place> GetAllPlaces()
    {
        return _context.Places.Where(p => !p.IsDeleted).ToList();
    }

    public Place GetPlaceById(int id)
    {
        return _context.Places.FirstOrDefault(p => p.Id == id && !p.IsDeleted);
    }

    public Place InsertPlace(Place place)
    {
        _context.Places.Add(place);
        _context.SaveChanges();
        return place;
    }

    public Place UpdatePlace(int id, Place updatedPlace)
    {
        var place = _context.Places.FirstOrDefault(p => p.Id == id && !p.IsDeleted);
        if (place == null)
            return null;

        place.PlaceName = updatedPlace.PlaceName;
        place.Address = updatedPlace.Address;
        place.PlaceType = updatedPlace.PlaceType;
        place.Latitude = updatedPlace.Latitude;
        place.Longitude = updatedPlace.Longitude;
        place.Date = updatedPlace.Date;

        _context.SaveChanges();
        return place;
    }

    public Place SoftDeletePlace(int id)
    {
        var place = _context.Places.FirstOrDefault(p => p.Id == id && !p.IsDeleted);
        if (place == null)
            return null;

        place.IsDeleted = true;
        _context.SaveChanges();
        return place;
    }
}
