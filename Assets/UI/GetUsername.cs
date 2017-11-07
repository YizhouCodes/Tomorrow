using UnityEngine;
using System.Collections;
using UnityEngine.UI; // Required when Using UI elements.

public class GetUsername : MonoBehaviour
{
    public InputField mainInputField;

    void Validate(InputField input)
    {
        if (input.text.Length > 0)
        {
            SetUsername su = new SetUsername();
            su.call(input.text);
        }
       
    }

    public void Start()
    {
        //Adds a listener that invokes the "Validate" method when the player finishes editing the main input field.
        //Passes the main input field into the method when "Validate" is invoked
        mainInputField.onEndEdit.AddListener(delegate { Validate(mainInputField); });
    }
}
