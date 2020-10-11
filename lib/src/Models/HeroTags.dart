const Cast = 'hero_tag_cast_';
const Image = 'hero_tag_image_';
const MoviePoster = 'hero_tag_movie_poster_';

const Map<EHeroType, String> _typeToTag = {
  EHeroType.Cast: Cast,
  EHeroType.Image: Image,
  EHeroType.Poster: MoviePoster,
};

enum EHeroType { Cast, Image, Poster }

class HeroTags {
  static String build<T>(T id, EHeroType type) {
    assert(id != null);

    return '${_typeToTag[type]}$id';
  }
}
