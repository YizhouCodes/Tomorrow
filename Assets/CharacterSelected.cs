using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CharacterSelected : MonoBehaviour {

    public GameObject char1, char2, char3, char4, char5, char6;
    // Use this for initialization
    public void Start () {
        HideOtherCharacters(DataController.Instance.player_data.player_character);
    }

    private void HideOtherCharacters(string activeCharacter)
    {
        GameObject[] objs = { char1, char2, char3, char4, char5, char6 };

        int i = 1;
        foreach(GameObject obj in objs)
        {
            obj.SetActive(false);
            if (activeCharacter.Equals("char" + i.ToString()))
            {
                obj.SetActive(true);
            }
            i++;
        }
    }
}
