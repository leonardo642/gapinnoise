
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class AnimationButton : UdonSharpBehaviour
{
    [HideInInspector]public GameObject animatorObject;
    private EventAnimator eventAni;
    private SyncEventAnimator syncEventAni;
    private AnimationDelayDo delayDo;




    public void Init()
    {
        eventAni = animatorObject.GetComponent<EventAnimator>();
        syncEventAni = animatorObject.GetComponent<SyncEventAnimator>();
        delayDo = animatorObject.GetComponent<AnimationDelayDo>();
    }

    public override void Interact()
    {
        Do();
    }

    void Do()
    {
        if (delayDo != null)
        {
            if (syncEventAni.State)
                return;

            delayDo.SendCustomNetworkEvent(VRC.Udon.Common.Interfaces.NetworkEventTarget.Owner, "SetBool");
        }

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
        if (eventAni != null) rtnValue = eventAni.delayTime < eventAni.curControlTime;
        if(syncEventAni != null) rtnValue = syncEventAni.CanControl();
        return rtnValue;
    }
}
