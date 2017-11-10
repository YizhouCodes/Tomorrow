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
            button.interactable = true;
            invalidName.enabled = false;
        }
        else if (input.text.Length == 0)
        {
            button.interactable = false;
            invalidName.enabled = true;
        }
    }

    // Handles the persistence of username.
    void Persist(InputField input)
    {
        if (input.text.Length > 0)
        {
            SetUsername su = new SetUsername();
            su.call(input.text);
        }
    }

    public void Start()
    {
        invalidName.enabled = false;

        mainInputField.onValueChanged.AddListener(delegate { Validate(mainInputField); });
        mainInputField.onEndEdit.AddListener(delegate { Validate(mainInputField); });
        mainInputField.onEndEdit.AddListener(delegate { Persist(mainInputField); });
    }
}
