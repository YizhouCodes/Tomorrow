using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class button_group : MonoBehaviour {

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
            }
            button.onClick.AddListener(() => ButtonOnClick(button));
        }
    }

    void ButtonOnClick(Button pressed)
    {
        foreach (Button button in buttons)
        {
            if (button == pressed)
            {
                button.interactable = false;
            }
            else
            {
                button.interactable = true;
            }
        }
    }

}
