
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class PoolManager : UdonSharpBehaviour
{
    [HideInInspector] public Manager manager;

    public GameObject obj;
    void Start()
    {
        CreateObj();
    }

    public void CreateObj()
    {
        GameObject a = VRCInstantiate(obj);
        a.transform.position = transform.position;
    }
}
