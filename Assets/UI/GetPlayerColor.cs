using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class GetPlayerColor : MonoBehaviour {

    private Button cur_button;
    private Button[] buttons;

    public void Start()
    {
        buttons = transform.GetComponentsInChildren<Button>();
        cur_button = buttons[0];

        foreach (Button button in buttons)
        {
            if (button == cur_button)
            {
                button.interactable = false;
                SaveColor(button.name);
            }
            button.onClick.AddListener(() => ButtonOnClick(button));
        }
    }

    // It persists the color
    void SaveColor(string name)
    {
        SetPlayerColor spc = new SetPlayerColor();
        spc.call(name);
    }

    // Changes the selected button
    void ButtonOnClick(Button pressed)
    {
        foreach (Button button in buttons)
        {
            if (button == pressed)
            {
                button.interactable = false;
                SaveColor(button.name);
            }
            else
            {
                button.interactable = true;
            }
        }
    }

}
