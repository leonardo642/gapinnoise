
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class VRCGravity : UdonSharpBehaviour
{
    public float jump = 3;
    public float walk = 2;
    public float run = 4;
    public float strafe = 2;

    private void Start()
    {
        Networking.LocalPlayer.SetJumpImpulse(jump);
        Networking.LocalPlayer.SetWalkSpeed(walk);
        Networking.LocalPlayer.SetRunSpeed(run);
        Networking.LocalPlayer.SetStrafeSpeed(strafe);
    }
}
