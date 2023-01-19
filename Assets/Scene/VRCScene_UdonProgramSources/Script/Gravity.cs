
using System;
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class Gravity : UdonSharpBehaviour
{
    public float jumpImpluse;
    public float walkSpeed;
    public float runSpeed;
    public float strafeSpeed;

    public VRCGravity udon { get; set; }

    private void Start()
    {
        GameObject vrcWorld = GameObject.Find("VRCWorld");
        udon = vrcWorld.GetComponent<VRCGravity>();
        
    }
    void SetGravity(VRCPlayerApi player)
    {
        player.SetJumpImpulse(jumpImpluse);
        player.SetWalkSpeed(walkSpeed);
        player.SetRunSpeed(runSpeed);
        player.SetStrafeSpeed(strafeSpeed);
    }

    void ReleaseGravity(VRCPlayerApi player)
    {
        player.SetJumpImpulse(udon.jump);
        player.SetWalkSpeed(udon.walk);
        player.SetRunSpeed(udon.run);
        player.SetStrafeSpeed(udon.strafe);
    }

    public override void OnPlayerTriggerEnter(VRCPlayerApi player)
    {
        if (player.IsValid())
        {
            if (player.isLocal)
            {
                SetGravity(player);
            }
        }
        
        
    }

    public override void OnPlayerTriggerExit(VRCPlayerApi player)
    {
        if (player.IsValid())
        {
            if (player.isLocal)
            {
                ReleaseGravity(player);
            }
        }

            
        
    }
}
