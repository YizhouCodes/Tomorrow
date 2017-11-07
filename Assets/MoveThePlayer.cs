using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MoveThePlayer : MonoBehaviour {

    public int speed;
    void Start()
    {
     
    }
    void Update ()
    {
        float v = Input.GetAxis("Vertical");
        float h = Input.GetAxis("Horizontal");
        Vector3 cur = transform.position;
        cur.x += h * 0.3f;
        cur.z += v * 0.3f;
        transform.position = cur;
        }
}
