using System.Collections.Generic;

namespace Maps
{
    public class Map
    {
        public Bounds Bounds { get; private set; }
        public List<Way> Boundaries { get; private set; }
        public List<Way> Lines { get; private set; }

        public Map(Bounds bounds, List<Way> boundaries, List<Way> lines)
        {
            Bounds = bounds;
            Boundaries = boundaries;
            Lines = lines;
        }
    }
}
