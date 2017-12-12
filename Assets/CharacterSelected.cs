using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CharacterSelected : MonoBehaviour {
    public GameObject Char1, Char2, Char3, Char4, Char5, Char6;
    // Use this for initialization
    public void UpdateObject () {
        HideOtherCharacters(DataController.Instance.player_data.player_character);
    }

    private void HideOtherCharacters(string activeCharacter)
    {
        Char1.SetActive(false);
        Char2.SetActive(false);
        Char3.SetActive(false);
        Char4.SetActive(false);
        Char5.SetActive(false);
        Char6.SetActive(false);


        if (activeCharacter.CompareTo("char1") == 0)
        {
            Char1.SetActive(true);
        }
        else if (activeCharacter.CompareTo("char2") == 0)
        {
            Char2.SetActive(true);
        }
        else if (activeCharacter.CompareTo("char3") == 0)
        {
            Char3.SetActive(true);
        }
        else if (activeCharacter.CompareTo("char4") == 0)
        {
            Char4.SetActive(true);
        }
        else if (activeCharacter.CompareTo("char5") == 0)
        {
            Char5.SetActive(true);
        }
        else if (activeCharacter.CompareTo("char6") == 0)
        {
            Char6.SetActive(true);
        }
    }
}
