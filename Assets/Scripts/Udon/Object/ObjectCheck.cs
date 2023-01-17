
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class ObjectCheck : UdonSharpBehaviour
{
    void Start()
    {
        
    }

    private void Update()
    {
        Rigidbody rb = GetComponent<Rigidbody>();
        Debug.Log("kinematic " +  rb.isKinematic);
        Debug.Log("mass" + rb.mass);
        Debug.Log("drag " + rb.drag);
        Debug.Log("angularDrag " + rb.angularDrag);
        Debug.Log("constraints " + rb.constraints);
    }
}
