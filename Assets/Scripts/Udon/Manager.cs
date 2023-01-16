
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class Manager : UdonSharpBehaviour
{
    public ResManager resManager;
    public PoolManager poolManager;
    public SoundManager soundManager;
    public UdonMethods methods;


    void Start()
    {
        Init();
    }

    void Init()
    {
        resManager.manager = this;
        poolManager.manager = this;
        soundManager.manager = this;
        methods.manager = this;

        resManager.Init();
    }

    public ResManager GetResManager()
    {
        return resManager;
    }

    public PoolManager GetPoolManager()
    {
        return poolManager;
    }

    public SoundManager GetSoundManager()
    {
        return soundManager;
    }

    public UdonMethods GetUdonMethod()
    {
        return methods;
    }
}
