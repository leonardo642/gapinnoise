using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class Mover : UdonSharpBehaviour
{
    public Vector3 movePos;

    public void FixedUpdate()
    {
        transform.position += movePos *Time.fixedDeltaTime;
    }
}
