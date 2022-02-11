Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE9A4B2B80
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Feb 2022 18:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351993AbiBKRNT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Feb 2022 12:13:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237798AbiBKRNT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Feb 2022 12:13:19 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D4F1FC
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Feb 2022 09:13:17 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id e11so6427628ils.3
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Feb 2022 09:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s7mGcCDwRakb27nJ+hvyeCmB5+buamXTCZy5wLIRtRg=;
        b=fdomvHt9zMMnngWxveYBK7C1iFPQy7YFQkSeuwToo7/UZg+ppFxZs0Fw3zN6ixIwaQ
         VXQnU2ouajTpSQ2eoUlvf6o71S1OtOngn9AI/mJVsIkvRwcTaJ+L2voh+dW10QNq9D9b
         8F1hoRb4YxlbTzngZ1UTU8CJDV5l4NpeIjmzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s7mGcCDwRakb27nJ+hvyeCmB5+buamXTCZy5wLIRtRg=;
        b=EIsaDd9/wqaYQh4eiaGopjdxf7vSJG4eEGup6VKLatkGd0RxmrsgRmMSCEmujO5rxk
         vQjWVMKZna55AFBDi4v05Iy1tGXAeYJsw15PAha/29C/r9rrMTrs1vnIwdF13//ziUMM
         gLL1hA/1zcH1wCGlJYbweElNwncX3VpHa0M4zPC4kkvq3nY4KFwgURPvywWtoGO8XVUN
         6Gtop3o1ZM0bLb7bBl2zxVLZ8HzxjhrGiVaVocTz+SDJNjP24Y9h5/Ikk5f0PU8mkv38
         RYJY/cycud+Slksu1bXCi68Hm18p/BC2O8ZXju0fNhgykG+xIl28MSTejvvy5+qKqOpH
         1t6g==
X-Gm-Message-State: AOAM532ElJYM0ZxGDv/NBUqwbJOeOxx6fgUFX4gyEwhiFWh2hIvPXgz8
        R2ht2+7HbkKqCoB6BANpnsvQHQ==
X-Google-Smtp-Source: ABdhPJzQxZAzYhrwCZEUCoks+3wdFiATxCz/aohhMfPrkypn1nXkiEYj5RZUxC0OLhuRar6INy0rHQ==
X-Received: by 2002:a92:1311:: with SMTP id 17mr1371108ilt.42.1644599597132;
        Fri, 11 Feb 2022 09:13:17 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id u8sm5050640ilb.39.2022.02.11.09.13.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 09:13:16 -0800 (PST)
Subject: Re: [PATCH 1/2] selftests: x86: allow expansion of $(CC)
To:     David Laight <David.Laight@ACULAB.COM>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
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
Cc:     "kernel@collabora.com" <kernel@collabora.com>,
        "kernelci@groups.io" <kernelci@groups.io>,
        "kernelci.org bot" <bot@kernelci.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220210190642.1477814-1-usama.anjum@collabora.com>
 <20220210190642.1477814-2-usama.anjum@collabora.com>
 <a34f2fc8-f4aa-fef4-d1dd-f3fdb5114f72@linuxfoundation.org>
 <99625ceecead4e9eb73de2fc8acb2ae9@AcuMS.aculab.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <7a501981-e4ce-fb08-7c1e-6aca26245cef@linuxfoundation.org>
Date:   Fri, 11 Feb 2022 10:13:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <99625ceecead4e9eb73de2fc8acb2ae9@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/11/22 9:47 AM, David Laight wrote:
> From: Shuah Khan
>> Sent: 10 February 2022 20:52
>>
>> On 2/10/22 12:06 PM, Muhammad Usama Anjum wrote:
>>> CC can have multiple sub-strings like "ccache gcc". Erorr pops up if
>>> it is treated as single string and double quote are used around it.
>>> This can be fixed by removing the quotes and not treating CC a single
>>> string.
>>>
>>> Fixes: e9886ace222e ("selftests, x86: Rework x86 target architecture detection")
>>> Reported-by: "kernelci.org bot" <bot@kernelci.org>
>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>> ---
>>>    tools/testing/selftests/x86/check_cc.sh | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/x86/check_cc.sh b/tools/testing/selftests/x86/check_cc.sh
>>> index 3e2089c8cf549..aff2c15018b53 100755
>>> --- a/tools/testing/selftests/x86/check_cc.sh
>>> +++ b/tools/testing/selftests/x86/check_cc.sh
>>> @@ -7,7 +7,7 @@ CC="$1"
>>>    TESTPROG="$2"
>>>    shift 2
>>>
>>> -if "$CC" -o /dev/null "$TESTPROG" -O0 "$@" 2>/dev/null; then
>>> +if $CC -o /dev/null "$TESTPROG" -O0 "$@" 2>/dev/null; then
>>>        echo 1
>>>    else
>>>        echo 0
>>>
>>
>> The intent is testing if $CC is set. Does this change work when
>> $CC is not set?
> 
> More by luck than judgement. Before and after.
> If $CC might be empty you probably want:
> 
> [ -n "$CC" ] && { echo 0; return; }
> 
> The subject is also wrong. Should be "allow field splitting' of ${CC}.
> (no brace or curly braces, not round ones.)
> 

Good points. It would be good enhancement to add the check - since the
current logic doesn't handle the null CC

thanks,
-- Shuah
