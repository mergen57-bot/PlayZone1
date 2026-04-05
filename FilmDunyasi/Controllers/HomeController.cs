using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using FilmDunyasi.Data; // Proje adın farklıysa burayı düzelt
using System.Linq;

namespace FilmDunyasi.Controllers
{
    public class HomeController : Controller
    {
        private readonly ApplicationDbContext _context;

        public HomeController(ApplicationDbContext context)
        {
            _context = context;
        }

        public async Task<IActionResult> Index()
        {
            // Veritabanındaki tüm oyunları listelemesi için sayfaya gönderiyoruz
            var movies = await _context.Movies.ToListAsync();
            return View(movies);
        }
    }
}