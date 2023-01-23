
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class EscalatorStair : UdonSharpBehaviour
{
    public escalator escal;

    public void OnTriggerStay(Collider other)
    {
        VRC_Pickup trig = (VRC_Pickup)other.GetComponent(typeof(VRC_Pickup));
        if(trig != null)
        {
            Rigidbody rb = trig.GetComponent<Rigidbody>();
            Vector3 diff = escal.target.transform.position - trig.transform.position;
            rb.velocity = ((new Vector3(diff.normalized.x, rb.transform.position.y, rb.transform.position.z)).normalized * escal.speed);
        }
    }
    //public override void OnPlayerTriggerStay(VRCPlayerApi player)
    //{
    //    Debug.Log("Playerrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr asd");
        
    //}
    public override void OnPlayerTriggerStay(VRCPlayerApi player)
    {
        Debug.Log("Playerrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr asd");
        Vector3 diff = escal.target.transform.position - player.GetPosition();
        player.SetVelocity(diff.normalized * escal.speed);
        //player.gameObject.transform.SetParent(gameObject);
    }

    public override void OnPlayerTriggerEnter(VRCPlayerApi player)
    {
        //player.gameObject.transform.SetParent(transform);
    }

}
