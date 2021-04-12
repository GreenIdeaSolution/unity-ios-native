using System.Collections;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using UnityEngine;

public class PluginTest : MonoBehaviour
{

#if UNITY_IOS
    [DllImport("__Internal")]
    private static extern float IOS_getMemoryUsage();
#endif

    float memoryUsage = 0;
    int frameCount = 0;

    // Start is called before the first frame update
    void Start()
    {
        // Debug.Log("Mem usage: " + getMemoryUsage());
    }

    // Update is called once per frame
    void Update()
    {
        frameCount++;
        memoryUsage = getMemoryUsage();
        if (frameCount >= 10) {
            Debug.Log("Mem usage: " + getMemoryUsage());
            frameCount = 0;
        }
    }

    float getMemoryUsage()
    {
        if (Application.platform == RuntimePlatform.IPhonePlayer)
        {
            return IOS_getMemoryUsage();
        }

        // else:
        Debug.LogWarning("Wrong platfrom");
        return 0;
    }
}
