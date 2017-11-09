using System;
using System.Xml;

namespace Maps
{
    static public class XmlGetter
    {
        static public T GetAttribute<T>(string attributeName, XmlAttributeCollection attributes)
        {
            string strValue = attributes[attributeName].Value;
            return (T)Convert.ChangeType(strValue, typeof(T));
        }
    }
}
