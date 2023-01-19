
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class Teleport : UdonSharpBehaviour
{
    public Transform target;

    public void Move(VRCPlayerApi player)
    {
        player.TeleportTo(target.position, target.rotation);
    }

    public override void OnPlayerTriggerEnter(VRCPlayerApi player)
    {
        if (player.IsValid())
        {
            if (player.isLocal)
            {
                Move(player);
            }
        }


    }
}
