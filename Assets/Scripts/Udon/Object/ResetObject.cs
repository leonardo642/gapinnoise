
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class ResetObject : UdonSharpBehaviour
{
    public Vector3 originalPosition;

    void Start()
    {
        originalPosition = transform.position;

        
    }
    public void ResetPos()
    {
        transform.position = originalPosition;
        Debug.Log("hello");
    }
}
