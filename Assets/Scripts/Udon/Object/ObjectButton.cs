
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class ObjectButton : UdonSharpBehaviour
{
    [HideInInspector]public ObjectManager objectManager;
    void Start()
    {
        Vector3 a = new Vector3();

        Vector3[] b = new Vector3[10];
    }

    public override void Interact()
    {
        Debug.Log("눌렀음");
    }
}
