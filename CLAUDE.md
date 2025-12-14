# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a static HTML website for the **Prague International Go Tournament** (also known as the **Korean Ambassador Cup** and **Old Hunter's Cup**). The site is bilingual (English and Czech) and hosts information about one of Europe's most prestigious Go tournaments with 50+ years of tradition.

The website is manually deployed to http://kac.pagoda.cz/ (contact Josef Moudrik for deployment).

## Repository Structure

- **Root HTML files**: Main pages in pairs (`*.html` for English, `*_cz.html` for Czech)
  - `index.html` / `index_cz.html` - Homepage
  - `registration.html` / `registration_cz.html` - Registration page
  - `details.html` / `details_cz.html` - Tournament details and schedule
  - `site_and_accommodation.html` / `site_and_accommodation_cz.html` - Venue information
  - `sponsors.html` / `sponsors_cz.html` - Sponsor information
  - `contact.html` / `contact_cz.html` - Contact information
  - `fairplay.html` / `fairplay_cz.html` - Fair play rules (sometimes commented out)

- **Static assets**:
  - `style.css` - Main stylesheet
  - `spon/` - Sponsor logos and images
  - `fotky/` - Photos directory
  - Various image files (flags, logos, backgrounds)

- **OLD/**: Archive of previous tournament years (kac14-kac18)

- **Scripts**:
  - `rename.sed` - sed script for updating dates and tournament numbers across HTML files

## Development Workflow

### Deployment

```bash
# Deploy to production server
make deploy
# OR
./deploy.sh
```

Both scripts do the same thing:
1. `git push` - Push changes to remote repository
2. `ssh j2m "cd www-prague-go-tournament; git pull"` - SSH into server and pull changes

Note: The deploy script uses SSH to `j2m` server, so you need appropriate credentials.

### Updating for New Tournament Year

The site uses HTML comments as markers for content that changes yearly:

```html
<!--YEAR-->2026<!--YEAR_END-->
<!--DT_FULL-->1–3 May<!--DTFULL_END-->
```

Common markers include:
- `<!--YEAR-->...<!--YEAR_END-->` - Tournament year
- `<!--DT_FULL-->...<!--DTFULL_END-->` - Full date range
- `<!--DT_EU-->...<!--DT_EU_END-->` - European date format
- `<!--DT_CZ-->...<!--DT_CZ_END-->` - Czech date format
- `<!--NUM_OR-->...<!--NUM_OR_END-->` - Tournament ordinal number

Use `rename.sed` as a template for bulk updates across all HTML files:

```bash
# Apply sed transformations to update dates
sed -i -f rename.sed *.html
```

## Architecture

### HTML Structure

All pages use:
- Bootstrap 3.1.1 for layout and styling
- jQuery 1.11.0 for interactivity
- Custom `style.css` for tournament-specific styling
- Responsive design with mobile navigation

### Navigation Pattern

Each page has a consistent navbar with language switcher. The active page should be marked with appropriate class. Language switcher shows flag icons (cz.png, uk.png) to switch between English and Czech versions.

### Content Sections Across Tournament Lifecycle

The HTML files contain extensive commented-out sections that become active/inactive depending on tournament phase:

1. **Pre-tournament**: Registration buttons, details links active
2. **During/Post-tournament**: Results links, photo galleries, game records (SGF files)
3. **Between tournaments**: "See you next year" messages, links to previous years

When updating content, look for HTML comments (`<!-- -->`) that indicate what should be shown/hidden.

### Sponsor Management

Sponsor logos are stored in `spon/` directory. The main homepage features the "Official Tournament Drink" (Old Hunter's Reserve) prominently. Update sponsor sections in both English and Czech versions simultaneously.

## Key Information

- **Prize budget**: Typically >10,000 EUR
- **Format**: 6 rounds over 3 days
- **Typical dates**: Late April / Early May
- **Venue**: Hotel Olympik (as of 2025)
- **European Grand Prix**: Tournament is typically a Bonus Point Tournament Level-B

## Important Notes

- **Always update both English and Czech versions** when making content changes
- The site is static HTML - no build process or dependencies
- Background image is from Tasuki, licensed under Creative Commons BY-NC-SA 3.0
- External links point to:
  - European Go Database (EGD) for results
  - Google Drive for SGF files
  - Google Photos for galleries
  - Discord for tournament chat (when active)

## Common Tasks

### Add new sponsor logo
1. Add image to `spon/` directory
2. Update `sponsors.html` and `sponsors_cz.html` with new logo and link

### Update tournament results
Update the main page buttons to link to:
- EGD results page
- Google Drive SGF folder
- Photo galleries

### Prepare for next tournament
1. Update `rename.sed` with new dates and year
2. Run sed script on all HTML files
3. Comment out previous year's results/photos
4. Uncomment registration and details sections
5. Update news section in both index files
6. Test both language versions
7. Deploy using `make deploy`
