using System.Collections.Generic;
using System.Xml;
using UnityEngine;

namespace Maps
{
    public class Way
    {
        public XmlNode Node { get; private set; }

        public List<Node> Nodes { get; private set; }

        public Way(XmlNode node, List<Node> nodes)
        {
            Node = node;
            Nodes = nodes;
        }

        public Vector3 GetCenter()
        {
            Vector3 total = Vector3.zero;

            foreach (Node node in Nodes)
            {
                total += node;
            }

            return total / Nodes.Count;
        }
    }
}
