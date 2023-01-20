
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class AnimationButton : UdonSharpBehaviour
{
    [HideInInspector]public GameObject animatorObject;
    private EventAnimator eventAni;
    private SyncEventAnimator syncEventAni;

    

    
    public void Init()
    {
        eventAni = animatorObject.GetComponent<EventAnimator>();
        syncEventAni = animatorObject.GetComponent<SyncEventAnimator>();
    }

    public override void Interact()
    {
        Do();
    }

    void Do()
    {
        

        if (eventAni != null)
        {
            if (!CanControl())
                return;

            eventAni.Play();
        }

        if (syncEventAni != null)
        {
            if (!CanControl())
                return;            

            syncEventAni.Play();
        }
    }

    public void OnMouseDown()
    {
        //Do();
    }

    bool CanControl()
    {
        bool rtnValue = false;
        if (eventAni != null) rtnValue = eventAni.canControlTime < eventAni.curControlTime;
        if(syncEventAni != null) rtnValue = syncEventAni.canControlTime < syncEventAni.curControlTime;
        return rtnValue;
    }
}
