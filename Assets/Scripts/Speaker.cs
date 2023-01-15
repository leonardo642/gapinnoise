using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class Speaker : UdonSharpBehaviour
{
    public override void OnPlayerTriggerEnter(VRCPlayerApi player)
    {
        if (player.IsValid())
        {
            if (player.isLocal)
            {
                Debug.Log("hello");
            }
        }
    }
}
