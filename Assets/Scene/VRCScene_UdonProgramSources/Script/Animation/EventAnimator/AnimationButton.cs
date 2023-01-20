
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

        if(delayDo != null)
        {
            delayDo.goDelay = true;
        }
    }

    public void OnMouseDown()
    {
        Do();
    }

    bool CanControl()
    {
        bool rtnValue = false;
        if (eventAni != null) rtnValue = eventAni.delayTime < eventAni.curControlTime;
        if(syncEventAni != null) rtnValue = syncEventAni.delayTime < syncEventAni.curControlTime;
        return rtnValue;
    }
}
