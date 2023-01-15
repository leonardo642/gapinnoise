
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class Portal : UdonSharpBehaviour
{
    public void OnTriggerEnter(Collider other)
    {
        //Mover mover = other.GetComponent<Mover>();
        //if(mover != null)
            other.transform.position = new Vector3(-5.35f, other.transform.position.y, -2.37f);
    }
}
