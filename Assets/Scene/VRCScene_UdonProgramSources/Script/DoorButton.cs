
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class DoorButton : UdonSharpBehaviour
{
    public GameObject animatorObject;
    private EventAnimator eventAni;
    private SyncEventAnimator syncEventAni;

    public void Init()
    {
        eventAni = animatorObject.GetComponent<EventAnimator>();
        syncEventAni = animatorObject.GetComponent<SyncEventAnimator>();
    }

    //public override void Interact()
    //{
    //    if (eventAni != null)
    //        eventAni.Play();

    //    if (syncEventAni != null)
    //        syncEventAni.Play();
    //}

    //public void OnMouseDown()
    //{
    //    if (eventAni != null)
    //        eventAni.Play();

    //    if (syncEventAni != null)
    //        syncEventAni.Play();
    //}
}
