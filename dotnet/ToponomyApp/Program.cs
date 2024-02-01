using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using ToponomyApp.Data;
using ToponomyApp.Interfaces;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
builder.Services.AddScoped<IUserRepository, UserRepository>();
builder.Services.AddScoped<IPlaceRepository, PlaceRepository>();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddDbContext<DataContext>(options => 
{
    // Untuk menggunakan PostgreSQL database dan juga mengkoneksikan dengan database yang sudah dibuat melalui Connection String
    options.UseNpgsql(builder.Configuration.GetConnectionString("DefaultConnection"));
});

// builder.Services.AddIdentityCore<IdentityUser>().AddEntityFrameworkStores<DataContext>().AddApiEndpoints();
// builder.Services.AddAuthentication().AddBearerToken(IdentityConstants.BearerScheme);
// builder.Services.AddAuthorizationBuilder();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

// app.MapIdentityApi<IdentityUser>();

app.MapControllers();

app.Run();
