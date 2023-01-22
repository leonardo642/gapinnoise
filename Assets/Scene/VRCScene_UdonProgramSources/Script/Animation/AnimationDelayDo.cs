
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class AnimationDelayDo : UdonSharpBehaviour
{
    private SyncEventAnimator syncAnimator;
    [HideInInspector]public bool goDelay;
    [HideInInspector] private float curTime;
    public float delayTime;

    private void Start()
    {
        syncAnimator = GetComponent<SyncEventAnimator>();
    }

    private void Update()
    {
        if (goDelay)
        {
            curTime += Time.deltaTime;

            if (delayTime < curTime)
            {
                if (syncAnimator.State)
                {
                    Do();
                }
            }
        }             
    }

    public void SetBool()
    {
        if (goDelay)
        {
            curTime = 0;
            return;
        }
        

        goDelay = true;
    }

    void Do()
    {
        syncAnimator.Play();
        goDelay = false;
        curTime = 0;
    }
}
