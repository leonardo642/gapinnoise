
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class FerrisWheel : UdonSharpBehaviour
{
    public Transform[] nodes;
    [HideInInspector]public FerrisChair[] chairs;
    [HideInInspector]public GameObject chairPrefab;
    public string prefabName;
    public float speed;

    private void Start()
    {
        Init();
    }

    void Init()
    {
        chairPrefab = GameObject.Find(prefabName);

        FerrisChair[] initChairs = new FerrisChair[nodes.Length];
        for (int i = 0; i < nodes.Length; i++)
        {
            var obj = VRCInstantiate(chairPrefab);
            obj.transform.position = nodes[i].position;
            FerrisChair _chair = obj.GetComponent<FerrisChair>();
            if (_chair != null)
            {
                _chair.curNode = i;
            }
            
            initChairs[i] = _chair;
        }

        chairs = initChairs;
    }
    private void FixedUpdate()
    {
        //노드
        for (int i = 0; i < nodes.Length; i++)
        {
            FerrisChair chooseChair = chairs[i];

            int next = chooseChair.curNode >= nodes.Length -1  ? 0 : chooseChair.curNode + 1;            

            Vector3 distance = nodes[next].position - chooseChair.transform.position;

            chooseChair.transform.position += distance.normalized * speed * Time.fixedDeltaTime;
            if (distance.sqrMagnitude < 0.1f)
            {
                chooseChair.curNode = next;
            }
        }
    }
}
