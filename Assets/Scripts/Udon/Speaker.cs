using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class Speaker : UdonSharpBehaviour
{
    public AudioClip audioClip;

    private void Start()
    {
        //Invoke("Test", 2);
        
    }

    

    void Test()
    {
        Manager manager = GameObject.Find("Manager").GetComponent<Manager>();
        SoundManager soundManager = manager.GetSoundManager();
        if (soundManager != null)
        {
            soundManager.CreateAudio(audioClip.name, true, transform.position, true);
        }
    }

    public override void OnPlayerTriggerEnter(VRCPlayerApi player)
    {        
        if (player.IsValid())
        {
            if (player.isLocal)
            {
                Manager manager = GameObject.Find("Manager").GetComponent<Manager>();
                SoundManager soundManager = manager.GetSoundManager();
                if(soundManager != null)
                {
                    soundManager.AudioMute(audioClip.name, true);
                }
            }
        }
    }

    public override void OnPlayerTriggerExit(VRCPlayerApi player)
    {
        if (player.IsValid())
        {
            if (player.isLocal)
            {
                Manager manager = GameObject.Find("Manager").GetComponent<Manager>();
                SoundManager soundManager = manager.GetSoundManager();
                if (soundManager != null)
                {
                    soundManager.AudioMute(audioClip.name, false);
                }
            }
        }
    }

    public void OnTriggerEnter(Collider other)
    {       

        UdonTestPlayer player = other.GetComponent<UdonTestPlayer>();
        if(player != null)
        {
            Manager manager = GameObject.Find("Manager").GetComponent<Manager>();
            SoundManager soundManager = manager.GetSoundManager();
            if (soundManager != null)
            {
                soundManager.AudioMute(audioClip.name, true);
            }
        }
        
    }

    public void OnTriggerExit(Collider other)
    {

        UdonTestPlayer player = other.GetComponent<UdonTestPlayer>();
        if (player != null)
        {
            Manager manager = GameObject.Find("Manager").GetComponent<Manager>();
            SoundManager soundManager = manager.GetSoundManager();
            if (soundManager != null)
            {
                soundManager.AudioMute(audioClip.name, false);
            }
        }

    }
}
