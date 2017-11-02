using System.Xml;
using UnityEngine;

namespace Maps
{
    public class Bounds
    {
        public float MinLat { get; private set; }
        public float MaxLat { get; private set; }
        public float MinLon { get; private set; }
        public float MaxLon { get; private set; }

        public Vector3 Center { get; private set; }

        public Bounds(XmlNode node)
        {
            MinLat = XmlGetter.GetAttribute<float>("minlat", node.Attributes);
            MaxLat = XmlGetter.GetAttribute<float>("maxlat", node.Attributes);
            MinLon = XmlGetter.GetAttribute<float>("minlon", node.Attributes);
            MaxLon = XmlGetter.GetAttribute<float>("maxlon", node.Attributes);

            float x = (float)((MercatorProjection.lonToX(MaxLon) + MercatorProjection.lonToX(MinLon)) / 2);
            float y = (float)((MercatorProjection.latToY(MaxLat) + MercatorProjection.latToY(MinLat)) / 2);
            Center = new Vector3(x, 0, y);
        }
    }
}
