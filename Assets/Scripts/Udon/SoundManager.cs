
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class SoundManager : UdonSharpBehaviour
{
    [HideInInspector]public Manager manager;
    void Start()
    {
        
    }

    public void CreateAudio(string name, bool isBgm, Vector3 position,  bool isListen = true)
    {
        ResManager res = manager.GetResManager();
        AudioSource audio = res.CreateAudio(name, isBgm, position);
        AudioPlay(audio);
        AudioMute(name, isListen);
    }

    public void AudioPlay(AudioSource audioSource)
    {
        audioSource.Play();
    }

    public void AudioMute(string name, bool isListen)
    {
        ResManager res = manager.GetResManager();
        AudioSource audio = res.GetAudioSource(name);
        audio.mute = !isListen;
    }

    
}

