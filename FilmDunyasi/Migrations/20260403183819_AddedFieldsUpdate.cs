using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace FilmDunyasi.Migrations
{
    /// <inheritdoc />
    public partial class AddedFieldsUpdate : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "HowToPlay",
                table: "Movies",
                type: "nvarchar(max)",
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "HowToPlay",
                table: "Movies");
        }
    }
}
