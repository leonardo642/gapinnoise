
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class ObjectManager : UdonSharpBehaviour
{

    public GameObject[] gameobjects;
    public ObjectButton objectButton;
    void Start()
    {
        objectButton.objectManager = this;
    }


    public void Do()
    {
        for (int i = 0; i < gameobjects.Length; i++)
        {
            ResetObject resetObject = gameobjects[i].GetComponent<ResetObject>();
            resetObject.ResetPos();
        }
    }
}
