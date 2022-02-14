Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232704B43E0
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Feb 2022 09:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236132AbiBNITF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Feb 2022 03:19:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbiBNITC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Feb 2022 03:19:02 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42EA25C40;
        Mon, 14 Feb 2022 00:18:54 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id BBEB11F43333
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644826733;
        bh=DGeNZvAkAxc84jyqOMSeG0plMeoRslPbkBa/UawJm90=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=LEJloTnuoTb17lj2/3q1rVL+T9coa2HajJg0FPD5cgCEypg5bBOQtpy1fGbB5q3lz
         Kgnl3cw0Wpd9rALgRVsLCECWyAMs/4jda2QzUH2RcW/e5O2T1oM2fxlmxf4sIFbPLs
         6NOgs6btI2asoBA4PQ4T4Av4GysrFK1VAXm5XmZfzXqgJdkTvEXkj7R42vi30sVNyt
         wgouBW5vRkTgYurBvcuH2b8rkc4JfdEDQFBcUBzbo3sJKhUTB1ndxuABjxgV7seSXY
         W0MQ6JQfgFi+JzckRLG694Hzvu1X54+3zblzEBguM0gmFphtL6T9j7S55fiHhJRSoR
         pMiiUJ/ty/0iQ==
Message-ID: <5af77f27-447c-794c-c96f-212dda3e4ab9@collabora.com>
Date:   Mon, 14 Feb 2022 13:18:43 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Cc:     usama.anjum@collabora.com,
        "kernel@collabora.com" <kernel@collabora.com>,
        "kernelci@groups.io" <kernelci@groups.io>,
        "kernelci.org bot" <bot@kernelci.org>
Subject: Re: [PATCH 1/2] selftests: x86: allow expansion of $(CC)
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Jethro Beekman <jethro@fortanix.com>,
        "open list:INTEL SGX" <linux-sgx@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220210190642.1477814-1-usama.anjum@collabora.com>
 <20220210190642.1477814-2-usama.anjum@collabora.com>
 <a34f2fc8-f4aa-fef4-d1dd-f3fdb5114f72@linuxfoundation.org>
 <99625ceecead4e9eb73de2fc8acb2ae9@AcuMS.aculab.com>
 <7a501981-e4ce-fb08-7c1e-6aca26245cef@linuxfoundation.org>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <7a501981-e4ce-fb08-7c1e-6aca26245cef@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SCC_BODY_URI_ONLY,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/11/22 10:13 PM, Shuah Khan wrote:
> On 2/11/22 9:47 AM, David Laight wrote:
>> From: Shuah Khan
>>> Sent: 10 February 2022 20:52
>>>
>>> On 2/10/22 12:06 PM, Muhammad Usama Anjum wrote:
>>>> CC can have multiple sub-strings like "ccache gcc". Erorr pops up if
>>>> it is treated as single string and double quote are used around it.
>>>> This can be fixed by removing the quotes and not treating CC a single
>>>> string.
>>>>
>>>> Fixes: e9886ace222e ("selftests, x86: Rework x86 target architecture
>>>> detection")
>>>> Reported-by: "kernelci.org bot" <bot@kernelci.org>
>>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>>> ---
>>>>    tools/testing/selftests/x86/check_cc.sh | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/tools/testing/selftests/x86/check_cc.sh
>>>> b/tools/testing/selftests/x86/check_cc.sh
>>>> index 3e2089c8cf549..aff2c15018b53 100755
>>>> --- a/tools/testing/selftests/x86/check_cc.sh
>>>> +++ b/tools/testing/selftests/x86/check_cc.sh
>>>> @@ -7,7 +7,7 @@ CC="$1"
>>>>    TESTPROG="$2"
>>>>    shift 2
>>>>
>>>> -if "$CC" -o /dev/null "$TESTPROG" -O0 "$@" 2>/dev/null; then
>>>> +if $CC -o /dev/null "$TESTPROG" -O0 "$@" 2>/dev/null; then
>>>>        echo 1
>>>>    else
>>>>        echo 0
>>>>
>>>
>>> The intent is testing if $CC is set. Does this change work when
>>> $CC is not set?
>>
>> More by luck than judgement. Before and after.
>> If $CC might be empty you probably want:
>>
>> [ -n "$CC" ] && { echo 0; return; }
>>
>> The subject is also wrong. Should be "allow field splitting' of ${CC}.
>> (no brace or curly braces, not round ones.)
>>
> 
> Good points. It would be good enhancement to add the check - since the
> current logic doesn't handle the null CC
> 
I'll send a V2.
> thanks,
> -- Shuah
