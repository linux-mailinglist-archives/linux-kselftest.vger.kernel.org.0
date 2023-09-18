Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7827A4913
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Sep 2023 14:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240208AbjIRMAg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Sep 2023 08:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241890AbjIRMAW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Sep 2023 08:00:22 -0400
X-Greylist: delayed 410 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 18 Sep 2023 04:59:27 PDT
Received: from faui40.informatik.uni-erlangen.de (faui40.informatik.uni-erlangen.de [IPv6:2001:638:a000:4134::ffff:40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22851B3;
        Mon, 18 Sep 2023 04:59:27 -0700 (PDT)
Received: from [10.20.28.254] (faustaff-010-020-028-254.pool.uni-erlangen.de [10.20.28.254])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: gerhorst)
        by faui40.informatik.uni-erlangen.de (Postfix) with ESMTPSA id 4Rq37f4jyCznkVt;
        Mon, 18 Sep 2023 13:52:30 +0200 (CEST)
Message-ID: <e15dea4b-f6a5-a37d-1660-406bca5a0026@cs.fau.de>
Date:   Mon, 18 Sep 2023 13:52:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From:   Luis Gerhorst <gerhorst@cs.fau.de>
Subject: Re: [PATCH 2/3] Revert "bpf: Fix issue in verifying allow_ptr_leaks"
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, haoluo@google.com,
        john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
        martin.lau@linux.dev, sdf@google.com, song@kernel.org,
        yonghong.song@linux.dev, mykolal@fb.com, shuah@kernel.org,
        gerhorst@amazon.de, iii@linux.ibm.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hagar Gamal Halim Hemdan <hagarhem@amazon.de>,
        Puranjay Mohan <puranjay12@gmail.com>
References: <CAADnVQLid7QvukhnqRoY2VVFi1tCfkPFsMGUUeHDtCgf0SAJCg@mail.gmail.com>
 <20230913122827.91591-1-gerhorst@amazon.de>
 <CALOAHbAswO78gQ+D6yOupi5Hx_i3xqHQFrjGdWR=EhdVvV3ZkA@mail.gmail.com>
Content-Language: de-DE, en-US
In-Reply-To: <CALOAHbAswO78gQ+D6yOupi5Hx_i3xqHQFrjGdWR=EhdVvV3ZkA@mail.gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-512; boundary="------------ms000302010001060009000403"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms000302010001060009000403
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15/09/2023 04:26, Yafang Shao wrote:
> On Wed, Sep 13, 2023 at 8:30 PM Luis Gerhorst <gerhorst@amazon.de> wrote:
>>
>> This reverts commit d75e30dddf73449bc2d10bb8e2f1a2c446bc67a2.
>>
>> To mitigate Spectre v1, the verifier relies on static analysis to deduct
>> constant pointer bounds, which can then be enforced by rewriting pointer
>> arithmetic [1] or index masking [2]. This relies on the fact that every
>> memory region to be accessed has a static upper bound and every date
>> below that bound is accessible. The verifier can only rewrite pointer
>> arithmetic or insert masking instructions to mitigate Spectre v1 if a
>> static upper bound, below of which every access is valid, can be given.
>>
>> When allowing packet pointer comparisons, this introduces a way for the
>> program to effectively construct an accessible pointer for which no
>> static upper bound is known. Intuitively, this is obvious as a packet
>> might be of any size and therefore 0 is the only statically known upper
>> bound below of which every date is always accessible (i.e., none).
>>
>> To clarify, the problem is not that comparing two pointers can be used
>> for pointer leaks in the same way in that comparing a pointer to a known
>> scalar can be used for pointer leaks. That is because the "secret"
>> components of the addresses cancel each other out if the pointers are
>> into the same region.
>>
>> With [3] applied, the following malicious BPF program can be loaded into
>> the kernel without CAP_PERFMON:
>>
>> r2 = *(u32 *)(r1 + 76) // data
>> r3 = *(u32 *)(r1 + 80) // data_end
>> r4 = r2
>> r4 += 1
>> if r4 > r3 goto exit
>> r5 = *(u8 *)(r2 + 0) // speculatively read secret
>> r5 &= 1 // choose bit to leak
>> // ... side channel to leak secret bit
>> exit:
>> // ...
>>
>> This is jited to the following amd64 code which still contains the
>> gadget:
>>
>>     0:   endbr64
>>     4:   nopl   0x0(%rax,%rax,1)
>>     9:   xchg   %ax,%ax
>>     b:   push   %rbp
>>     c:   mov    %rsp,%rbp
>>     f:   endbr64
>>    13:   push   %rbx
>>    14:   mov    0xc8(%rdi),%rsi // data
>>    1b:   mov    0x50(%rdi),%rdx // data_end
>>    1f:   mov    %rsi,%rcx
>>    22:   add    $0x1,%rcx
>>    26:   cmp    %rdx,%rcx
>>    29:   ja     0x000000000000003f // branch to mispredict
>>    2b:   movzbq 0x0(%rsi),%r8 // speculative load of secret
>>    30:   and    $0x1,%r8 // choose bit to leak
>>    34:   xor    %ebx,%ebx
>>    36:   cmp    %rbx,%r8
>>    39:   je     0x000000000000003f // branch based on secret
>>    3b:   imul   $0x61,%r8,%r8 // leak using port contention side channel
>>    3f:   xor    %eax,%eax
>>    41:   pop    %rbx
>>    42:   leaveq
>>    43:   retq
>>
>> Here I'm using a port contention side channel because storing the secret
>> to the stack causes the verifier to insert an lfence for unrelated
>> reasons (SSB mitigation) which would terminate the speculation.
>>
>> As Daniel already pointed out to me, data_end is even attacker
>> controlled as one could send many packets of sufficient length to train
>> the branch prediction into assuming data_end >= data will never be true.
>> When the attacker then sends a packet with insufficient data, the
>> Spectre v1 gadget leaks the chosen bit of some value that lies behind
>> data_end.
>>
>> To make it clear that the problem is not the pointer comparison but the
>> missing masking instruction, it can be useful to transform the code
>> above into the following equivalent pseudocode:
>>
>> r2 = data
>> r3 = data_end
>> r6 = ... // index to access, constant does not help
>> r7 = data_end - data // only known at runtime, could be [0,PKT_MAX)
>> if !(r6 < r7) goto exit
>> // no masking of index in r6 happens
>> r2 += r6 // addr. to access
>> r5 = *(u8 *)(r2 + 0) // speculatively read secret
>> // ... leak secret as above
>>
>> One idea to resolve this while still allowing for unprivileged packet
>> access would be to always allocate a power of 2 for the packet data and
>> then also pass the respective index mask in the skb structure. The
>> verifier would then have to check that this index mask is always applied
>> to the offset before a packet pointer is dereferenced. This patch does
>> not implement this extension, but only reverts [3].
> 
> Hi Luis,
> 
> The skb pointer comparison is a reasonable operation in a networking bpf prog.
> If we just prohibit a reasonable operation to prevent a possible
> spectre v1 attack, it looks a little weird, right ?
> Should we figure out a real fix to prevent it ?
> 

I see your point, but this has been the case since Spectre v1 was 
mitigated for BPF. I actually did a few statistics on that in [1] and 
 >50 out of ~350 programs are rejected because of the Spectre v1 
mitigations. However, to repeat: The operation is not completely 
prohibited, only prohibited without CAP_PERFMON.

Maybe it would be possible to expose the allow_ptr_leaks/bpf_spec_vX 
flags in sysfs? It would be helpful for debugging, and you could set it 
to 1 permanently for your purposes. However, I'm not sure if the others 
would like that...

Another solution I have been working on in [2] is to change the 
mitigations to insert an lfence instead of rejecting the program 
entirely. That would have bad performance, but would still be better 
than completely rejecting the program. However, these patches are far 
from going upstream currently.

A detail: The patches in [2] currently do not support the case we are 
discussing here, they only insert fences when the speculative paths fail 
to verify.

[1] 
https://sys.cs.fau.de/extern/person/gerhorst/23-03_fgbs-spring-2023-presentation.pdf 
- Slide 9
[2] 
https://gitlab.cs.fau.de/un65esoq/linux/-/commits/v6.5-rc6-bpf-spectre-nospec/

-- 
Luis

--------------ms000302010001060009000403
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgMFADCABgkqhkiG9w0BBwEAAKCC
EeswggUSMIID+qADAgECAgkA4wvV+K8l2YEwDQYJKoZIhvcNAQELBQAwgYIxCzAJBgNVBAYT
AkRFMSswKQYDVQQKDCJULVN5c3RlbXMgRW50ZXJwcmlzZSBTZXJ2aWNlcyBHbWJIMR8wHQYD
VQQLDBZULVN5c3RlbXMgVHJ1c3QgQ2VudGVyMSUwIwYDVQQDDBxULVRlbGVTZWMgR2xvYmFs
Um9vdCBDbGFzcyAyMB4XDTE2MDIyMjEzMzgyMloXDTMxMDIyMjIzNTk1OVowgZUxCzAJBgNV
BAYTAkRFMUUwQwYDVQQKEzxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMgRGV1dHNjaGVu
IEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsTB0RGTi1QS0kxLTArBgNVBAMTJERG
Ti1WZXJlaW4gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgMjCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBAMtg1/9moUHN0vqHl4pzq5lN6mc5WqFggEcVToyVsuXPztNXS43O+FZs
FVV2B+pG/cgDRWM+cNSrVICxI5y+NyipCf8FXRgPxJiZN7Mg9mZ4F4fCnQ7MSjLnFp2uDo0p
eQcAIFTcFV9Kltd4tjTTwXS1nem/wHdN6r1ZB+BaL2w8pQDcNb1lDY9/Mm3yWmpLYgHurDg0
WUU2SQXaeMpqbVvAgWsRzNI8qIv4cRrKO+KA3Ra0Z3qLNupOkSk9s1FcragMvp0049ENF4N1
xDkesJQLEvHVaY4l9Lg9K7/AjsMeO6W/VRCrKq4Xl14zzsjz9AkH4wKGMUZrAcUQDBHHWekC
AwEAAaOCAXQwggFwMA4GA1UdDwEB/wQEAwIBBjAdBgNVHQ4EFgQUk+PYMiba1fFKpZFK4OpL
4qIMz+EwHwYDVR0jBBgwFoAUv1kgNgB5oKAia4zV8mHSuCzLgkowEgYDVR0TAQH/BAgwBgEB
/wIBAjAzBgNVHSAELDAqMA8GDSsGAQQBga0hgiwBAQQwDQYLKwYBBAGBrSGCLB4wCAYGZ4EM
AQICMEwGA1UdHwRFMEMwQaA/oD2GO2h0dHA6Ly9wa2kwMzM2LnRlbGVzZWMuZGUvcmwvVGVs
ZVNlY19HbG9iYWxSb290X0NsYXNzXzIuY3JsMIGGBggrBgEFBQcBAQR6MHgwLAYIKwYBBQUH
MAGGIGh0dHA6Ly9vY3NwMDMzNi50ZWxlc2VjLmRlL29jc3ByMEgGCCsGAQUFBzAChjxodHRw
Oi8vcGtpMDMzNi50ZWxlc2VjLmRlL2NydC9UZWxlU2VjX0dsb2JhbFJvb3RfQ2xhc3NfMi5j
ZXIwDQYJKoZIhvcNAQELBQADggEBAIcL/z4Cm2XIVi3WO5qYi3FP2ropqiH5Ri71sqQPrhE4
eTizDnS6dl2e6BiClmLbTDPo3flq3zK9LExHYFV/53RrtCyD2HlrtrdNUAtmB7Xts5et6u5/
MOaZ/SLick0+hFvu+c+Z6n/XUjkurJgARH5pO7917tALOxrN5fcPImxHhPalR6D90Bo0fa3S
PXez7vTXTf/D6OWST1k+kEcQSrCFWMBvf/iu7QhCnh7U3xQuTY+8npTD5+32GPg8SecmqKc2
2CzeIs2LgtjZeOJVEqM7h0S2EQvVDFKvaYwPBt/QolOLV5h7z/0HJPT8vcP9SpIClxvyt7bP
ZYoaorVyGTkwggWsMIIElKADAgECAgcbY7rQHiw9MA0GCSqGSIb3DQEBCwUAMIGVMQswCQYD
VQQGEwJERTFFMEMGA1UEChM8VmVyZWluIHp1ciBGb2VyZGVydW5nIGVpbmVzIERldXRzY2hl
biBGb3JzY2h1bmdzbmV0emVzIGUuIFYuMRAwDgYDVQQLEwdERk4tUEtJMS0wKwYDVQQDEyRE
Rk4tVmVyZWluIENlcnRpZmljYXRpb24gQXV0aG9yaXR5IDIwHhcNMTYwNTI0MTEzODQwWhcN
MzEwMjIyMjM1OTU5WjCBjTELMAkGA1UEBhMCREUxRTBDBgNVBAoMPFZlcmVpbiB6dXIgRm9l
cmRlcnVuZyBlaW5lcyBEZXV0c2NoZW4gRm9yc2NodW5nc25ldHplcyBlLiBWLjEQMA4GA1UE
CwwHREZOLVBLSTElMCMGA1UEAwwcREZOLVZlcmVpbiBHbG9iYWwgSXNzdWluZyBDQTCCASIw
DQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAJ07eRxH3h+Gy8Zp1xCeOdfZojDbchwFfylf
S2jxrRnWTOFrG7ELf6Gr4HuLi9gtzm6IOhDuV+UefwRRNuu6cG1joL6WLkDh0YNMZj0cZGnl
m6Stcq5oOVGHecwX064vXWNxSzl660Knl5BpBb+Q/6RAcL0D57+eGIgfn5mITQ5HjUhfZZkQ
0tkqSe3BuS0dnxLLFdM/fx5ULzquk1enfnjK1UriGuXtQX1TX8izKvWKMKztFwUkP7agCwf9
TRqaA1KgNpzeJIdl5Of6x5ZzJBTN0OgbaJ4YWa52fvfRCng8h0uwN89Tyjo4EPPLR22MZD08
WkVKusqAfLjz56dMTM0CAwEAAaOCAgUwggIBMBIGA1UdEwEB/wQIMAYBAf8CAQEwDgYDVR0P
AQH/BAQDAgEGMCkGA1UdIAQiMCAwDQYLKwYBBAGBrSGCLB4wDwYNKwYBBAGBrSGCLAEBBDAd
BgNVHQ4EFgQUazqYi/nyU4na4K2yMh4JH+iqO3QwHwYDVR0jBBgwFoAUk+PYMiba1fFKpZFK
4OpL4qIMz+EwgY8GA1UdHwSBhzCBhDBAoD6gPIY6aHR0cDovL2NkcDEucGNhLmRmbi5kZS9n
bG9iYWwtcm9vdC1nMi1jYS9wdWIvY3JsL2NhY3JsLmNybDBAoD6gPIY6aHR0cDovL2NkcDIu
cGNhLmRmbi5kZS9nbG9iYWwtcm9vdC1nMi1jYS9wdWIvY3JsL2NhY3JsLmNybDCB3QYIKwYB
BQUHAQEEgdAwgc0wMwYIKwYBBQUHMAGGJ2h0dHA6Ly9vY3NwLnBjYS5kZm4uZGUvT0NTUC1T
ZXJ2ZXIvT0NTUDBKBggrBgEFBQcwAoY+aHR0cDovL2NkcDEucGNhLmRmbi5kZS9nbG9iYWwt
cm9vdC1nMi1jYS9wdWIvY2FjZXJ0L2NhY2VydC5jcnQwSgYIKwYBBQUHMAKGPmh0dHA6Ly9j
ZHAyLnBjYS5kZm4uZGUvZ2xvYmFsLXJvb3QtZzItY2EvcHViL2NhY2VydC9jYWNlcnQuY3J0
MA0GCSqGSIb3DQEBCwUAA4IBAQCBeEWkTqR/DlXwCbFqPnjMaDWpHPOVnj/z+N9rOHeJLI21
rT7H8pTNoAauusyosa0zCLYkhmI2THhuUPDVbmCNT1IxQ5dGdfBi5G5mUcFCMWdQ5UnnOR7L
n8qGSN4IFP8VSytmm6A4nwDO/afr0X9XLchMX9wQEZc+lgQCXISoKTlslPwQkgZ7nu7YRrQb
tQMMONncsKk/cQYLsgMHM8KNSGMlJTx6e1du94oFOO+4oK4v9NsH1VuEGMGpuEvObJAaguS5
Pfp38dIfMwK/U+d2+dwmJUFvL6Yb+qQTkPp8ftkLYF3sv8pBoGH7EUkp2KgtdRXYShjqFu9V
NCIaE40GMIIHITCCBgmgAwIBAgIMJfzeCQJGjR2GicgiMA0GCSqGSIb3DQEBCwUAMIGNMQsw
CQYDVQQGEwJERTFFMEMGA1UECgw8VmVyZWluIHp1ciBGb2VyZGVydW5nIGVpbmVzIERldXRz
Y2hlbiBGb3JzY2h1bmdzbmV0emVzIGUuIFYuMRAwDgYDVQQLDAdERk4tUEtJMSUwIwYDVQQD
DBxERk4tVmVyZWluIEdsb2JhbCBJc3N1aW5nIENBMB4XDTIyMDExMTEwNDgyN1oXDTI1MDEx
MDEwNDgyN1owgakxCzAJBgNVBAYTAkRFMQ8wDQYDVQQIDAZCYXllcm4xETAPBgNVBAcMCEVy
bGFuZ2VuMTwwOgYDVQQKDDNGcmllZHJpY2gtQWxleGFuZGVyLVVuaXZlcnNpdGFldCBFcmxh
bmdlbi1OdWVybmJlcmcxETAPBgNVBAQMCEdlcmhvcnN0MQ0wCwYDVQQqDARMdWlzMRYwFAYD
VQQDDA1MdWlzIEdlcmhvcnN0MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAyaD9
1GYQ1cfsamslbh08nQ3JIeQo6BDEyRCMmxeUK8be1LXhDn/smIAcDoGR6gbBvMcG2w8v8y+p
lA1N8FLsWUygfkUPHzt18W28Z9cVURI17Y5EffXrKxWO3rHBEVhL/KVREibnMwCtI+9lG9nW
ktUhHscygUP/GFjH9OFZrNBhChwOcMmBUkdbGsN9JNFR/IC91UG4l0uUe4HTLBjn3SBvA2Ku
4CcfE9+0PpwMc3U/ysUv58AKNP5xOdXd41mNH6C4lpbLU9RfIqtWcMBNrSRiuQXf+kAMsJZ3
QdvRAeOmYGnfnotQv50dldQlDLzL5yM+hnF2dMc3sHYfN+jffzvvPRPFfMRAAabWTAMpDr+e
Wg0xVuuhc3/qfp3HfD4ImC14D8PIq/HfTDwpfnngn86Tfw1+NlKcsFO2E2zo8ehR7fIZ4m5J
EjJN0TAmrXdfkSfnTi+u7S3mTnm/8hSG1n0tGz8ChlNK4bQvjfbHDgDSNVYLiJ7mwvd2ezMU
3O6GWO2Rkh2ajWz0wKsZj/c+qEah3vVK//hyAU5ZrUMBen0CC2VxDvrTqK5T9U3o2dlnRntH
2mlBnAKZRPjXbqiZPaUafxGl3Ei4kucYqM7uGlRnuuoPHRdbHYl43LpVm3PrAznEio/T8RVQ
oVsW0+bXBwNI0M6crOThU9VRC6vnABUCAwEAAaOCAmEwggJdMD4GA1UdIAQ3MDUwDwYNKwYB
BAGBrSGCLAEBBDAQBg4rBgEEAYGtIYIsAQEECjAQBg4rBgEEAYGtIYIsAgEECjAJBgNVHRME
AjAAMA4GA1UdDwEB/wQEAwIF4DAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwHQYD
VR0OBBYEFHKMa3m3JJ+2DN8JQfcfTTPnmog0MB8GA1UdIwQYMBaAFGs6mIv58lOJ2uCtsjIe
CR/oqjt0MDMGA1UdEQQsMCqBEmdlcmhvcnN0QGNzLmZhdS5kZYEUbHVpcy5nZXJob3JzdEBm
YXUuZGUwgY0GA1UdHwSBhTCBgjA/oD2gO4Y5aHR0cDovL2NkcDEucGNhLmRmbi5kZS9kZm4t
Y2EtZ2xvYmFsLWcyL3B1Yi9jcmwvY2FjcmwuY3JsMD+gPaA7hjlodHRwOi8vY2RwMi5wY2Eu
ZGZuLmRlL2Rmbi1jYS1nbG9iYWwtZzIvcHViL2NybC9jYWNybC5jcmwwgdsGCCsGAQUFBwEB
BIHOMIHLMDMGCCsGAQUFBzABhidodHRwOi8vb2NzcC5wY2EuZGZuLmRlL09DU1AtU2VydmVy
L09DU1AwSQYIKwYBBQUHMAKGPWh0dHA6Ly9jZHAxLnBjYS5kZm4uZGUvZGZuLWNhLWdsb2Jh
bC1nMi9wdWIvY2FjZXJ0L2NhY2VydC5jcnQwSQYIKwYBBQUHMAKGPWh0dHA6Ly9jZHAyLnBj
YS5kZm4uZGUvZGZuLWNhLWdsb2JhbC1nMi9wdWIvY2FjZXJ0L2NhY2VydC5jcnQwDQYJKoZI
hvcNAQELBQADggEBAJtkku/mMKt7UG2ghvD//mIuCVhB36VqetpOm0o8RaEIi/KA5jf8q2F+
JihuV11chvT6Sie8UtGGu/V1l18LexvFmQIDMT31z1bbo7SzfHCRq+NZaCbUwECYKcewWa9u
UUw+FQuZ4QzooMMMNvtNxCW5M1esjYbLonOoydT+FTva5RWJNAo4t4LgRJLX0WYUaM58viqb
2Z6bweG+AnjpB2TwTwJ8NdlwpNN/q2aWQWYVUedK2X3vLetyIlyDY2z1lsWHvtGyU/PriEz/
UDv7CMQphqhYobsg05DNs31hmW75XxfXXyXvOaLrjhUeSY6el04/a5Q6/fL7LXkcCivnMZMx
ggUrMIIFJwIBATCBnjCBjTELMAkGA1UEBhMCREUxRTBDBgNVBAoMPFZlcmVpbiB6dXIgRm9l
cmRlcnVuZyBlaW5lcyBEZXV0c2NoZW4gRm9yc2NodW5nc25ldHplcyBlLiBWLjEQMA4GA1UE
CwwHREZOLVBLSTElMCMGA1UEAwwcREZOLVZlcmVpbiBHbG9iYWwgSXNzdWluZyBDQQIMJfze
CQJGjR2GicgiMA0GCWCGSAFlAwQCAwUAoIICXTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA5MTgxMTUyMjlaME8GCSqGSIb3DQEJBDFCBEBfUy3VRBd0
0uKnDBENOrncrw0SJH5Ko0OtWNnMEwf29WXJ/U0+92HUnXp7otEY9myGlx5uuKmVVWLj3YkU
JIh9MGwGCSqGSIb3DQEJDzFfMF0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBAjAKBggqhkiG
9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZIhvcN
AwICASgwga8GCSsGAQQBgjcQBDGBoTCBnjCBjTELMAkGA1UEBhMCREUxRTBDBgNVBAoMPFZl
cmVpbiB6dXIgRm9lcmRlcnVuZyBlaW5lcyBEZXV0c2NoZW4gRm9yc2NodW5nc25ldHplcyBl
LiBWLjEQMA4GA1UECwwHREZOLVBLSTElMCMGA1UEAwwcREZOLVZlcmVpbiBHbG9iYWwgSXNz
dWluZyBDQQIMJfzeCQJGjR2GicgiMIGxBgsqhkiG9w0BCRACCzGBoaCBnjCBjTELMAkGA1UE
BhMCREUxRTBDBgNVBAoMPFZlcmVpbiB6dXIgRm9lcmRlcnVuZyBlaW5lcyBEZXV0c2NoZW4g
Rm9yc2NodW5nc25ldHplcyBlLiBWLjEQMA4GA1UECwwHREZOLVBLSTElMCMGA1UEAwwcREZO
LVZlcmVpbiBHbG9iYWwgSXNzdWluZyBDQQIMJfzeCQJGjR2GicgiMA0GCSqGSIb3DQEBAQUA
BIICAIGcVwICZHHdzBY4UtKm5/BUEvizGcJiUeMWWpnLuulbkUkzGmYR9SrC9fZdlzml96mj
42zKjcnB/sBJItbQCAq9/7+aRaYsJ48RGczjJyuP50/xMOhbr2EoA/UA7joH1QGGUlyQgu2D
7YgSUXnzmWUW25CBNpy5/mTHiLhW4rOZcSOIf+sbxPhCUgHfgBJhYUFYTbI7y1IfmJl3+EAb
QOb/esvsyIbZSyLuDOplt1U7JW+F35t0RhsDyuUMKYwc++JSbRq6U8rnDNNiSeCfw4Bu1ZCd
1d735BdDA+hf/9+8V9z/7v6XTPRG8plKq9iLyowesZiO2OK7kZY+xOn4u3qv4OxnPC6v+AOF
zEn3YR6moTx902MB+Ih7w8yElE1S4hKCOa02EAcepSBmGnrjPVMrZNAJQa0ZgAY9xf/aZwf/
FijEB+W70aWLLFG2qfrtgVIHK9g8YOodZr3C8TWftyv4ihMEPobZl0liQHmHsuK8XanFZM1M
Mn3/nKKeOi8Tg4cBeOBfaXKH2xtGi00dVz4oKNf8Sez0YhcPvlz0r/hDCo+WYXo8xsWdZ8XI
EMqNpIRiFAe1lcNJHR/Tqu66/5PifrY+BRiBXwDppLo1bfgetji2aNjXt5zPsRO/ns9ICJa+
HoasErh/lUdnICuOSvLrohV6Z6UhP/WJammCABgKAAAAAAAA
--------------ms000302010001060009000403--
