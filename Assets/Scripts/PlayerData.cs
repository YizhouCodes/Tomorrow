[System.Serializable]
public class PlayerData
{
    public string username;
    public Hotspot[] hotspots;
    public int hotspots_count;
    public int visited_count;
    public string player_color;
    public string player_character;
    public float progress;

    public Hotspot FindHotspot(int id)
    {
        Hotspot hs = new Hotspot();
        foreach (Hotspot hotspot in hotspots)
        {
            if (hotspot.id == id)
            {
                hs = hotspot;
                break;
            }
        }
        return hs;
    }
}
