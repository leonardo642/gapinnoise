
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class ObjectResetManager : UdonSharpBehaviour
{
    public GameObject target;
    public Vector3[] originalPositions { get; set; }
    public Quaternion[] quaternion { get; set; }
    public GameObject[] gameobjects { get; set; }
    public ObjectResetButton resetButton { get; set; }

    void Start()
    {
        Init();    
    }

    private void Init()
    {
        VRC_Pickup[] pickups = (VRC_Pickup[])target.GetComponentsInChildren(typeof(VRC_Pickup));

        gameobjects = new GameObject[pickups.Length];
        originalPositions = new Vector3[pickups.Length];
        quaternion = new Quaternion[pickups.Length];


        for (int i = 0; i < pickups.Length; i++)
        {         
            gameobjects[i] = pickups[i].gameObject;

            originalPositions[i] = pickups[i].gameObject.transform.position;
            quaternion[i] = pickups[i].gameObject.transform.rotation;
        }

        

        resetButton = GetComponentInChildren<ObjectResetButton>();

        resetButton.objectResetManager = this;


    }

    public void ResetButton()
    {

        for (int i = 0; i < gameobjects.Length; i++)
        {
            gameobjects[i].transform.SetPositionAndRotation(originalPositions[i], quaternion[i]);
        }

        Debug.Log("리셋");

    }
}
