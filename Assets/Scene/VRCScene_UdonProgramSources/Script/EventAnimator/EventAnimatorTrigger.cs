
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class EventAnimatorTrigger : UdonSharpBehaviour
{    
    [HideInInspector] public Animator[] animators;
    [HideInInspector] public Animator checkAnimator;

    private void Start()
    {
        animators = GetComponentsInChildren<Animator>();

        for (int i = 0; i < animators.Length; i++)
        {
            if (animators[i].GetParameter(0).name == "DoTrigger")
            {
                checkAnimator = animators[i];
                break;
            }
        }
    }

    public void Play()
    {
#if UNITY_EDITOR
        PlayerAnimations();
#else
        SendCustomNetworkEvent(VRC.Udon.Common.Interfaces.NetworkEventTarget.Owner, "PlayerAnimations");
#endif

    }

    public void PlayerAnimations()
    {
        for (int i = 0; i < animators.Length; i++)
        {
            if (animators[i].GetParameter(0).name == checkAnimator.GetParameter(0).name)
                animators[i].SetTrigger("DoTrigger");
        }
    }
}
