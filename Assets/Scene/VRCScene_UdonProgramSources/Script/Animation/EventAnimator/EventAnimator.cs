
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class EventAnimator : UdonSharpBehaviour
{
    public string openName;
    [HideInInspector] public bool doBool;

    private Animator[] allAnimators;

    public float delayTime;
    [HideInInspector] public float curControlTime;

    private void Start()
    {
        Init();
    }

    public void Update()
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
    }

    public void Play()
    {
        SendCustomEventDelayedSeconds("PlayAnimation", delayTime);        
    }

    public void PlayAnimation()
    {
        doBool = !doBool;

        for (int i = 0; i < allAnimators.Length; i++)
        {
            Animator diff = allAnimators[i];

            if ("Bool" == diff.GetParameter(0).type.ToString()) diff.SetBool(openName, doBool);
            else if ("Trigger" == diff.GetParameter(0).ToString()) diff.SetTrigger(openName);
        }

        curControlTime = 0;
    }
}
