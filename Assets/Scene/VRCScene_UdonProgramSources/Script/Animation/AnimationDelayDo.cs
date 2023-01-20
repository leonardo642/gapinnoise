
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class AnimationDelayDo : UdonSharpBehaviour
{
    private SyncEventAnimator syncAnimator;
    [HideInInspector]public bool goDelay;
    public float delayTime;
    public float curTime;

    private void Start()
    {
        syncAnimator = GetComponent<SyncEventAnimator>();
        AnimationButton[] animationButton = GetComponentsInChildren<AnimationButton>();

        for (int i = 0; i < animationButton.Length; i++)
        {
            animationButton[i].Init();
        }


    }

    private void Update()
    {
        if (goDelay)
        {
            curTime += Time.deltaTime;

            if(delayTime < curTime)
            {
                if(syncAnimator.syncBool)
                    Do();
            }
        }           
    }

    public void SetBool()
    {
        Debug.Log("changed");
        goDelay = true;
    }

    void Do()
    {
        syncAnimator.SendCustomNetworkEvent(VRC.Udon.Common.Interfaces.NetworkEventTarget.All, "SetSync");
        goDelay = false;
        curTime = 0;
    }
}
