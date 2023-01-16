
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class ResManager : UdonSharpBehaviour
{
    [HideInInspector] public Manager manager;

    //음악 실행하게 할 프리팹
    public GameObject soundPrefab;

    //오디오 클립들
    [Header("EffectSoundClips")]
    public AudioClip[] effectSoundClips;

    [Header("BGMClips")]
    public AudioClip[] bgmSoundClips;
    
    AudioClip[] allSoundClips;

    //오디오 소스 관련
    public AudioSource[] audioSources;

    private UdonMethods udonMethods;



    

    public void Init()
    {
        SetAllSoundClips();
        udonMethods = manager.GetUdonMethod();
    }

    void SetAllSoundClips()
    {
        allSoundClips = new AudioClip[effectSoundClips.Length + bgmSoundClips.Length];

        for (int i = 0; i < effectSoundClips.Length; i++)
        {
            allSoundClips[i] = effectSoundClips[i];
        }

        for (int i = effectSoundClips.Length; i < effectSoundClips.Length + bgmSoundClips.Length; i++)
        {
            allSoundClips[i] = bgmSoundClips[i];
        }
    }

    public AudioSource CreateAudio(string audioName, bool isBgm, Vector3 position)
    {
        AudioSource audio = AudioCreate(isBgm, position);        

        for (int i = 0; i < allSoundClips.Length; i++)
        {
            if (allSoundClips[i].name == audioName)
            {
                audio.clip = allSoundClips[i];
                break;
            }
        }

        return audio;
    }

    AudioSource AudioCreate(bool isBgm, Vector3 position)
    {
        GameObject obj = VRCInstantiate(soundPrefab);
        obj.transform.position = position;
        AudioSource audio = obj.GetComponent<AudioSource>();
        audioSources = udonMethods.AudioStretch(audioSources, audio);

        audio.loop = isBgm;

        return audio;
    }

    public AudioSource GetAudioSource(string audioName)
    {
        AudioSource audio = null;
        for (int i = 0; i < allSoundClips.Length; i++)
        {
            if (audioSources[i].clip.name == audioName)
            {
                audio = audioSources[i];
                break;
            }
        }

        return audio;
    }

    
}
