
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class SyncEventAnimator : UdonSharpBehaviour
{
    public string playAnimation;
    [HideInInspector, UdonSynced] public bool syncBool;
    [HideInInspector]public bool localBool;

    private Animator[] allAnimators;
    [HideInInspector]public Animator checkAnimator;

    public float delayTime;
    [HideInInspector, UdonSynced] public float curControlTime;


    private void Start()
    {
        Init();
    }

    private void Update()
    {
        curControlTime += Time.deltaTime; 

        
        
    }

    private void LateUpdate()
    {
        //if (Networking.LocalPlayer != null)
        //{
        //    if (Networking.LocalPlayer.isLocal)
        //    {
                if (localBool != syncBool)
                    PlayAnimation();
        //    }
        //}
    }

    private void Init()
    {
        allAnimators = GetComponentsInChildren<Animator>();

        AnimationButton[] buttons = GetComponentsInChildren<AnimationButton>();

        for (int i = 0; i < buttons.Length; i++)
        {
            buttons[i].animatorObject = gameObject;
            buttons[i].Init();
        }

        foreach (var item in allAnimators)
        {
            if ("Bool" == item.GetParameter(0).type.ToString())
            {
                checkAnimator = item;
                break;
            }
        }
    }

    public void Play()
    {
        SendCustomNetworkEvent(VRC.Udon.Common.Interfaces.NetworkEventTarget.All, "SetSync");        
    }

    public void SetSync()
    {
        localBool = !localBool;
        syncBool = !syncBool;
        PlayAnimation();
    }

    void PlayAnimation()
    {

        for (int i = 0; i < allAnimators.Length; i++)
        {
            Animator diff = allAnimators[i];

            if ("Bool" == diff.GetParameter(0).type.ToString()) diff.SetBool(playAnimation , localBool);
            else if ("Trigger" == diff.GetParameter(0).type.ToString()) diff.SetTrigger(playAnimation);
        }

        curControlTime = 0;
    }

    public bool CanControl()
    {
        return delayTime < curControlTime;
    }

}
