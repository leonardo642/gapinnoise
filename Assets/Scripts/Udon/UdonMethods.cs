
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;
using System.Collections.Generic;

public class UdonMethods : UdonSharpBehaviour
{
    [HideInInspector]public Manager manager;

    //오디오 소스 늘려줌.
    public AudioSource[] AudioStretch(AudioSource[] audioSources, AudioSource audioSource)
    {
        AudioSource[] newArray = new AudioSource[audioSources.Length + 1];

        for (int i = 0; i < audioSources.Length; i++)
        {
            newArray[i] = audioSources[i];
        }

        newArray[audioSources.Length] = audioSource;

        return newArray;

    }
}
