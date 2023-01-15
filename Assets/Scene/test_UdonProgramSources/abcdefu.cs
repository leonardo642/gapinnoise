
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class abcdefu : UdonSharpBehaviour
{
    //회전, 이동 할 속도
    public float Rspeed = 100.0f;
    public float Pspeed = 1.0f;
    //이동할 좌표
    public Vector3 targetPosition = new Vector3(0, 0, 0);
    //유니티 Transform 컴포넌트 정보
    private Transform tf;
    void Start()
    {
        tf = gameObject.transform;
    }
    void FixedUpdate()
    {
        // 회전축 x:0, y:1, z:1 만큼 지속적으로 돌아감 
        tf.Rotate(new Vector3(0, 1, 1), Time.deltaTime * Rspeed);

        // 좌표
        //tf.position = Vector3.MoveTowards(tf.position, targetPosition, Time.deltaTime * Pspeed);
    }

    public void GoTo(Vector3 position)
    {
        transform.position = position;
    }
}
