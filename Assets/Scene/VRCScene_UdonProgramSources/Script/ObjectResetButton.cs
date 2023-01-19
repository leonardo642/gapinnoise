
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class ObjectResetButton : UdonSharpBehaviour
{
    public ObjectResetManager objectResetManager { get; set; }

    public override void Interact()
    {
        //base.Interact();
        objectResetManager.ResetButton();
    }

    public void OnMouseDown()
    {
        objectResetManager.ResetButton();

        Debug.Log(":asd");
    }
}
