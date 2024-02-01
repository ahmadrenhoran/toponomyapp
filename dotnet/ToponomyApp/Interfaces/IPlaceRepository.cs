using ToponomyApp.Data;

namespace ToponomyApp.Interfaces
{
    public interface IPlaceRepository
    {
        IEnumerable<Place> GetAllPlaces();
        Place GetPlaceById(int id);
        Place InsertPlace(Place place);
        Place UpdatePlace(int id, Place updatedPlace);
        Place SoftDeletePlace(int id);
    
    }
 
}