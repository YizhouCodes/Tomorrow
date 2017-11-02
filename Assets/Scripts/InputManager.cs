using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class InputManager : GenericSingleton<InputManager>
{
	public event Action<float> pinch;
	public event Action<float> rotate;
	public event Action<Vector2> click;
	public event Action<Vector2> doubleClick;

	void Update()
	{
		if (Input.touchCount == 0)
			KeyboardInput ();
		else
			TouchInput ();
	}

	void KeyboardInput()
	{
		pinch (Input.GetAxis("Mouse ScrollWheel") * 10);
		rotate (Input.GetAxis("Mouse X"));
	}

	void TouchInput()
	{
        Touch[] touches = Input.touches;
		if (Input.touchCount == 2 && (touches[0].phase == TouchPhase.Moved || touches[1].phase == TouchPhase.Moved))
            TouchPinchAndRotate(touches[0], touches[1]);
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
