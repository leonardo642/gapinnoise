
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class ScenePlayerChecker : UdonSharpBehaviour
{
    public GameObject target;

    void Start()
    {
        MeshVisible(false);
    }

    void MeshVisible(bool visible)
    {
        MeshRenderer[] meshes = target.GetComponentsInChildren<MeshRenderer>();

        foreach (var item in meshes)
        {
            item.enabled = visible;
        }
    }
    public override void OnPlayerTriggerEnter(VRCPlayerApi player)
    {
        if (player.isLocal)
            MeshVisible(true);


    }

    public override void OnPlayerTriggerExit(VRCPlayerApi player)
    {
        if (player.isLocal)
            MeshVisible(false);

    }
}
