using UnityEngine;
using System.Collections;
using UnityEngine.UI;

public class GetUsername : MonoBehaviour
{
    public InputField mainInputField;
    public Button button;
    public Text invalidName;

    // Validates the username input field.
    void Validate(InputField input)
    {
        if (input.text.Length > 0)
        {
            SetUsername su = new SetUsername();
            su.call(input.text);
            button.interactable = true;
        }
        else if (input.text.Length == 0)
        {
            button.interactable = false;
            invalidName.enabled = true;
        }
    }

    public void Start()
    {
        invalidName.enabled = false;
        //Adds a listener that invokes the "Validate" method when the player finishes editing the main input field.
        //Passes the main input field into the method when "Validate" is invoked
        mainInputField.onEndEdit.AddListener(delegate { Validate(mainInputField); });
    }
}
