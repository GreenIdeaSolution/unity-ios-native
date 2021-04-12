using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PluginTest : MonoBehaviour
{

#if UNITY_IOS
    [DllImport("__Internal")]
    private static extern double IOS_getElapsedTime();
#endif

    int frameCount = 0;
    // Start is called before the first frame update
    void Start()
    {
        Debug.Log("Elapsed time: " + getElapsedTime());
    }

    // Update is called once per frame
    void Update()
    {
        frameCount++;
        if (frameCount >= 5) {
            Debug.Log("Tick: " + getElapsedTime());
            frameCount = 0;
        }
    }

    double getElapsedTime() {
        if (Application.platform == RuntimePlatform.IPhonePlayer)
        {
            return IOS_getElapsedTime();
        }
        Debug.LogWarning("Wrong platfrom");
        return 0;
    }
}
