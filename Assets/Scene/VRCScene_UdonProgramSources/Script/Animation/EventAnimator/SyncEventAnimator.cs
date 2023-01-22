
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class SyncEventAnimator : UdonSharpBehaviour
{
    public string playAnimation;
    [HideInInspector, UdonSynced] public bool State;

    private Animator[] allAnimators;
    [HideInInspector]public Animator checkAnimator;

    public float delayTime;
    [HideInInspector] public float curControlTime;


    private void Start()
    {
        Init();
    }

    private void Update()
    {
        curControlTime += Time.deltaTime;      
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
        Networking.SetOwner(Networking.LocalPlayer, gameObject);
        State = !State;
        RequestSerialization();
        PlayAnimation();
    }

    void PlayAnimation()
    {        

        for (int i = 0; i < allAnimators.Length; i++)
        {
            Animator diff = allAnimators[i];

            if ("Bool" == diff.GetParameter(0).type.ToString()) diff.SetBool(playAnimation , State);
            else if ("Trigger" == diff.GetParameter(0).type.ToString()) diff.SetTrigger(playAnimation);
        }

        curControlTime = 0;
    }

    public override void OnDeserialization()
    {
        if(checkAnimator.GetBool(playAnimation) != State)
        {
            PlayAnimation();
        }
            
    }

    public bool CanControl()
    {
        return delayTime < curControlTime;
    }

}
