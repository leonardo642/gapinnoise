
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class GameobjectManager : UdonSharpBehaviour
{
    //public GameObject[] 
    //void Start()
    //{
        
    //}

    public GameObject GetObjectName(string name)
    {
        GameObject obj = GameObject.Find("name");
        return obj;
    }
}
