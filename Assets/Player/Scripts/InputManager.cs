using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class InputManager : GenericSingleton<InputManager>
{
	public event Action<float> pinch;
	public event Action<float> rotate;
    public event Action<float, float> locationChanged;
    public event Action<Vector3> move;
    public bool isEditor;

    float longitude, latitude;

    private void Start()
    {
        isEditor = Application.isEditor;
        if (isEditor)
        {
            StartLocationService();
        }
    }

    private IEnumerator StartLocationService()
    {
        if (!Input.location.isEnabledByUser)
        {
            Debug.Log("jee");
            yield break;
        }
        Input.location.Start();
        int maxWait = 10;
        while (Input.location.status == LocationServiceStatus.Initializing && maxWait > 0)
        {
            yield return new WaitForSeconds(1);
            maxWait--;
        }
        if(maxWait <= 0 || Input.location.status == LocationServiceStatus.Failed)
        {
            Debug.Log("joo");
            yield break;
        }
        locationChanged(Input.location.lastData.longitude, Input.location.lastData.latitude);
    }

    void Update()
	{
        if (isEditor)
        {
            EditorInput();
        }
        else
        {
            MobileInput();
        }
	}

	void EditorInput()
	{
		pinch (Input.GetAxis("Mouse ScrollWheel") * 10);
		rotate (Input.GetAxis("Mouse X"));
        move(new Vector3(Input.GetAxis("Horizontal"), 0 , Input.GetAxis("Vertical")));
	}

	void MobileInput()
	{
        Touch[] touches = Input.touches;
		if (Input.touchCount == 2 && (touches[0].phase == TouchPhase.Moved || touches[1].phase == TouchPhase.Moved))
            TouchPinchAndRotate(touches[0], touches[1]);
        locationChanged(Input.location.lastData.longitude, Input.location.lastData.latitude);
	}

    //Handles multitouch zoom and rotation
    void TouchPinchAndRotate(Touch touch0, Touch touch1)
    {
        Vector2 touch = touch0.position - touch1.position;
        Vector2 prevTouch = (touch0.position - touch0.deltaPosition) -
            (touch1.position - touch1.deltaPosition);

        //Zoom
        pinch((prevTouch.magnitude - touch.magnitude) * 0.2f);

        //Rotation
        touch = touch.x > 0 ? touch : -touch;
        prevTouch = prevTouch.x > 0 ? prevTouch : -prevTouch;

        float amount = Vector2.Dot(Vector2.up, touch.normalized) - Vector2.Dot(Vector2.up, prevTouch.normalized);
        if (Mathf.Abs(amount) <= 1)
            rotate(amount * 100);
    }
}
