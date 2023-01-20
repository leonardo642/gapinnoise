
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class SyncEventAnimator : UdonSharpBehaviour
{
    [HideInInspector, UdonSynced] public bool syncBool;

    private Animator[] allAnimators;
    private Animator checkAnimator;

    public float delayTime;

    public float canControlTime;
    [HideInInspector] public float curControlTime;


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
        if (checkAnimator.GetBool("BOOL") != syncBool && canControlTime < curControlTime)
        {                
            PlayAnimation();
        }
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
            if("BOOL" == item.GetParameter(0).name)
            {
                checkAnimator = item;
                break;
            }
        }
    }

    public void Play()
    {
        Debug.Log("플레이!");
        SendCustomNetworkEvent(VRC.Udon.Common.Interfaces.NetworkEventTarget.All, "SyncTest");
    }

    public void SyncTest()
    {
        Debug.Log("씽크 불 맞추기!!");
        syncBool = !syncBool;
    }

    void PlayAnimation()
    {
        Debug.Log("실행");
        for (int i = 0; i < allAnimators.Length; i++)
        {
            Animator diff = allAnimators[i];

            if ("BOOL" == diff.GetParameter(0).name) diff.SetBool("BOOL", syncBool);
            else if ("TRIGGER" == diff.GetParameter(0).name) diff.SetTrigger("TRIGGER");
        }

        curControlTime = 0;
    }
}
