using Microsoft.AspNetCore.Mvc;
using ToponomyApp.Interfaces;

[ApiController]
[Route("api/places")]
public class PlaceController : ControllerBase
{
    private readonly IPlaceRepository _placeRepository;

    public PlaceController(IPlaceRepository placeRepository)
    {
        _placeRepository = placeRepository;
    }

    [HttpGet]
    public IActionResult GetAllPlaces()
    {
        var places = _placeRepository.GetAllPlaces();
        return Ok(places);
    }

    [HttpGet("{id}/show")]
    public IActionResult GetPlaceById(int id)
    {
        var place = _placeRepository.GetPlaceById(id);
        if (place == null)
            return NotFound();

        return Ok(place);
    }

    [HttpPost("store")]
    public IActionResult InsertPlace([FromBody] Place place)
    {
        var createdPlace = _placeRepository.InsertPlace(place);
        return Ok(createdPlace);
    }

    [HttpPut("{id}/update")]
    public IActionResult UpdatePlace(int id, [FromBody] Place updatedPlace)
    {
        var place = _placeRepository.UpdatePlace(id, updatedPlace);
        if (place == null)
            return NotFound();

        return Ok(place);
    }

    [HttpDelete("{id}/delete")]
    public IActionResult SoftDeletePlace(int id)
    {
        var place = _placeRepository.SoftDeletePlace(id);
        if (place == null)
            return NotFound();

        return Ok(place);
    }
}
