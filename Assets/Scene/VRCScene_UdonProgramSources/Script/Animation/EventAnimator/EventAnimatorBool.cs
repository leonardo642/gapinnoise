
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class EventAnimatorBool : UdonSharpBehaviour
{
    public SyncEventAnimator syncEventAnimator;
    public EventAnimator eventAnimator;
    [HideInInspector] public Animator[] animators;
    [HideInInspector] public Animator checkAnimator;

    
}
