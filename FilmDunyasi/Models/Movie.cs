using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace FilmDunyasi.Models
{
    public class Movie
    {
        public int Id { get; set; }

        [Required(ErrorMessage = "Oyun adı zorunludur")]
        public string Title { get; set; } = string.Empty;

        [Required(ErrorMessage = "Yıl zorunludur")]
        public int Year { get; set; }

        public string? Genre { get; set; }
        public string? Platform { get; set; }
        public string? Description { get; set; }

        // YENİ ALAN: NASIL OYNANIR?
        public string? HowToPlay { get; set; }

        public string? ImageUrl { get; set; }

        [NotMapped]
        public IFormFile? ImageFile { get; set; }
    }
}