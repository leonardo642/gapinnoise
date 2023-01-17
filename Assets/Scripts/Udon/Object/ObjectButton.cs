
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class ObjectButton : UdonSharpBehaviour
{
    [HideInInspector]public ObjectManager objectManager;
    void Start()
    {
        
    }

    public override void Interact()
    {
        Debug.Log("눌렀음");
    }
}
