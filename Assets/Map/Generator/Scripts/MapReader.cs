using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml;
using UnityEngine;

namespace Maps
{
    static public class MapReader
    {
        static public Map GetMap(TextAsset data)
        {
            XmlDocument mapData = new XmlDocument();
            mapData.LoadXml(data.text);

            Bounds bounds = new Bounds(mapData.SelectSingleNode("/osm/bounds"));
            List<Way> boundaries = new List<Way>();
            List<Way> lines = new List<Way>();

            Dictionary<ulong, Node> nodesDictionary = GetNodes(mapData.SelectNodes("/osm/node"));

            XmlNodeList xmlWays = mapData.SelectNodes("/osm/way");
            foreach (XmlNode xmlWay in xmlWays)
            {
                List<Node> nodes = GetWayNodes(xmlWay, nodesDictionary);

                if (nodes[0] == nodes[nodes.Count - 1])
                {
                    boundaries.Add(new Way(xmlWay, nodes));
                }
                else
                {
                    lines.Add(new Way(xmlWay, nodes));
                }
            }

            return new Map(bounds, boundaries, lines);
        }

        static List<Node> GetWayNodes(XmlNode node, Dictionary<ulong, Node> nodesDictionary)
        {
            List<Node> nodes = new List<Node>();

            XmlNodeList nds = node.SelectNodes("nd");

            foreach (XmlNode n in nds)
            {
                nodes.Add(nodesDictionary[XmlGetter.GetAttribute<ulong>("ref", n.Attributes)]);
            }

            return nodes;
        }

        static Dictionary<ulong, Node> GetNodes(XmlNodeList xmlNodeList)
        {
            Dictionary<ulong, Node> nodes = new Dictionary<ulong, Node>();

            foreach (XmlNode n in xmlNodeList)
            {
                Node node = new Node(n);
                nodes[node.ID] = node;
            }

            return nodes;
        }
    }
}
