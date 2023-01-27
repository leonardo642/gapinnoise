
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class FerrisChair : UdonSharpBehaviour
{
    public int curNode;

    //private void Update()
    //{
    //    //if (Input.GetKeyDown(KeyCode.W)){
    //    //    //OnStationExited(Networking.LocalPlayer);
    //    //}
    //}

    public override void Interact()
    {
        Networking.LocalPlayer.UseAttachedStation();
    }
}
