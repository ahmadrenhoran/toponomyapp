// AuthController.cs
using Microsoft.AspNetCore.Mvc;
using ToponomyApp.Data;
using ToponomyApp.Interfaces;

[ApiController]
[Route("api/auth")]
public class AuthController : ControllerBase
{
    private readonly IUserRepository _userRepository;

    public AuthController(IUserRepository userRepository)
    {
        _userRepository = userRepository;
    }

    [HttpPost("register")]

    [ProducesResponseType(200)]
    public async Task<IActionResult> Register([FromBody] User user)
    {
        var existingUser = await _userRepository.GetUserByEmailAsync(user.Email);

        if (existingUser != null)
        {
            return BadRequest("User with this email already exists.");
        }

        var createdUser = await _userRepository.CreateUserAsync(user);

        return Ok(createdUser);
    }

    [HttpPost("login")]
    [ProducesResponseType(200)]
    public async Task<IActionResult> Login([FromBody] User user)
    {
        var existingUser = await _userRepository.GetUserByEmailAsync(user.Email);

        if (existingUser == null || existingUser.Password != user.Password)
        {
            return Unauthorized("Invalid email or password.");
        }

        return Ok(existingUser);
    }
}
